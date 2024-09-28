import 'dart:io';
import 'package:diet_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final _picker = ImagePicker();

class ImageFormField extends StatelessWidget {
  final String label;
  final bool? isRequired;
  final File? initialValue;
  final void Function(File? image) onSaved;

  const ImageFormField({
    super.key,
    this.initialValue,
    this.isRequired = false,
    required this.label,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) => FormField<File>(
        onSaved: onSaved,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            (isRequired ?? false) && value == null ? 'Image is required' : null,
        builder: (field) => SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final XFile? pickedFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        field.didChange(File(pickedFile.path));
                      }
                    },
                    child: const Text('Select Image'),
                  ),
                  if (field.value != null)
                    Image.file(
                      field.value!,
                      height: 100,
                      width: 100,
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
