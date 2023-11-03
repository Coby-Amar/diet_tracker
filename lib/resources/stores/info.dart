import 'package:mobx/mobx.dart';

import 'package:diet_tracker/resources/api/auth.dart';
import 'package:diet_tracker/resources/models/create.dart';
import 'package:diet_tracker/resources/models/display.dart';

part 'info.g.dart';

class InfoStore extends _InfoStore with _$InfoStore {}

abstract class _InfoStore with Store {
  final _authApi = AuthApi();

  @observable
  DisplayUser? user;

  @computed
  bool get isLoggedIn {
    return user != null;
  }

  @action
  Future<void> getUser() async {
    final result = await _authApi.user();
    if (result != null) {
      user = DisplayUser(result);
    }
  }

  @action
  Future<void> register(CreateRegistration model) async {
    final result = await _authApi.register(model);
    if (result != null) {
      user = DisplayUser(result);
    }
  }

  @action
  Future<void> login(CreateLogin loginModel) async {
    final result = await _authApi.login(loginModel);
    if (result != null) {
      user = DisplayUser(result);
    }
  }

  @action
  Future<void> logout() async {
    final result = await _authApi.logout();
    if (result) {
      user = null;
    }
  }
}
