import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/resources/extensions/numbers.extension.dart';
import 'package:diet_tracker/widgets/form/autocomplete.form.dart';
import 'package:diet_tracker/widgets/form/datepicker.field.form.dart';
import 'package:diet_tracker/widgets/form/model.form.dart';
import 'package:diet_tracker/widgets/form/scaffold.form.dart';

class UpdateReportPage extends StatelessWidget {
  const UpdateReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = GoRouterState.of(context).extra as Report;
    final products = context.read<AppProvider>().products;
    return ScaffoldForm(
      model: Report.fromJson(jsonDecode(model.toJson())),
      title: "Update Report",
      formSubmitText: "Update",
      onSuccess: (model) => context.read<AppProvider>().updateReport(model),
      formBuilder: (theme, validations, reportModel, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DatePickerFormField(
            label: 'Date',
            initialValue: reportModel.date,
            onSaved: (date) => reportModel.date = date!,
          ),
          Text('Total Fats: ${reportModel.totalFats.toDisplay}'),
          Text('Total Proteins: ${reportModel.totalProteins.toDisplay}'),
          Text(
              'Total Carbohydrates: ${reportModel.totalCarbohydrates.toDisplay}'),
          ...reportModel.entries.map(
            (e) => DisplayReportEntry(
              reportEntry: e,
              onDelete: () => setState(() => reportModel.removeEntry(e)),
            ),
          ),
          FormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (reportModel.entries.isEmpty) {
                return 'At least 1 Entry is required';
              }
              return null;
            },
            builder: (field) => ModelForm(
              canPop: false,
              model: ReportEntry(),
              onSuccess: (data) {
                final product = products
                    .firstWhere((element) => element.id == data.productId);
                final amount = data.quantity / product.quantity;
                data.carbohydrates = amount * product.carbohydrates;
                data.proteins = amount * product.proteins;
                data.fats = amount * product.fats;
                setState(() => reportModel.addEntry(data));
                field.didChange(null);
                return null;
              },
              buttonLabel: 'Add entry',
              formBuilder: (theme, validations, model) => [
                Row(children: [
                  Expanded(
                    child: AutoCompleteFormField(
                      label: 'Product',
                      validator: (value) => validations.isRequired(value?.id),
                      onSaved: (product) => model.productId = product!.id,
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      validator: validations.compose([
                        validations.isRequired,
                        validations.doubleOnly,
                      ]),
                      onSaved: (newValue) => model.quantity =
                          double.tryParse(newValue!.trim()) ?? 0,
                    ),
                  ),
                ]),
                Visibility(
                  visible: field.hasError,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      field.errorText ?? '',
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayReportEntry extends StatelessWidget {
  final ReportEntry reportEntry;
  final VoidCallback onDelete;
  const DisplayReportEntry({
    super.key,
    required this.reportEntry,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final product = context
        .read<AppProvider>()
        .products
        .firstWhere((e) => reportEntry.productId == e.id);
    return ListTile(
      leading: product.imageFileOrNull,
      title: Text(product.name),
      subtitle: Text('${reportEntry.quantity.toDisplay} ${product.units}'),
      trailing: IconButton.filledTonal(
        onPressed: onDelete,
        icon: const Icon(Icons.remove),
      ),
    );
  }
}
