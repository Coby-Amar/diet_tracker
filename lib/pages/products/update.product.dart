import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/widgets/form/imagepicker.form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/widgets/form/scaffold.form.dart';

class UpdateProductPage extends StatelessWidget {
  const UpdateProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = GoRouterState.of(context).extra as Product;
    return ScaffoldForm(
      model: model,
      title: "Update Product",
      formSubmitText: "Update",
      onSuccess: (data) => context.read<AppProvider>().updateProduct(data),
      formBuilder: (theme, validations, field, setState) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageFormField(
            label: 'Select Image',
            initialValue: model.image,
            onSaved: (image) => model.image = image,
          ),
          TextFormField(
            initialValue: model.name,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: validations.isRequired,
            onSaved: (newValue) => model.name = newValue!.trim(),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            initialValue: model.quantity.toString(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'Quantity'),
            validator: validations.compose([
              validations.isRequired,
              validations.doubleOnly,
            ]),
            onSaved: (newValue) =>
                model.quantity = double.tryParse(newValue!.trim()) ?? 0,
          ),
          TextFormField(
            initialValue: model.units,
            validator: validations.isRequired,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'Unit'),
            onSaved: (newValue) => model.units = newValue!.trim(),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            initialValue: model.carbohydrates.toString(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'Carbohydrates'),
            validator: validations.compose([
              validations.isRequired,
              validations.doubleOnly,
            ]),
            onSaved: (newValue) =>
                model.carbohydrates = double.tryParse(newValue!.trim()) ?? 0,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            initialValue: model.proteins.toString(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'Proteins'),
            validator: validations.compose([
              validations.isRequired,
              validations.doubleOnly,
            ]),
            onSaved: (newValue) =>
                model.proteins = double.parse(newValue!.trim()),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            initialValue: model.fats.toString(),
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'Fats'),
            validator: validations.compose([
              validations.isRequired,
              validations.doubleOnly,
            ]),
            onSaved: (newValue) =>
                model.fats = double.tryParse(newValue!.trim()) ?? 0,
          ),
        ],
      ),
    );
  }
}
