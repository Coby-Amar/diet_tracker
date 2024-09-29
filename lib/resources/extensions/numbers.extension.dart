final _emptyRegExp = RegExp(r'.0$');

extension DoubleFormatters on double {
  String get toDisplay {
    if (toString().contains('.0')) {
      return toString().replaceFirst(_emptyRegExp, '');
    }
    return toStringAsFixed(2);
  }
}
