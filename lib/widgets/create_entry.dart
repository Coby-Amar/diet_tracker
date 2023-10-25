import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/stores/products.dart';
import 'package:diet_tracker/widgets/app_autocomplete.dart';
import 'package:diet_tracker/resources/models.dart';

class CreateEntryFormFieldValue {
  ProductModel? product;
  int amount;
  CreateEntryFormFieldValue({this.product, this.amount = 0});
}

class CreateEntry extends StatelessWidget {
  final DateTime date;
  final void Function(CreateEntryFormFieldValue? entryData) onSaved;
  final void Function(BuildContext) onDelete;
  const CreateEntry({
    super.key,
    required this.date,
    required this.onSaved,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductsStore>().products;
    return FormField<CreateEntryFormFieldValue>(
      onSaved: onSaved,
      validator: (value) {
        if (value == null) {
          return 'מוצר וכמות לא יכלים להיות רקים';
        }
        if (value.product == null) {
          return 'מוצר לא יכל להיות ריק';
        }
        if (value.amount == 0) {
          return 'כמות לא יכל להיות ריק או 0';
        }
        return null;
      },
      builder: (field) {
        final errorColor = Theme.of(context).colorScheme.error;
        final hasError = field.hasError;
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppAutocomplete<ProductModel>(
                    label: 'מוצר',
                    errorText: hasError ? '' : null,
                    optionsBuilder: (textEditingValue) => products
                        .where((product) =>
                            product.name.contains(textEditingValue.text))
                        .toList(),
                    onSelected: (option) => field.didChange(
                      CreateEntryFormFieldValue(
                        product: option,
                        amount: field.value?.amount ?? 0,
                      ),
                    ),
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
                    onChanged: (newValue) => field.didChange(
                      CreateEntryFormFieldValue(
                        product: field.value?.product,
                        amount: int.tryParse(newValue) ?? 0,
                      ),
                    ),
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
