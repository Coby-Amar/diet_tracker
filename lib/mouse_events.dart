import 'package:diet_tracker/app.dart';
import 'package:flutter/gestures.dart';

void onPointerDown(PointerDownEvent event) {
  if (event.buttons.compareTo(kBackMouseButton) == 0) {
    _onMouseBackEvent();
  }
}

void _onMouseBackEvent() {
  if (rootNavigationKey.currentState?.canPop() ?? false) {
    rootNavigationKey.currentState?.pop();
  }
}
