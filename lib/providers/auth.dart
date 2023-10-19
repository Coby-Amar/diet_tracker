import 'package:diet_tracker/providers/api.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String userId = '';
  bool isLoggedIn = false;

  AuthProvider();

  Future<void> checkIfLoggedin() async {
    try {
      await APIProvider.healthCheck();
      isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      isLoggedIn = false;
      notifyListeners();
    }
  }

  Future<void> login(String username, String password) async {
    try {
      await APIProvider.login(username, password);
      isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout(bool force) async {
    if (!isLoggedIn) {
      return;
    }
    if (force) {
      isLoggedIn = false;
      notifyListeners();
      return;
    }
    try {
      await APIProvider.logout();
      isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
