extension StringFormatters on String {
  String get toDayMonthYear {
    final date = DateTime.tryParse(this);
    if (date == null) {
      return this;
    }
    final day = date.day;
    final month = date.month;
    final year = date.year;
    return "$day/$month/$year";
  }

  String get toYearMonthDay {
    final date = DateTime.tryParse(this);
    if (date == null) {
      return this;
    }
    final day = date.day;
    final month = date.month;
    final year = date.year;
    return "$year-$month-${day < 10 ? "0$day" : day}";
  }
}
