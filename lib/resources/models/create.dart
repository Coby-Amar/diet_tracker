import 'package:diet_tracker/resources/models/display.dart';

/// ----------------------------------------------------------------------------
/// abstract CreationModel class
/// ----------------------------------------------------------------------------
abstract class CreationModel {
  CreationModel.empty();
  Map<String, Object?> toMap();
}

abstract class UpdateModel {
  CreationModel fromDisplay<T extends DisplayModel>(T displayModel);
}

/// ----------------------------------------------------------------------------
/// CreateRegistration extends CreationModel
/// ----------------------------------------------------------------------------
class CreateRegistration extends CreationModel {
  String username = "";
  String password = "";
  String name = "";
  String phonenumber = "";
  int carbohydrate = 0;
  int protein = 0;
  int fat = 0;

  CreateRegistration.empty() : super.empty();

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
/// CreateLogin extends CreationModel
/// ----------------------------------------------------------------------------
class CreateLogin extends CreationModel {
  String username = "";
  String password = "";

  CreateLogin.empty() : super.empty();

  @override
  Map<String, Object?> toMap() => {
        "username": username,
        "password": password,
      };
}

/// ----------------------------------------------------------------------------
/// CreateProduct extends CreationModel
/// ----------------------------------------------------------------------------
class CreateProduct extends CreationModel {
  String? image = "";
  String name = "";
  int amount = 0;
  int carbohydrate = 0;
  int protein = 0;
  int fat = 0;

  CreateProduct.empty() : super.empty();

  @override
  Map<String, Object?> toMap() => {
        "image": image,
        "name": name,
        "amount": amount,
        "carbohydrate": carbohydrate,
        "protein": protein,
        "fat": fat,
      };
}

/// ----------------------------------------------------------------------------
/// CreateEntry extends CreationModel
/// ----------------------------------------------------------------------------
class CreateUpdateEntry extends CreationModel implements UpdateModel {
  String productId = "";
  int amount = 0;
  double carbohydrates = 0;
  double proteins = 0;
  double fats = 0;

  CreateUpdateEntry.empty() : super.empty();

  @override
  Map<String, dynamic> toMap() => {
        "productId": productId,
        "amount": amount,
        "carbohydrates": carbohydrates,
        "proteins": proteins,
        "fats": fats,
      };

  @override
  CreationModel fromDisplay<T extends DisplayModel>(T displayModel) {
    if (displayModel is DisplayEntry) {
      productId = displayModel.productId;
      amount = displayModel.amount;
      carbohydrates = displayModel.carbohydrates;
      proteins = displayModel.proteins;
      fats = displayModel.fats;
    }
    return this;
  }
}

/// ----------------------------------------------------------------------------
/// CreateReport extends CreationModel
/// ----------------------------------------------------------------------------
class CreateUpdateReport extends CreationModel implements UpdateModel {
  DateTime date = DateTime.now();
  double carbohydratesTotal = 0.0;
  double proteinsTotal = 0.0;
  double fatsTotal = 0.0;

  CreateUpdateReport.empty() : super.empty();

  @override
  Map<String, Object?> toMap() => {
        "date": "${date.year}-${date.month}-${date.day}",
        "carbohydratesTotal": carbohydratesTotal,
        "proteinsTotal": proteinsTotal,
        "fatsTotal": fatsTotal,
      };

  @override
  CreationModel fromDisplay<T extends DisplayModel>(T displayModel) {
    if (displayModel is DisplayReport) {
      date = displayModel.date;
      carbohydratesTotal = displayModel.carbohydratesTotal;
      proteinsTotal = displayModel.proteinsTotal;
      fatsTotal = displayModel.fatsTotal;
    }
    return this;
  }
}

/// ----------------------------------------------------------------------------
/// CreateReportWithEntries extends CreationModel
/// ----------------------------------------------------------------------------
class CreateUpdateReportWithEntries extends CreationModel
    implements UpdateModel {
  CreateUpdateReport report = CreateUpdateReport.empty();
  List<CreateUpdateEntry> entries = [];

  CreateUpdateReportWithEntries.empty() : super.empty();

  @override
  Map<String, Object?> toMap() => {
        "report": report.toMap(),
        "entries": entries.map((entry) => entry.toMap()).toList(),
      };

  @override
  CreationModel fromDisplay<T extends DisplayModel>(T displayModel) {
    if (displayModel is DisplayReportWithEntries) {
      report.fromDisplay(displayModel.report);
      entries.clear();
      for (final entry in displayModel.entries) {
        entries.add(
            CreateUpdateEntry.empty().fromDisplay(entry) as CreateUpdateEntry);
      }
    }
    return this;
  }
}
