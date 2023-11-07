class DateFormmater {
  static String toDayMonthYear(DateTime date) {
    final day = date.day;
    final month = date.month;
    final year = date.year;
    return "$day/$month/$year";
  }

  static String toYearMonthDay(DateTime date) {
    final day = date.day;
    final month = date.month;
    final year = date.year;
    return "$year-$month-${day < 10 ? "0$day" : day}";
  }
}
