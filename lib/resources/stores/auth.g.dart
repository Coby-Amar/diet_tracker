// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AauthStore, Store {
  late final _$loggedInAtom =
      Atom(name: 'AauthStore.loggedIn', context: context);

  @override
  bool get loggedIn {
    _$loggedInAtom.reportRead();
    return super.loggedIn;
  }

  @override
  set loggedIn(bool value) {
    _$loggedInAtom.reportWrite(value, super.loggedIn, () {
      super.loggedIn = value;
    });
  }

  late final _$checkIfLoggedInAsyncAction =
      AsyncAction('AauthStore.checkIfLoggedIn', context: context);

  @override
  Future<void> checkIfLoggedIn() {
    return _$checkIfLoggedInAsyncAction.run(() => super.checkIfLoggedIn());
  }

  late final _$registerAsyncAction =
      AsyncAction('AauthStore.register', context: context);

  @override
  Future<void> register(
      String username, String password, String name, String phonenumber) {
    return _$registerAsyncAction
        .run(() => super.register(username, password, name, phonenumber));
  }

  late final _$loginAsyncAction =
      AsyncAction('AauthStore.login', context: context);

  @override
  Future<void> login(String username, String password) {
    return _$loginAsyncAction.run(() => super.login(username, password));
  }

  late final _$logoutAsyncAction =
      AsyncAction('AauthStore.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
loggedIn: ${loggedIn}
    ''';
  }
}
