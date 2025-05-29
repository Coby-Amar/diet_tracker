import 'package:diet_tracker/resources/extensions/numbers.extension.dart';
import 'package:diet_tracker/resources/provider.dart';
import 'package:diet_tracker/widgets/form/scaffold.form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyLimitPage extends StatelessWidget {
  const DailyLimitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.read<AppProvider>();
    return ScaffoldForm(
      title: "הגדרת מכסה יומי",
      formSubmitText: "עדכן",
      model: appProvider.dailyLimit,
      onSuccess: (model) async {
        try {
          await appProvider.setDailyLimit(model);
          return true;
        } catch (e) {
          return false;
        }
      },
      formBuilder: (theme, validations, model, setState) => Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            initialValue: model.totalCarbohydrates.toDisplay,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'פחממה'),
            validator: validations.compose([
              validations.isRequired,
              validations.doubleOnly,
            ]),
            onSaved: (newValue) => model.totalCarbohydrates =
                double.tryParse(newValue!.trim()) ?? 0,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            initialValue: model.totalProteins.toDisplay,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'חלבון'),
            validator: validations.compose([
              validations.isRequired,
              validations.doubleOnly,
            ]),
            onSaved: (newValue) =>
                model.totalProteins = double.parse(newValue!.trim()),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            initialValue: model.totalFats.toDisplay,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'שומן'),
            validator: validations.compose([
              validations.isRequired,
              validations.doubleOnly,
            ]),
            onSaved: (newValue) =>
                model.totalFats = double.tryParse(newValue!.trim()) ?? 0,
          ),
        ],
      ),
    );
  }
}
