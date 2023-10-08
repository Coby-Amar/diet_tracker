import 'package:diet_tracker/widgets/app_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/validations.dart';
import 'package:diet_tracker/providers/models.dart';
import 'package:diet_tracker/providers/products.dart';

class CreateEntryFormFieldValue {
  ProductModel? product;
  int amount;
  CreateEntryFormFieldValue({this.product, this.amount = 0});
}

class CreateEntry extends StatelessWidget {
  final DateTime date;
  final void Function(CreateEntryFormFieldValue? entryData) onSaved;
  const CreateEntry({
    super.key,
    required this.date,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductsProvider>().products;
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
        return Row(
          children: [
            Expanded(
              child: AppAutocomplete<ProductModel>(
                label: 'מוצר',
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
                decoration: const InputDecoration(labelText: 'כמות'),
                onChanged: (newValue) => field.didChange(
                  CreateEntryFormFieldValue(
                    product: field.value?.product,
                    amount: int.tryParse(newValue) ?? 0,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
