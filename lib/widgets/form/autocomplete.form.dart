import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/resources/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AutoCompleteFormField extends StatelessWidget {
  final String label;
  final Product? initialValue;
  final void Function(Product? date) onSaved;
  final String? Function(Product?)? validator;
  const AutoCompleteFormField({
    super.key,
    this.initialValue,
    this.validator,
    required this.label,
    required this.onSaved,
  });
  @override
  Widget build(BuildContext context) => FormField<Product>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSaved: onSaved,
        initialValue: initialValue,
        validator: validator,
        builder: (field) {
          final products = context.read<AppProvider>().products;
          return LayoutBuilder(
            builder: (context, constraints) => RawAutocomplete<Product>(
              displayStringForOption: (option) => option.name,
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return products;
                }
                return products.where((suggestion) => suggestion.name
                    .contains(textEditingValue.text.toLowerCase()));
              },
              fieldViewBuilder: (context, controller, focusNode, _) =>
                  TextField(
                      controller: controller,
                      focusNode: focusNode,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        label: Text(label),
                        errorText: field.errorText,
                      )),
              optionsViewBuilder: (context, onSelected, options) => Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 2,
                  borderOnForeground: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(4.0)),
                  ),
                  child: SizedBox(
                    height: 52.0 * options.length,
                    width: constraints.biggest.width, // <-- Right here !
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      shrinkWrap: false,
                      itemBuilder: (BuildContext context, int index) {
                        final option = options.elementAt(index);
                        return InkWell(
                          onTap: () {
                            field.didChange(option);
                            onSelected(option);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                if (option.image != null)
                                  Image.file(
                                    option.image!,
                                    width: 25,
                                    height: 25,
                                  ),
                                Text(option.name),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
}
