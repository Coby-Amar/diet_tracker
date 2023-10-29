double _checkIfInt(value) {
  if (value is int) {
    return value.toDouble();
  }
  return value as double;
}

/// ----------------------------------------------------------------------------
/// ApiUser
/// ----------------------------------------------------------------------------
class ApiUser {
  final String name;
  final String phoneNumber;
  final int carbohydrate;
  final int protein;
  final int fat;
  ApiUser.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        phoneNumber = map["phoneNumber"],
        carbohydrate = map["carbohydrate"],
        protein = map["protein"],
        fat = map["fat"];
}

/// ----------------------------------------------------------------------------
/// abstract ApiModel class
/// ----------------------------------------------------------------------------
abstract class ApiModel {
  final String id;

  ApiModel.fromMap(Map<String, dynamic> map) : id = map["id"];
}

/// ----------------------------------------------------------------------------
/// ApiProduct extends ApiModel
/// ----------------------------------------------------------------------------
class ApiProduct extends ApiModel {
  final String? image;
  final String name;
  final int amount;
  final int carbohydrate;
  final int protein;
  final int fat;

  ApiProduct.fromMap(super.map)
      : image = map["image"],
        name = map["name"],
        amount = map["amount"],
        carbohydrate = map["carbohydrate"],
        protein = map["protein"],
        fat = map["fat"],
        super.fromMap();
}

/// ----------------------------------------------------------------------------
/// ApiEntry extends ApiModel
/// ----------------------------------------------------------------------------
class ApiEntry extends ApiModel {
  final String productId;
  final int amount;
  final double carbohydrates;
  final double proteins;
  final double fats;

  ApiEntry.fromMap(super.map)
      : productId = map["productId"],
        amount = map["amount"],
        carbohydrates = _checkIfInt(map["carbohydrates"]),
        proteins = _checkIfInt(map["proteins"]),
        fats = _checkIfInt(map["fats"]),
        super.fromMap();
}

/// ----------------------------------------------------------------------------
/// ApiReport extends ApiModel
/// ----------------------------------------------------------------------------
class ApiReport extends ApiModel {
  final DateTime date;
  final double carbohydratesTotal;
  final double proteinsTotal;
  final double fatsTotal;

  // ApiReport.fromMap(super.map) : super.fromMap();
  ApiReport.fromMap(super.map)
      : date = DateTime.tryParse(map["date"]) ?? DateTime(0000),
        carbohydratesTotal = _checkIfInt(map["carbohydratesTotal"]),
        proteinsTotal = _checkIfInt(map["proteinsTotal"]),
        fatsTotal = _checkIfInt(map["fatsTotal"]),
        super.fromMap();
}
