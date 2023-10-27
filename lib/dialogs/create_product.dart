import 'dart:io';

import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models/create.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class CreateProductDialog extends StatefulWidget {
  const CreateProductDialog({super.key});

  @override
  State<CreateProductDialog> createState() => _CreateProductDialogState();
}

class _CreateProductDialogState extends State<CreateProductDialog> {
  final ImagePicker _picker = ImagePicker();
  final CreateProduct _productModel = CreateProduct.empty();

  @override
  Widget build(BuildContext context) => DialogScaffoldForm(
        title: 'יצירת מוצר',
        onSuccess: () => _productModel,
        formBuilder: (theme, validations) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () async {
                      final XFile? pickedFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() => _productModel.image = pickedFile.path);
                      }
                    },
                    child: const Text('בחר תמונה'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Visibility(
                    visible: _productModel.image?.isNotEmpty ?? false,
                    child: Image.file(File(_productModel.image ?? '')),
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'שם'),
              validator: validations.required,
              onSaved: (newValue) => setState(() {
                _productModel.name = newValue!.trim();
              }),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'כמות'),
              keyboardType: TextInputType.number,
              validator: validations.compose([
                validations.required,
                validations.numberOnly,
              ]),
              onSaved: (newValue) => setState(
                () =>
                    _productModel.amount = int.tryParse(newValue!.trim()) ?? 0,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'פחממה'),
              keyboardType: TextInputType.number,
              validator: validations.compose([
                validations.required,
                validations.numberOnly,
              ]),
              onSaved: (newValue) => setState(
                () => _productModel.carbohydrate =
                    int.tryParse(newValue!.trim()) ?? 0,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'חלבון'),
              keyboardType: TextInputType.number,
              validator: validations.compose([
                validations.required,
                validations.numberOnly,
              ]),
              onSaved: (newValue) => setState(
                () => _productModel.protein = int.parse(newValue!.trim()),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'שומן'),
              keyboardType: TextInputType.number,
              validator: validations.compose([
                validations.required,
                validations.numberOnly,
              ]),
              onSaved: (newValue) => setState(
                () => _productModel.fat = int.tryParse(newValue!.trim()) ?? 0,
              ),
            ),
          ],
        ),
      );
}
