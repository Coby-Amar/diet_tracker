import 'package:diet_tracker/providers/auth.dart';
import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const AppBarThemed(
        title: 'Login',
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
                    final response =
                        await authProvider.login(username, password);
                    if (response) {
                      navigator.pushReplacementNamed("home");
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
