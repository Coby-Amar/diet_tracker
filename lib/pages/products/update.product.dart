import 'dart:io';

import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProductPage extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  UpdateProductPage({super.key});

  Future<bool> onFormSuccess(
    BuildContext? context,
  ) async {
    if (context != null) {
      // final productsStore = context.read<ProductsStore>();
      // await productsStore.update(_model);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final _model = GoRouterState.of(context).extra as DisplayProductModel;
    return ScaffoldForm(
      title: "עדכון מוצר",
      formSubmitText: "עדכן",
      onSuccess: (_) async {
        final productsStore = context.read<ProductsStore>();
        await productsStore.update(_model);
        return true;
      },
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
                      _model.image = pickedFile.path;
                    }
                  },
                  child: const Text('בחר תמונה'),
                ),
              ),
              Expanded(
                flex: 1,
                child: Visibility(
                  visible: _model.image?.isNotEmpty ?? false,
                  child: Observer(
                    builder: (context) => Image.file(File(_model.image ?? '')),
                  ),
                ),
              ),
            ],
          ),
          TextFormField(
            initialValue: _model.name,
            decoration: const InputDecoration(labelText: 'שם'),
            validator: validations.required,
            onSaved: (newValue) => _model.name = newValue!.trim(),
          ),
          TextFormField(
            initialValue: _model.amount.toString(),
            decoration: const InputDecoration(labelText: 'כמות'),
            keyboardType: TextInputType.number,
            validator: validations.compose([
              validations.required,
              validations.numberOnly,
            ]),
            onSaved: (newValue) =>
                _model.amount = int.tryParse(newValue!.trim()) ?? 0,
          ),
          TextFormField(
            initialValue: _model.carbohydrate.toString(),
            decoration: const InputDecoration(labelText: 'פחממה'),
            keyboardType: TextInputType.number,
            validator: validations.compose([
              validations.required,
              validations.numberOnly,
            ]),
            onSaved: (newValue) =>
                _model.carbohydrate = int.tryParse(newValue!.trim()) ?? 0,
          ),
          TextFormField(
            initialValue: _model.protein.toString(),
            decoration: const InputDecoration(labelText: 'חלבון'),
            keyboardType: TextInputType.number,
            validator: validations.compose([
              validations.required,
              validations.numberOnly,
            ]),
            onSaved: (newValue) => _model.protein = int.parse(newValue!.trim()),
          ),
          TextFormField(
            initialValue: _model.fat.toString(),
            decoration: const InputDecoration(labelText: 'שומן'),
            keyboardType: TextInputType.number,
            validator: validations.compose([
              validations.required,
              validations.numberOnly,
            ]),
            onSaved: (newValue) =>
                _model.fat = int.tryParse(newValue!.trim()) ?? 0,
          ),
        ],
      ),
    );
  }
}
