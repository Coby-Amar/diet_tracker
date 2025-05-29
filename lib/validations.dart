typedef ValidationFunction<T> = String? Function(T? value);

class Validations {
  static final Validations _instance = Validations._init();
  static final numberOnlyRegExp = RegExp(r'^\d+$');
  factory Validations() {
    return _instance;
  }
  Validations._init();

  ValidationFunction<T> compose<T>(List<ValidationFunction<T>> validations) =>
      (T? value) {
        for (final validation in validations) {
          final result = validation(value);
          if (result != null) {
            return result;
          }
        }
        return null;
      };

  String? isRequired(dynamic value) {
    if (value is String && value.isEmpty) {
      return 'שדה נדרש';
    }
    if (value is num && (value.isNaN || value < 0)) {
      return 'שדה נדרש';
    }
    if (value == null) {
      return 'שדה נדרש';
    }
    return null;
  }

  String? doubleOnly(String? value) =>
      double.tryParse(value!) == null ? 'שדה יכול להכיל מספרים בלבד' : null;
  String? intOnly(String? value) =>
      int.tryParse(value!) == null ? 'שדה יכול להכיל מספרים בלבד' : null;
  String? minMax(dynamic value, {int? min, int? max}) {
    if (value is int) {
      if (min != null && value < min) {
        return 'צריך להיות גדול יותר מ-$min';
      }
      if (max != null && value > max) {
        return 'צריך להיות קטן מ-$max';
      }
    }
    if (value is String) {
      if (min != null && value.length < min) {
        return 'צריך להיות ארוך יותר מ-$min תווים';
      }
      if (max != null && value.length > max) {
        return 'צריך להיות קטן מ-$max תווים';
      }
    }
    return null;
  }
}
