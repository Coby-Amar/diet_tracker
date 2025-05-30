import 'package:diet_tracker/dialogs/error.dialog.dart';
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

class CreateUpdateReportPage extends StatelessWidget with OpenError {
  const CreateUpdateReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final goState = GoRouterState.of(context);
    final model = goState.extra as Report? ?? Report(entries: {});
    final isCreate = model.id == -1;
    final appProvider = context.read<AppProvider>();
    final products = appProvider.products;
    final name = isCreate ? 'יצירת' : 'עדכון';
    return ScaffoldForm(
      model: Report.fromJson(model.toJson()),
      title: "$name דוח",
      formSubmitText: name,
      onSuccess: (model) async {
        try {
          if (isCreate) {
            await appProvider.addReport(model);
          } else {
            await appProvider.updateReport(model);
          }
          return true;
        } catch (e) {
          if (context.mounted) {
            showSnackBar(
              context,
              ErrorDialog(content: Text("$name הדוח נכשלה")),
            );
          }
          return false;
        }
      },
      formBuilder: (theme, validations, reportModel, setState) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DatePickerFormField(
              label: 'תאריך',
              initialValue: reportModel.date,
              onSaved: (date) => reportModel.date = date!,
            ),
            Text('סה"כ שומנים: ${reportModel.totalFats.toEmptyDisplay}'),
            Text('סה"כ חלבון: ${reportModel.totalProteins.toEmptyDisplay}'),
            Text(
                'סה"כ פחממה: ${reportModel.totalCarbohydrates.toEmptyDisplay}'),
            FormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (reportModel.entries.isEmpty) {
                  return 'נדרשת הרשמה אחת לפחות';
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
                buttonLabel: 'הוסף הרשמה',
                formBuilder: (theme, validations, model) => [
                  Row(children: [
                    Expanded(
                      child: AutoCompleteFormField(
                        label: 'מוצר',
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
                        decoration: const InputDecoration(labelText: 'כמות'),
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
            Expanded(
              child: ListView.separated(
                itemCount: reportModel.entries.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final entry = reportModel.entries.elementAt(index);
                  final product =
                      products.firstWhere((e) => entry.productId == e.id);
                  return ListTile(
                    leading: product.imageOrDefault,
                    title: Text(product.name),
                    subtitle: Text(
                        '${entry.quantity.toDisplay} ${product.units.translation}'),
                    trailing: IconButton.filledTonal(
                      onPressed: () =>
                          setState(() => reportModel.removeEntry(entry)),
                      icon: const Icon(Icons.remove),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
