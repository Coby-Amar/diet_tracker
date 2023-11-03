// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InfoStore on _InfoStore, Store {
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn => (_$isLoggedInComputed ??=
          Computed<bool>(() => super.isLoggedIn, name: '_InfoStore.isLoggedIn'))
      .value;

  late final _$userAtom = Atom(name: '_InfoStore.user', context: context);

  @override
  DisplayUser? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(DisplayUser? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$getUserAsyncAction =
      AsyncAction('_InfoStore.getUser', context: context);

  @override
  Future<void> getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  late final _$registerAsyncAction =
      AsyncAction('_InfoStore.register', context: context);

  @override
  Future<void> register(CreateRegistration model) {
    return _$registerAsyncAction.run(() => super.register(model));
  }

  late final _$loginAsyncAction =
      AsyncAction('_InfoStore.login', context: context);

  @override
  Future<void> login(CreateLogin loginModel) {
    return _$loginAsyncAction.run(() => super.login(loginModel));
  }

  late final _$logoutAsyncAction =
      AsyncAction('_InfoStore.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
user: ${user},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
