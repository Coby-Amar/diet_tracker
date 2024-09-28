extension DateFormatters on DateTime {
  String get toDayMonthYear {
    final day = this.day;
    final month = this.month;
    final year = this.year;
    return "$day/$month/$year";
  }

  String get toYearMonthDay {
    final day = this.day;
    final month = this.month;
    final year = this.year;
    return "$year-$month-${day < 10 ? "0$day" : day}";
  }

  String get toDisplay {
    return toDayMonthYear;
  }
}
