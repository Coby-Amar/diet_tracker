import 'dart:typed_data';
import 'package:diet_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final _picker = ImagePicker();

class ImageFormField extends StatelessWidget {
  final String label;
  final bool? isRequired;
  final Uint8List? initialValue;
  final void Function(Uint8List? image) onSaved;

  const ImageFormField({
    super.key,
    this.initialValue,
    this.isRequired = false,
    required this.label,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) => FormField<Uint8List>(
        onSaved: onSaved,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            (isRequired ?? false) && value == null ? 'תמונה נדרשת' : null,
        builder: (field) => SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final XFile? pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 50,
                      );
                      if (pickedFile != null) {
                        field.didChange(await pickedFile.readAsBytes());
                      }
                    },
                    child: Text(label),
                  ),
                  if (field.value != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.memory(
                        field.value!,
                        height: 100,
                        width: 100,
                      ),
                    ),
                ],
              ),
              Visibility(
                visible: field.hasError,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    field.errorText ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                    // style: TextStyle(
                    //   color: theme.colorScheme.error,
                    //   fontSize: theme.textTheme.bodySmall,
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
