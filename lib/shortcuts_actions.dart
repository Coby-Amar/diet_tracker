import 'package:diet_tracker/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _GoBackIntent extends Intent {}

class ShortcutsAndActions {
  static final Map<ShortcutActivator, Intent> backShortcuts = {
    LogicalKeySet(
      LogicalKeyboardKey.alt,
      LogicalKeyboardKey.arrowLeft,
    ): _GoBackIntent(),
    LogicalKeySet(
      LogicalKeyboardKey.goBack,
    ): _GoBackIntent(),
    LogicalKeySet(
      LogicalKeyboardKey.gameButton1,
    ): _GoBackIntent(),
    LogicalKeySet(
      LogicalKeyboardKey.gameButton2,
    ): _GoBackIntent(),
    LogicalKeySet(
      LogicalKeyboardKey.gameButtonB,
    ): _GoBackIntent(),
    LogicalKeySet(
      LogicalKeyboardKey.gameButtonX,
    ): _GoBackIntent(),
  };
  static final Map<Type, Action<Intent>> backShortcutsActions = {
    _GoBackIntent: CallbackAction(
      onInvoke: (intent) {
        final canPop = navigatorKey.currentState?.canPop() ?? false;
        if (canPop) {
          navigatorKey.currentState?.pop();
        }
        return;
      },
    )
  };
}
