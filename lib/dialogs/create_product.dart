import 'dart:io';

import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class CreateProductDialog extends StatefulWidget {
  const CreateProductDialog({super.key});

  @override
  State<CreateProductDialog> createState() => _CreateProductDialogState();
}

class _CreateProductDialogState extends State<CreateProductDialog> {
  final ImagePicker _picker = ImagePicker();
  String? _image;
  String _name = '';
  int _amount = 0;
  int _carbohydrate = 0;
  int _protein = 0;
  int _fat = 0;

  @override
  Widget build(BuildContext context) => DialogScaffoldForm(
        title: 'יצירת מוצר',
        onSuccess: () => ProductModel(
          image: _image,
          name: _name,
          amount: _amount,
          carbohydrate: _carbohydrate,
          protein: _protein,
          fat: _fat,
        ),
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
                        setState(() {
                          _image = pickedFile.path;
                        });
                      }
                    },
                    child: const Text('בחר תמונה'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Visibility(
                    visible: _image?.isNotEmpty ?? false,
                    child: Image.file(File(_image ?? '')),
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'שם'),
              validator: validations.required,
              onSaved: (newValue) => setState(() {
                _name = newValue!.trim();
              }),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'כמות'),
              keyboardType: TextInputType.number,
              validator: validations.compose([
                validations.required,
                validations.numberOnly,
              ]),
              onSaved: (newValue) => setState(() {
                _amount = int.parse(newValue!.trim());
              }),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'פחממה'),
              keyboardType: TextInputType.number,
              validator: validations.compose([
                validations.required,
                validations.numberOnly,
              ]),
              onSaved: (newValue) => setState(() {
                _carbohydrate = int.parse(newValue!.trim());
              }),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'חלבון'),
              keyboardType: TextInputType.number,
              validator: validations.compose([
                validations.required,
                validations.numberOnly,
              ]),
              onSaved: (newValue) => setState(() {
                _protein = int.parse(newValue!.trim());
              }),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'שומן'),
              keyboardType: TextInputType.number,
              validator: validations.compose([
                validations.required,
                validations.numberOnly,
              ]),
              onSaved: (newValue) => setState(() {
                _fat = int.parse(newValue!.trim());
              }),
            ),
          ],
        ),
      );
}
