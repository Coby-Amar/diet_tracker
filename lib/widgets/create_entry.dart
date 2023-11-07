import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/stores/products.dart';
import 'package:diet_tracker/widgets/app_autocomplete.dart';

class _CreateEntryFormState {
  ApiProduct? product;
  int? amount;
  _CreateEntryFormState({this.product, this.amount});
}

class CreateUpdateReportEntry extends StatelessWidget {
  final TextEditingController _controller = TextEditingController(text: "");
  final DisplayEntry? entry;
  final void Function(DisplayEntry? entryData) onSaved;
  final void Function(BuildContext) onDelete;
  CreateUpdateReportEntry({
    super.key,
    required this.onSaved,
    required this.onDelete,
    this.entry,
  });

  void _onSaved(_CreateEntryFormState? newValue) {
    if (newValue == null) return;
    final product = newValue.product;
    final entryAmount = newValue.amount;
    if (product == null || entryAmount == null) return;
    final amount = entryAmount / product.amount;
    final entry = DisplayEntry();
    entry.productId = newValue.product!.id;
    entry.amount = entryAmount;
    entry.carbohydrates = amount * product.carbohydrate;
    entry.proteins = amount * product.protein;
    entry.fats = amount * product.fat;
    onSaved(entry);
  }

  String? _onValidate(_CreateEntryFormState? value) {
    if (value == null) {
      return null;
    }
    final productEmpty = value.product == null;
    final amountEmpty = value.amount == null || value.amount == 0;
    if (!productEmpty && amountEmpty) {
      return 'כמות חייב להיות מספר גדול מ-0';
    }
    if (!amountEmpty && productEmpty) {
      return 'מוצר לא יכל להיות ריק';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductsStore>().products;
    return FormField<_CreateEntryFormState>(
      initialValue: _CreateEntryFormState(
        product: products
            .where((element) => element.id == entry?.productId)
            .firstOrNull,
        amount: entry?.amount,
      ),
      onSaved: _onSaved,
      validator: _onValidate,
      builder: (field) {
        final errorColor = Theme.of(context).colorScheme.error;
        final hasError = field.hasError;
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppAutocomplete<ApiProduct>(
                    initialValue: TextEditingValue(
                        text: field.value?.product?.name ?? ""),
                    label: 'מוצר',
                    errorText: hasError ? '' : null,
                    optionsBuilder: (textEditingValue) => products
                        .where((product) =>
                            product.name.contains(textEditingValue.text))
                        .toList(),
                    onSelected: (option) {
                      field.value!.product = option;
                      field.didChange(field.value);
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  child: TextField(
                    controller: _controller
                      ..text = field.value?.amount?.toString() ?? "",
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'כמות',
                      errorStyle: const TextStyle(height: 0),
                      errorText: hasError ? '' : null,
                    ),
                    onChanged: (newValue) {
                      field.value!.amount = int.tryParse(newValue) ?? 0;
                      field.didChange(field.value);
                    },
                  ),
                ),
              ],
            ),
            Visibility(
              visible: hasError,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(color: hasError ? errorColor : null),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
