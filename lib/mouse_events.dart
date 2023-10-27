import 'package:diet_tracker/app.dart';
import 'package:flutter/gestures.dart';

void onPointerDown(PointerDownEvent event) {
  // TODO: if more then one change to switch
  if (event.buttons.compareTo(kBackMouseButton) == 0) {
    _onMouseBackEvent();
  }
}

void _onMouseBackEvent() {
  if (navigatorKey.currentState?.canPop() ?? false) {
    navigatorKey.currentState?.pop();
  }
}
