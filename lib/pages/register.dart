import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/resources/models/display.dart';
import 'package:diet_tracker/resources/stores/info.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final model = Registration();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authStore = context.read<InfoStore>();
    return Scaffold(
      appBar: const AppBarThemed(
        title: 'הרשמה',
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                color: theme.cardColor,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: "cobyamar@gmail.com",
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text("שם משתמש/מייל"),
                      ),
                      onSaved: (newValue) =>
                          setState(() => model.username = newValue!),
                    ),
                    TextFormField(
                      initialValue: "123456789",
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        label: Text("סיסמה"),
                      ),
                      onSaved: (newValue) =>
                          setState(() => model.password = newValue!),
                    ),
                    TextFormField(
                      initialValue: "קובי עמר",
                      decoration: const InputDecoration(
                        label: Text("שם מלא"),
                      ),
                      onSaved: (newValue) =>
                          setState(() => model.name = newValue!),
                    ),
                    TextFormField(
                      initialValue: "0526161014",
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        label: Text("מספר טלפון"),
                      ),
                      onSaved: (newValue) =>
                          setState(() => model.phonenumber = newValue!),
                    ),
                    const Text(
                      "הגבלה יומית",
                      style: TextStyle(
                        fontSize: 24,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextFormField(
                      initialValue: "1",
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("פחממותה"),
                      ),
                      onSaved: (newValue) => setState(() =>
                          model.carbohydrate = int.tryParse(newValue!) ?? 0),
                    ),
                    TextFormField(
                      initialValue: "1",
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("חלבון"),
                      ),
                      onSaved: (newValue) => setState(
                          () => model.protein = int.tryParse(newValue!) ?? 0),
                    ),
                    TextFormField(
                      initialValue: "1",
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("שומן"),
                      ),
                      onSaved: (newValue) => setState(
                          () => model.fat = int.tryParse(newValue!) ?? 0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    final result = _formKey.currentState?.validate();
                    if (result == null || !result) {
                      return;
                    }
                    _formKey.currentState?.save();
                    final navigator = Navigator.of(context);
                    await authStore.register(model);
                    if (authStore.isLoggedIn) {
                      navigator.pushReplacementNamed("home");
                    }
                  },
                  child: const Text("הרשם"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
