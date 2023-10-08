import 'dart:io';

import 'package:diet_tracker/providers/models.dart';
import 'package:flutter/material.dart';

import 'package:diet_tracker/validations.dart';
import 'package:image_picker/image_picker.dart';

class CreateEditProductDialog extends StatefulWidget {
  const CreateEditProductDialog({super.key});

  @override
  State<CreateEditProductDialog> createState() =>
      _CreateEditProductDialogState();
}

class _CreateEditProductDialogState extends State<CreateEditProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String? _image;
  String _name = '';
  int _amount = 0;
  int _carbohydrate = 0;
  int _protein = 0;
  int _fat = 0;

  @override
  Widget build(BuildContext context) {
    final validations = Validations();
    return Scaffold(
      appBar: AppBar(
        title: const Text('יצירת מוצר'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () async {
                        final XFile? pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery);
                        // FilePickerResult? result =
                        //     await FilePicker.platform.pickFiles();
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
                initialValue: '1',
                decoration: const InputDecoration(labelText: 'כמות'),
                validator: validations.compose([
                  validations.required,
                  validations.numberOnly,
                ]),
                onSaved: (newValue) => setState(() {
                  _amount = int.parse(newValue!.trim());
                }),
              ),
              TextFormField(
                initialValue: '0',
                decoration: const InputDecoration(labelText: 'פחממה'),
                validator: validations.compose([
                  validations.required,
                  validations.numberOnly,
                ]),
                onSaved: (newValue) => setState(() {
                  _carbohydrate = int.parse(newValue!.trim());
                }),
              ),
              TextFormField(
                initialValue: '0',
                decoration: const InputDecoration(labelText: 'חלבון'),
                validator: validations.compose([
                  validations.required,
                  validations.numberOnly,
                ]),
                onSaved: (newValue) => setState(() {
                  _protein = int.parse(newValue!.trim());
                }),
              ),
              TextFormField(
                initialValue: '0',
                decoration: const InputDecoration(labelText: 'שומן'),
                validator: validations.compose([
                  validations.required,
                  validations.numberOnly,
                ]),
                onSaved: (newValue) => setState(() {
                  _fat = int.parse(newValue!.trim());
                }),
              ),
              ElevatedButton(
                onPressed: () {
                  final result = _formKey.currentState?.validate();
                  if (result == null || !result) {
                    return;
                  }
                  _formKey.currentState?.save();
                  Navigator.of(context).pop(ProductModel(
                    image: _image,
                    name: _name,
                    amount: _amount,
                    carbohydrate: _carbohydrate,
                    protein: _protein,
                    fat: _fat,
                  ));
                },
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
