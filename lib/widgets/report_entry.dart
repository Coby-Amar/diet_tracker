import 'package:diet_tracker/resources/models/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/stores/products.dart';
import 'package:diet_tracker/widgets/app_autocomplete.dart';

class ReportEntry extends StatelessWidget {
  final void Function(ApiProduct product) onChangeProduct;
  final void Function(int amount) onChangeAmount;
  final String? productName;
  final int? amount;
  final bool hasError;
  const ReportEntry({
    super.key,
    required this.onChangeProduct,
    required this.onChangeAmount,
    this.productName,
    this.amount,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductsStore>().products;
    return Row(
      children: [
        Expanded(
          child: AppAutocomplete<ApiProduct>(
            label: 'מוצר',
            errorText: hasError ? '' : null,
            initialValue: TextEditingValue(text: productName ?? ""),
            optionsBuilder: (textEditingValue) => products
                .where(
                    (product) => product.name.contains(textEditingValue.text))
                .toList(),
            onSelected: onChangeProduct,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextFormField(
            initialValue: amount?.toString(),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'כמות',
              errorStyle: const TextStyle(height: 0),
              errorText: hasError ? '' : null,
            ),
            onChanged: (value) {
              final parsedValue = int.tryParse(value) ?? 0;
              onChangeAmount(parsedValue);
            },
          ),
        ),
      ],
    );
  }
}
