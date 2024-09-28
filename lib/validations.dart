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

  String? isRequired(String? value) =>
      value?.isEmpty ?? true ? 'Field is required' : null;

  String? doubleOnly(String? value) =>
      double.tryParse(value!) == null ? 'Numbers only field' : null;
  String? intOnly(String? value) =>
      int.tryParse(value!) == null ? 'Numbers only field' : null;
}
