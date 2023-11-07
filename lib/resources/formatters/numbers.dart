class NumbersFormmater {
  static String toFixed2(double number) => number.toStringAsFixed(2);
  static double ifIntToDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    }
    return value as double;
  }
}
