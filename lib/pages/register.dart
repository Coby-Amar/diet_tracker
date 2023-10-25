import 'package:diet_tracker/resources/stores/auth.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String name = '';
  String phonenumber = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authStore = context.read<AuthStore>();
    return Scaffold(
      appBar: const AppBarThemed(
        title: 'Register',
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
                  children: [
                    TextFormField(
                      initialValue: "cobyamar@gmail.com",
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text("שם משתמש/מייל"),
                      ),
                      onSaved: (newValue) =>
                          setState(() => username = newValue!),
                    ),
                    TextFormField(
                      initialValue: "123456789",
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        label: Text("סיסמה"),
                      ),
                      onSaved: (newValue) =>
                          setState(() => password = newValue!),
                    ),
                    TextFormField(
                      initialValue: "קובי עמר",
                      decoration: const InputDecoration(
                        label: Text("שם מלא"),
                      ),
                      onSaved: (newValue) => setState(() => name = newValue!),
                    ),
                    TextFormField(
                      initialValue: "0526161014",
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        label: Text("מספר טלפון"),
                      ),
                      onSaved: (newValue) =>
                          setState(() => phonenumber = newValue!),
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
                    await authStore.register(
                      username,
                      password,
                      name,
                      phonenumber,
                    );
                    if (authStore.loggedIn) {
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
