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
class DisplayProductModel extends DisplayModel<ApiProduct> {
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
class DisplayEntry extends DisplayModel<ApiEntry> {
  String productId = "";
  int amount = 0;
  double carbohydrates = 0;
  double proteins = 0;
  double fats = 0;
  DisplayEntry();
  DisplayEntry.fromApi(super.apiModel)
      : productId = apiModel.productId,
        amount = apiModel.amount,
        carbohydrates = apiModel.carbohydrates,
        proteins = apiModel.proteins,
        fats = apiModel.fats,
        super.fromApi();

  @override
  Map<String, dynamic> toMap() => {
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
class DisplayReportModel extends DisplayModel<ApiReport> {
  DateTime date = DateTime(0000);
  double carbohydratesTotal = 0;
  double proteinsTotal = 0;
  double fatsTotal = 0;

  DisplayReportModel();
  DisplayReportModel.fromApi(super.apiModel)
      : date = apiModel.date,
        carbohydratesTotal = apiModel.carbohydratesTotal,
        proteinsTotal = apiModel.proteinsTotal,
        fatsTotal = apiModel.fatsTotal,
        super.fromApi();

  @override
  Map<String, Object?> toMap() => {
        "date": date,
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
  List<DisplayEntry> entries = [];

  DisplayReportWithEntries();
  DisplayReportWithEntries.fromApi(ApiReport report, List<ApiEntry> entries)
      : report = DisplayReportModel.fromApi(report),
        entries = entries.map((e) => DisplayEntry.fromApi(e)).toList();

  Map<String, Object?> toMap() => {
        "report": report.toMap(),
        "entries": entries.map((entry) => entry.toMap()).toList(),
      };
}
