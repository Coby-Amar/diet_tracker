import 'package:diet_tracker/resources/formatters/date.dart';
import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/models/base.dart';

/// ----------------------------------------------------------------------------
/// class Registration extends DisplayModel
/// ----------------------------------------------------------------------------
class Registration extends DisplayModel {
  String username = "";
  String password = "";
  String name = "";
  String phonenumber = "";
  int carbohydrate = 0;
  int protein = 0;
  int fat = 0;

  Registration();

  @override
  Map<String, Object?> toMap() => {
        "username": username,
        "password": password,
        "name": name,
        "phonenumber": phonenumber,
        "carbohydrate": carbohydrate,
        "protein": protein,
        "fat": fat,
      };
}

/// ----------------------------------------------------------------------------
/// class Login extends DisplayModel
/// ----------------------------------------------------------------------------
class Login extends DisplayModel {
  String username = "";
  String password = "";

  Login();

  @override
  Map<String, Object?> toMap() => {
        "username": username,
        "password": password,
      };
}

/// ----------------------------------------------------------------------------
/// class DisplayUser extends DisplayModel<ApiUser>
/// ----------------------------------------------------------------------------
class DisplayUser extends DisplayModel<ApiUser> {
  String name;
  String phoneNumber;

  DisplayUser.fromApi(super.apiModel)
      : name = apiModel.name,
        phoneNumber = apiModel.phoneNumber,
        super.fromApi();

  @override
  Map<String, Object?> toMap() => {
        "name": name,
        "phoneNumber": phoneNumber,
      };
}

/// ----------------------------------------------------------------------------
/// class DisplayDailyLimits extends DisplayModel<ApiDailyLimits>
/// ----------------------------------------------------------------------------
class DisplayDailyLimits extends DisplayModel<ApiDailyLimits> {
  int carbohydrate;
  int protein;
  int fat;

  DisplayDailyLimits.fromApi(super.apiModel)
      : carbohydrate = apiModel.carbohydrate,
        protein = apiModel.protein,
        fat = apiModel.fat,
        super.fromApi();

  @override
  Map<String, Object?> toMap() => {
        "carbohydrate": carbohydrate,
        "protein": protein,
        "fat": fat,
      };
}

/// ----------------------------------------------------------------------------
/// class DisplayProductModel extends DisplayModel<ApiProduct>
/// ----------------------------------------------------------------------------
class DisplayProductModel extends DisplayModel<ApiProduct>
    implements UpdateableModel {
  @override
  String id = "";
  String? image = "";
  String name = "";
  int amount = 0;
  int carbohydrate = 0;
  int protein = 0;
  int fat = 0;

  DisplayProductModel();
  DisplayProductModel.fromApi(super.apiModel)
      : id = apiModel.id,
        image = apiModel.image,
        name = apiModel.name,
        amount = apiModel.amount,
        carbohydrate = apiModel.carbohydrate,
        protein = apiModel.protein,
        fat = apiModel.fat,
        super.fromApi();

  @override
  Map<String, Object?> toMap() => {
        "id": id,
        "image": image,
        "name": name,
        "amount": amount,
        "carbohydrate": carbohydrate,
        "protein": protein,
        "fat": fat,
      };
}

/// ----------------------------------------------------------------------------
/// class DisplayEntry extends DisplayModel<ApiEntry>
/// ----------------------------------------------------------------------------
class DisplayEntry extends DisplayModel<ApiEntry> implements UpdateableModel {
  @override
  String id = "";
  String productId = "";
  int amount = 0;
  double carbohydrates = 0;
  double proteins = 0;
  double fats = 0;
  DisplayEntry();
  DisplayEntry.fromApi(super.apiModel)
      : id = apiModel.id,
        productId = apiModel.productId,
        amount = apiModel.amount,
        carbohydrates = apiModel.carbohydrates,
        proteins = apiModel.proteins,
        fats = apiModel.fats,
        super.fromApi();

  DisplayEntry.from(ApiProduct product, int entryAmount) {
    productId = product.id;
    amount = entryAmount;
    final calculatedAmount = entryAmount / product.amount;
    carbohydrates = calculatedAmount * product.carbohydrate;
    proteins = calculatedAmount * product.protein;
    fats = calculatedAmount * product.fat;
  }

  ApiProduct getProduct(List<ApiProduct> products) {
    final foundProduct =
        products.firstWhere((element) => element.id == productId);
    return foundProduct;
  }

  DisplayProductModel getDisplayProduct(List<ApiProduct> products) {
    return DisplayProductModel.fromApi(getProduct(products));
  }

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "productId": productId,
        "amount": amount,
        "carbohydrates": carbohydrates,
        "proteins": proteins,
        "fats": fats,
      };
}

/// ----------------------------------------------------------------------------
/// class DisplayReportModel extends DisplayModel<ApiReport>
/// ----------------------------------------------------------------------------
class DisplayReportModel extends DisplayModel<ApiReport>
    implements UpdateableModel {
  @override
  String id = "";
  DateTime date = DateTime(0000);
  double carbohydratesTotal = 0;
  double proteinsTotal = 0;
  double fatsTotal = 0;

  DisplayReportModel();
  DisplayReportModel.fromApi(super.apiModel)
      : id = apiModel.id,
        date = apiModel.date,
        carbohydratesTotal = apiModel.carbohydratesTotal,
        proteinsTotal = apiModel.proteinsTotal,
        fatsTotal = apiModel.fatsTotal,
        super.fromApi();

  @override
  Map<String, Object?> toMap() => {
        "id": id,
        "date": DateFormmater.toYearMonthDay(date),
        "carbohydratesTotal": carbohydratesTotal,
        "proteinsTotal": proteinsTotal,
        "fatsTotal": fatsTotal,
      };
}

/// ----------------------------------------------------------------------------
/// class DisplayReportModel extends DisplayModel<ApiReport>
/// ----------------------------------------------------------------------------
class DisplayReportWithEntries {
  DisplayReportModel report = DisplayReportModel();
  List<DisplayEntry> existingEntries = [];
  List<DisplayEntry> entriesToCreate = [];

  DisplayReportWithEntries();
  DisplayReportWithEntries.fromApi(ApiReport report, List<ApiEntry> entries)
      : report = DisplayReportModel.fromApi(report),
        existingEntries = entries.map((e) => DisplayEntry.fromApi(e)).toList();

  int get totalAmount {
    int amount = 0;
    for (final entry in existingEntries) {
      amount += entry.amount;
    }
    return amount;
  }

  calculateReportTotals({bool shouldResetTotals = false}) {
    if (shouldResetTotals) {
      report.carbohydratesTotal = 0;
      report.proteinsTotal = 0;
      report.fatsTotal = 0;
    }
    for (final entry in existingEntries) {
      report.carbohydratesTotal += entry.carbohydrates;
      report.proteinsTotal += entry.proteins;
      report.fatsTotal += entry.fats;
    }
    for (final entry in entriesToCreate) {
      report.carbohydratesTotal += entry.carbohydrates;
      report.proteinsTotal += entry.proteins;
      report.fatsTotal += entry.fats;
    }
  }

  Map<String, Object?> toMap() => {
        "report": report.toMap(),
        "existingEntries":
            existingEntries.map((entry) => entry.toMap()).toList(),
        "entriesToCreate":
            entriesToCreate.map((entry) => entry.toMap()).toList(),
      };
}
