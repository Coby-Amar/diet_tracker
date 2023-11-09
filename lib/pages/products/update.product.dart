import 'package:diet_tracker/dialogs/dialog_scaffold_form.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/products.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UpdateProductPage extends StatelessWidget {
  const UpdateProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = GoRouterState.of(context).extra as DisplayProductModel;
    return ScaffoldForm(
      title: "עדכון מוצר",
      formSubmitText: "עדכן",
      onSuccess: (_) async {
        final productsStore = context.read<ProductsStore>();
        await productsStore.update(model);
        return true;
      },
      formBuilder: (theme, validations) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 3,
          //       child: ElevatedButton(
          //         onPressed: () async {
          //           final ImagePicker _picker = ImagePicker();
          //           final XFile? pickedFile =
          //               await _picker.pickImage(source: ImageSource.gallery);
          //           if (pickedFile != null) {
          //             model.image = pickedFile.path;
          //           }
          //         },
          //         child: const Text('בחר תמונה'),
          //       ),
          //     ),
          //     Expanded(
          //       flex: 1,
          //       child: Visibility(
          //         visible: model.image?.isNotEmpty ?? false,
          //         child: Observer(
          //           builder: (context) => Image.file(File(model.image ?? '')),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          TextFormField(
            initialValue: model.name,
            decoration: const InputDecoration(labelText: 'שם'),
            validator: validations.required,
            onSaved: (newValue) => model.name = newValue!.trim(),
          ),
          TextFormField(
            initialValue: model.amount.toString(),
            decoration: const InputDecoration(labelText: 'כמות'),
            keyboardType: TextInputType.number,
            validator: validations.compose([
              validations.required,
              validations.numberOnly,
            ]),
            onSaved: (newValue) =>
                model.amount = int.tryParse(newValue!.trim()) ?? 0,
          ),
          TextFormField(
            initialValue: model.carbohydrate.toString(),
            decoration: const InputDecoration(labelText: 'פחממה'),
            keyboardType: TextInputType.number,
            validator: validations.compose([
              validations.required,
              validations.numberOnly,
            ]),
            onSaved: (newValue) =>
                model.carbohydrate = int.tryParse(newValue!.trim()) ?? 0,
          ),
          TextFormField(
            initialValue: model.protein.toString(),
            decoration: const InputDecoration(labelText: 'חלבון'),
            keyboardType: TextInputType.number,
            validator: validations.compose([
              validations.required,
              validations.numberOnly,
            ]),
            onSaved: (newValue) => model.protein = int.parse(newValue!.trim()),
          ),
          TextFormField(
            initialValue: model.fat.toString(),
            decoration: const InputDecoration(labelText: 'שומן'),
            keyboardType: TextInputType.number,
            validator: validations.compose([
              validations.required,
              validations.numberOnly,
            ]),
            onSaved: (newValue) =>
                model.fat = int.tryParse(newValue!.trim()) ?? 0,
          ),
        ],
      ),
    );
  }
}
