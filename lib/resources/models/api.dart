import 'package:diet_tracker/resources/models/base.dart';
import 'package:diet_tracker/resources/formatters/date.dart';
import 'package:diet_tracker/resources/formatters/numbers.dart';

/// ----------------------------------------------------------------------------
/// ApiUserDailyLimits
/// ----------------------------------------------------------------------------
class ApiDailyLimits extends ApiModel {
  @override
  final String id = '';
  final int carbohydrate;
  final int protein;
  final int fat;

  ApiDailyLimits.fromMap(Map<String, dynamic> map)
      : carbohydrate = map["carbohydrate"],
        protein = map["protein"],
        fat = map["fat"],
        super.fromMap(map);
}

/// ----------------------------------------------------------------------------
/// ApiUser
/// ----------------------------------------------------------------------------
class ApiUser extends ApiModel {
  @override
  final String id = '';
  final String name;
  final String phoneNumber;
  final ApiDailyLimits dailyLimits;
  ApiUser.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        dailyLimits = ApiDailyLimits.fromMap(map),
        phoneNumber = map["phoneNumber"],
        super.fromMap(map);

  String get carbohydrate => dailyLimits.carbohydrate.toString();
  String get protein => dailyLimits.protein.toString();
  String get fat => dailyLimits.fat.toString();
}

/// ----------------------------------------------------------------------------
/// ApiProduct extends ApiModel
/// ----------------------------------------------------------------------------
class ApiProduct extends ApiModel implements AutoCompleteModel {
  @override
  final String id;
  final String? image;
  final String name;
  final int amount;
  final int carbohydrate;
  final int protein;
  final int fat;

  ApiProduct.fromMap(super.map)
      : id = map["id"],
        image = map["image"],
        name = map["name"],
        amount = map["amount"],
        carbohydrate = map["carbohydrate"],
        protein = map["protein"],
        fat = map["fat"],
        super.fromMap();

  @override
  String get toStringDisplay => name;
}

/// ----------------------------------------------------------------------------
/// ApiEntry extends ApiModel
/// ----------------------------------------------------------------------------
class ApiEntry extends ApiModel {
  @override
  final String id;
  final String productId;
  final int amount;
  final double carbohydrates;
  final double proteins;
  final double fats;

  ApiEntry.fromMap(super.map)
      : id = map["id"],
        productId = map["productId"],
        amount = map["amount"],
        carbohydrates = NumbersFormmater.ifIntToDouble(map["carbohydrates"]),
        proteins = NumbersFormmater.ifIntToDouble(map["proteins"]),
        fats = NumbersFormmater.ifIntToDouble(map["fats"]),
        super.fromMap();
}

/// ----------------------------------------------------------------------------
/// ApiReport extends ApiModel
/// ----------------------------------------------------------------------------
class ApiReport extends ApiModel {
  @override
  final String id;
  final DateTime date;
  final double carbohydratesTotal;
  final double proteinsTotal;
  final double fatsTotal;

  ApiReport.fromMap(super.map)
      : id = map["id"],
        date = DateTime.tryParse(map["date"]) ?? DateTime(0000),
        carbohydratesTotal =
            NumbersFormmater.ifIntToDouble(map["carbohydratesTotal"]),
        proteinsTotal = NumbersFormmater.ifIntToDouble(map["proteinsTotal"]),
        fatsTotal = NumbersFormmater.ifIntToDouble(map["fatsTotal"]),
        super.fromMap();

  String get formattedDate => DateFormmater.toDayMonthYear(date);
}
