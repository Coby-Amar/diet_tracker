import 'package:diet_tracker/resources/models/display.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_tracker/pages/register.dart';
import 'package:diet_tracker/resources/stores/info.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _createLoginModel = Login();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authStore = context.read<InfoStore>();
    return Scaffold(
      appBar: const AppBarThemed(
        title: 'ברוך הבא',
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: theme.cardColor,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: "cobyamar@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          label: Text("שם משתמש/מייל"),
                        ),
                        onSaved: (newValue) => setState(
                            () => _createLoginModel.username = newValue!),
                      ),
                      TextFormField(
                        initialValue: "123456789",
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          label: Text("סיסמה"),
                        ),
                        onSaved: (newValue) => setState(
                            () => _createLoginModel.password = newValue!),
                      ),
                      Row(
                        children: [
                          const Text("משתמש חדש?"),
                          TextButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => const RegisterPage(),
                            ),
                            child: Text(
                              "לחץ כאן",
                              style: TextStyle(color: theme.primaryColorDark),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
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
                    final goNamed = context.goNamed;
                    await authStore.login(_createLoginModel);
                    if (authStore.isLoggedIn) {
                      goNamed("home");
                    }
                  },
                  child: const Text("התחבר"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
