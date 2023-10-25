/// ----------------------------------------------------------------------------
/// abstract Model class
/// ----------------------------------------------------------------------------
abstract class Model {
  const Model();
  Model.fromMap(Map<String, dynamic> map);
  String get toDisplayString;
  Map<String, Object?> toMap();
}

/// ----------------------------------------------------------------------------
/// BaseModel extends Model
/// ----------------------------------------------------------------------------
class BaseModel extends Model {
  static const String idColumn = 'id';

  final String id;

  const BaseModel({
    required this.id,
  });

  BaseModel.fromMap(Map<String, dynamic> map) : id = map[idColumn];

  @override
  Map<String, Object?> toMap() => {
        idColumn: id,
      };

  @override
  String get toDisplayString => throw UnimplementedError();
}

/// ----------------------------------------------------------------------------
/// ProductModel extends BaseModel
/// ----------------------------------------------------------------------------
class ProductModel extends BaseModel {
  static const String imageColumn = 'image';
  static const String nameColumn = 'name';
  static const String amountColumn = 'amount';
  static const String carbohydrateColumn = 'carbohydrate';
  static const String proteinColumn = 'protein';
  static const String fatColumn = 'fat';
  final String? image;
  final String name;
  final int amount;
  final int carbohydrate;
  final int protein;
  final int fat;

  const ProductModel({
    super.id = "",
    DateTime? createdAt,
    DateTime? updatedAt,
    this.image,
    required this.name,
    required this.amount,
    required this.carbohydrate,
    required this.protein,
    required this.fat,
  }) : assert(amount > 0);

  ProductModel.fromMap(Map<String, dynamic> map)
      : image = map[imageColumn],
        name = map[nameColumn],
        amount = map[amountColumn],
        carbohydrate = map[carbohydrateColumn],
        protein = map[proteinColumn],
        fat = map[fatColumn],
        super.fromMap(map);

  @override
  Map<String, Object?> toMap() => {
        ...super.toMap(),
        imageColumn: image,
        nameColumn: name,
        amountColumn: amount,
        carbohydrateColumn: carbohydrate,
        proteinColumn: protein,
        fatColumn: fat,
      };

  @override
  String get toDisplayString => name;
}

/// ----------------------------------------------------------------------------
/// EntryModel extends BaseModel
/// ----------------------------------------------------------------------------
class EntryModel extends BaseModel {
  static const String productIdColumn = 'productId';
  static const String amountColumn = 'amount';
  static const String carbohydrateColumn = 'carbohydrates';
  static const String proteinColumn = 'proteins';
  static const String fatColumn = 'fats';
  final String productId;
  final int amount;
  final double carbohydrates;
  final double proteins;
  final double fats;

  const EntryModel({
    super.id = "",
    required this.productId,
    required this.amount,
    required this.carbohydrates,
    required this.proteins,
    required this.fats,
  }) : assert(amount > 0);

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        amountColumn: amount,
        productIdColumn: productId,
        carbohydrateColumn: carbohydrates,
        proteinColumn: proteins,
        fatColumn: fats,
      };

  EntryModel.fromMap(Map<String, dynamic> map)
      : productId = map[productIdColumn],
        amount = map[amountColumn],
        carbohydrates = map[carbohydrateColumn],
        proteins = map[proteinColumn],
        fats = map[fatColumn],
        super.fromMap(map);

  @override
  String get toDisplayString =>
      'מוצר $productId, פחממות: $carbohydrates, חלבון: $proteins, שומן: $fats';
}

/// ----------------------------------------------------------------------------
/// ReportModel extends BaseModel
/// ----------------------------------------------------------------------------
class ReportModel extends BaseModel {
  static const String dateColumn = 'date';
  static const String carbohydratesColumn = 'carbohydratesTotal';
  static const String proteinsColumn = 'proteinsTotal';
  static const String fatsColumn = 'fatsTotal';

  final DateTime date;
  final double carbohydratesTotal;
  final double proteinsTotal;
  final double fatsTotal;

  const ReportModel({
    super.id = "",
    required this.date,
    required this.carbohydratesTotal,
    required this.proteinsTotal,
    required this.fatsTotal,
  });

  ReportModel.fromMap(Map<String, dynamic> map)
      : date = DateTime.parse(map[dateColumn]),
        carbohydratesTotal = map[carbohydratesColumn],
        proteinsTotal = map[proteinsColumn],
        fatsTotal = map[fatsColumn],
        super.fromMap(map);
  @override
  Map<String, Object?> toMap() => {
        ...super.toMap(),
        dateColumn: "${date.year}-${date.month}-${date.day}",
        carbohydratesColumn: carbohydratesTotal,
        proteinsColumn: proteinsTotal,
        fatsColumn: fatsTotal,
      };

  String get formattedDate => '${date.day}/${date.month}/${date.year}';
}

/// ----------------------------------------------------------------------------
/// ReportWithEntriesModel extends BaseModel
/// ----------------------------------------------------------------------------
class ReportWithEntries extends BaseModel {
  static const reportColumn = "report";
  static const entriesColumn = "entries";
  final ReportModel report;
  final List<EntryModel> entries;
  ReportWithEntries({
    super.id = "",
    required this.report,
    required this.entries,
  });
  @override
  Map<String, Object?> toMap() => {
        ...super.toMap(),
        reportColumn: report.toMap(),
        entriesColumn: entries.map((e) => e.toMap()).toList(),
      };
}
