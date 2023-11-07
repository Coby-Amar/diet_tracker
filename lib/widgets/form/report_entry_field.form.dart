import 'package:flutter/material.dart';

import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/models/base.dart';
import 'package:diet_tracker/widgets/report_entry.dart';

class ReportEntryFormFieldState {
  ApiProduct? apiProduct;
  int? amount;
  ReportEntryFormFieldState(
    this.apiProduct,
    this.amount,
  );
}

class ReportEntryFormField<T extends DisplayModel> extends StatelessWidget {
  final void Function(ReportEntryFormFieldState? entryData) onSaved;
  final ReportEntryFormFieldState? initialValue;
  const ReportEntryFormField({
    super.key,
    required this.onSaved,
    this.initialValue,
  });

  String? _onValidate(ReportEntryFormFieldState? value) {
    if (value == null) {
      return null;
    }
    final productEmpty = value.apiProduct == null;
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
    return FormField<ReportEntryFormFieldState>(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: _onValidate,
      builder: (field) {
        final errorColor = Theme.of(context).colorScheme.error;
        final hasError = field.hasError;
        return Column(
          children: [
            ReportEntry(
              amount: initialValue?.amount,
              productName: initialValue?.apiProduct?.name,
              hasError: hasError,
              onChangeAmount: (amount) {
                field.value?.amount = amount;
                field.didChange(field.value);
              },
              onChangeProduct: (product) {
                field.value?.apiProduct = product;
                field.didChange(field.value);
              },
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
