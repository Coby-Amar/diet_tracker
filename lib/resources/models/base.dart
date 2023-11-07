/// ----------------------------------------------------------------------------
/// abstract class AutoCompleteModel
/// ----------------------------------------------------------------------------
abstract class AutoCompleteModel {
  String get toStringDisplay;
}

/// ----------------------------------------------------------------------------
/// abstract ApiModel class
/// ----------------------------------------------------------------------------
abstract class ApiModel {
  abstract final String id;
  ApiModel.fromMap(Map<String, dynamic> map);
}

/// ----------------------------------------------------------------------------
/// abstract class DisplayModel<T extends ApiModel>
/// ----------------------------------------------------------------------------
abstract class DisplayModel<T extends ApiModel> {
  const DisplayModel();
  const DisplayModel.fromApi(T apiModel);
  Map<String, Object?> toMap();
}
