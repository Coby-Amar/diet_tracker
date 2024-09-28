import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/widgets/form/imagepicker.form.dart';
import 'package:diet_tracker/widgets/form/scaffold.form.dart';
import 'package:diet_tracker/resources/models.dart';

class CreateProductPage extends StatelessWidget {
  const CreateProductPage({super.key});

  @override
  Widget build(BuildContext context) => ScaffoldForm(
        model: Product(),
        title: "Add Product",
        onSuccess: (model) => context.read<AppProvider>().addProduct(model),
        formBuilder: (theme, validations, model, setState) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageFormField(
              label: 'Select Image',
              onSaved: (image) => model.image = image,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              validator: validations.isRequired,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Name'),
              onSaved: (newValue) => model.name = newValue!.trim(),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Unit'),
              validator: validations.isRequired,
              onSaved: (newValue) => model.units = newValue!.trim(),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Carbohydrate'),
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Protein'),
              validator: validations.compose([
                validations.isRequired,
                validations.doubleOnly,
              ]),
              onSaved: (newValue) =>
                  model.proteins = double.parse(newValue!.trim()),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Fat'),
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
