import 'package:diet_tracker/resources/models/create.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/stores/products.dart';
import 'package:diet_tracker/widgets/app_autocomplete.dart';

class _CreateEntryFormState {
  DisplayProduct? product;
  int? amount;
}

class CreateReportEntry extends StatelessWidget {
  final void Function(CreateEntry? entryData) onSaved;
  final void Function(BuildContext) onDelete;
  const CreateReportEntry({
    super.key,
    required this.onSaved,
    required this.onDelete,
  });

  void _onSaved(_CreateEntryFormState? newValue) {
    if (newValue == null) return;
    final product = newValue.product!;
    final entryAmount = newValue.amount!;
    final amount = entryAmount / product.amount;
    final entry = CreateEntry.empty();
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
      // return 'מוצר וכמות לא יכלים להיות רקים';
    }
    if (value.product == null) {
      return 'מוצר לא יכל להיות ריק';
    }
    if (value.amount == null || value.amount == 0) {
      return 'כמות חייב להיות מספר גדול מ-0';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductsStore>().products;
    return FormField<_CreateEntryFormState>(
      initialValue: _CreateEntryFormState(),
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
                  child: AppAutocomplete<DisplayProduct>(
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'כמות',
                      errorStyle: const TextStyle(height: 0),
                      errorText: hasError ? '' : null,
                    ),
                    onSubmitted: (newValue) {
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
