import 'package:diet_tracker/resources/api/auth.dart';
import 'package:mobx/mobx.dart';

part 'auth.g.dart';

class AuthStore extends AauthStore with _$AuthStore {}

abstract class AauthStore with Store {
  final _authApi = AuthApi();

  @observable
  bool loggedIn = false;

  @action
  Future<void> checkIfLoggedIn() async {
    await _authApi.loggedInCheck();
    loggedIn = true;
  }

  @action
  Future<void> register(
    String username,
    String password,
    String name,
    String phonenumber,
  ) async {
    final result =
        await _authApi.register(username, password, name, phonenumber);
    loggedIn = result;
  }

  @action
  Future<void> login(String username, String password) async {
    final result = await _authApi.login(username, password);
    loggedIn = result;
  }

  @action
  Future<void> logout() async {
    await _authApi.logout();
    loggedIn = false;
  }
}
