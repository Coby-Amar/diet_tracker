extension DoubleFormatters on double {
  String get toDisplay {
    if (toString().contains('.0')) {
      return toString().replaceFirst('.0', '');
    }
    return toStringAsFixed(2);
  }
}
