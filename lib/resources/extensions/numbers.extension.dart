extension DoubleFormatters on double {
  String get toDisplay {
    if (this == -1) {
      return '';
    }
    return toStringAsFixed(2);
  }

  String get toEmptyDisplay {
    if (this == -1) {
      return '0';
    }
    return toStringAsFixed(2);
  }
}
