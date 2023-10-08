abstract class ModelMethods {
  String get toDisplayString;
}

/// ----------------------------------------------------------------------------
/// ProductModel extends BaseModel
/// ----------------------------------------------------------------------------

abstract class BaseModel implements ModelMethods {
  static const String idColumn = '_id';
  static const String createdAtColumn = '_created_at';
  static const String updatedAtColumn = '_updated_at';

  final int id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BaseModel({
    required this.id,
    this.createdAt,
    this.updatedAt,
  });
  BaseModel.fromMap(Map<String, dynamic> map)
      : id = map[idColumn],
        createdAt = DateTime.parse(map[createdAtColumn]),
        updatedAt = DateTime.parse(map[updatedAtColumn]);

  Map<String, Object?> toMap() {
    final map = {
      updatedAtColumn: DateTime.now().toUtc().toString(),
    };
    if (id == 0) {
      map[createdAtColumn] = DateTime.now().toUtc().toString();
    }
    return map;
  }
}

/// ----------------------------------------------------------------------------
/// ProductModel extends BaseModel
/// ----------------------------------------------------------------------------

class ProductModel extends BaseModel {
  static const String table = 'products';
  static const String imageColumn = '_image';
  static const String nameColumn = '_name';
  static const String amountColumn = '_amount';
  static const String carbohydrateColumn = '_carbohydrate';
  static const String proteinColumn = '_protein';
  static const String fatColumn = '_fat';
  final String? image;
  final String name;
  final int amount;
  final int carbohydrate;
  final int protein;
  final int fat;
  const ProductModel({
    id = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.image,
    required this.name,
    required this.amount,
    required this.carbohydrate,
    required this.protein,
    required this.fat,
  })  : assert(amount > 0),
        super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
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
  static const String table = 'entries';
  static const String productIdColumn = '_product_id';
  static const String productColumn = 'product';
  static const String dateColumn = '_date';
  static const String amountColumn = '_amount';
  final ProductModel product;
  final DateTime date;
  final int amount;
  const EntryModel({
    id = 0,
    createdAt,
    updatedAt,
    required this.product,
    required this.date,
    required this.amount,
  })  : assert(amount > 0),
        super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  double get carbohydrate {
    return amount / product.amount * product.carbohydrate;
  }

  double get protein {
    return amount / product.amount * product.protein;
  }

  double get fat {
    return amount / product.amount * product.fat;
  }

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        dateColumn: date,
        amountColumn: amount,
      };

  EntryModel.fromMap(Map<String, dynamic> map)
      : product = map[productIdColumn],
        date = map[dateColumn],
        amount = map[amountColumn],
        super.fromMap(map);

  @override
  String get toDisplayString =>
      'מוצר ${product.name}, פחממות: $carbohydrate, חלבון: $protein, שומן: $fat';
}

class ReportModel implements ModelMethods {
  final DateTime date;
  final List<EntryModel> entries;
  const ReportModel({
    required this.date,
    required this.entries,
  });

  @override
  String get toDisplayString =>
      entries.map((e) => e.toDisplayString).toString();
}
