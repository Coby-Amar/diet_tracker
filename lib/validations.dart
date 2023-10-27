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

  String? required(String? value) =>
      value?.isEmpty ?? true ? 'שדה זה חייב להיות מלא' : null;

  String? numberOnly(String? value) =>
      int.tryParse(value!) == null ? 'שדה זה יכל להכיל רק מספרים' : null;
}
