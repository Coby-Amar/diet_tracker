/// ----------------------------------------------------------------------------
/// abstract CreationModel class
/// ----------------------------------------------------------------------------
abstract class CreationModel {
  CreationModel.empty();
  const CreationModel();
  Map<String, Object?> toMap();
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
class CreateEntry extends CreationModel {
  String productId = "";
  int amount = 0;
  double carbohydrates = 0;
  double proteins = 0;
  double fats = 0;

  CreateEntry.empty() : super.empty();

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
/// CreateReport extends CreationModel
/// ----------------------------------------------------------------------------
class CreateReport extends CreationModel {
  DateTime date = DateTime.now();
  double carbohydratesTotal = 0.0;
  double proteinsTotal = 0.0;
  double fatsTotal = 0.0;

  CreateReport.empty() : super.empty();

  @override
  Map<String, Object?> toMap() => {
        "date": "${date.year}-${date.month}-${date.day}",
        "carbohydratesTotal": carbohydratesTotal,
        "proteinsTotal": proteinsTotal,
        "fatsTotal": fatsTotal,
      };
}

/// ----------------------------------------------------------------------------
/// CreateReportWithEntries extends CreationModel
/// ----------------------------------------------------------------------------
class CreateReportWithEntries extends CreationModel {
  CreateReport report = CreateReport.empty();
  List<CreateEntry> entries = [];

  CreateReportWithEntries.empty() : super.empty();

  @override
  Map<String, Object?> toMap() => {
        "report": report.toMap(),
        "entries": entries.map((entry) => entry.toMap()).toList(),
      };
}
