import 'package:diet_tracker/dialogs/error.dialog.dart';
import 'package:diet_tracker/resources/extensions/numbers.extension.dart';
import 'package:diet_tracker/widgets/form/checkbox.form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/widgets/form/imagepicker.form.dart';
import 'package:diet_tracker/widgets/form/scaffold.form.dart';
import 'package:diet_tracker/resources/models.dart';

class CreateUpdateProductPage extends StatelessWidget with OpenError {
  const CreateUpdateProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final goState = GoRouterState.of(context);
    final model = goState.extra as Product? ?? Product();
    final isCreate = model.id == -1;
    final name = isCreate ? 'יצירת' : 'עדכון';
    return ScaffoldForm(
      model: model,
      title: "$name מוצר",
      formSubmitText: name,
      onSuccess: (data) async {
        final appProvider = context.read<AppProvider>();
        try {
          if (isCreate) {
            await appProvider.addProduct(data);
          } else {
            await appProvider.updateProduct(data);
          }
          return true;
        } catch (e) {
          if (context.mounted) {
            showSnackBar(
              context,
              ErrorDialog(
                content: Text("$name המוצר נכשלה"),
              ),
            );
          }
          return false;
        }
      },
      formBuilder: (theme, validations, field, setState) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageFormField(
            label: 'בחר תמונה',
            initialValue: model.image,
            onSaved: (image) => model.image = image,
          ),
          TextFormField(
            initialValue: model.name,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'שם'),
            validator: validations.compose([
              validations.isRequired,
              (value) => validations.minMax(value, min: 3, max: 32),
            ]),
            onSaved: (newValue) => model.name = newValue!.trim(),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            initialValue: model.quantity.toDisplay,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'כמות'),
            validator: validations.compose([
              validations.isRequired,
              validations.doubleOnly,
            ]),
            onSaved: (newValue) =>
                model.quantity = double.tryParse(newValue!.trim()) ?? 0,
          ),
          DropdownButtonFormField<Units>(
            decoration: const InputDecoration(labelText: 'יחידה'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            value: model.units,
            validator: validations.compose([
              validations.isRequired,
            ]),
            items: Units.values
                .map(
                  (value) => DropdownMenuItem<Units>(
                    value: value,
                    child: Text(value.translation),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                model.units = value;
              }
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            initialValue: model.carbohydrates.toDisplay,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'פחממה'),
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
            initialValue: model.proteins.toDisplay,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'חלבון'),
            validator: validations.compose([
              validations.isRequired,
              validations.doubleOnly,
            ]),
            onSaved: (newValue) =>
                model.proteins = double.parse(newValue!.trim()),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            initialValue: model.fats.toDisplay,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'שומן'),
            validator: validations.compose([
              validations.isRequired,
              validations.doubleOnly,
            ]),
            onSaved: (newValue) =>
                model.fats = double.tryParse(newValue!.trim()) ?? 0,
          ),
          CheckboxFormField(
            initialValue: model.cooked,
            label: "מבושל",
            onSaved: (newValue) => model.cooked = newValue ?? false,
          ),
        ],
      ),
    );
  }
}
