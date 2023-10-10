abstract class Model {
  const Model();
  Model.fromMap(Map<String, dynamic> map);
  String get toDisplayString;
  Map<String, Object?> toMap();
}

class BaseModel extends Model {
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

  @override
  Map<String, Object?> toMap() {
    final map = {
      updatedAtColumn: DateTime.now().toUtc().toString(),
    };
    if (id == 0) {
      map[createdAtColumn] = DateTime.now().toUtc().toString();
    }
    return map;
  }

  @override
  String get toDisplayString => throw UnimplementedError();
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
  static const String productKey = 'product';
  static const String productIdColumn = '_product_id';
  static const String amountColumn = '_amount';
  final ProductModel product;
  final int amount;

  const EntryModel({
    id = 0,
    createdAt,
    updatedAt,
    required this.product,
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
  Map<String, dynamic> toMap() =>
      {...super.toMap(), amountColumn: amount, productIdColumn: product.id};

  EntryModel.fromMap(Map<String, dynamic> map)
      : product = map[productKey] is ProductModel
            ? map[productKey]
            : ProductModel.fromMap(map[productKey]),
        amount = map[amountColumn],
        super.fromMap(map);

  @override
  String get toDisplayString =>
      'מוצר ${product.name}, פחממות: $carbohydrate, חלבון: $protein, שומן: $fat';
}

enum Total {
  carbohydrates,
  proteins,
  fats,
}

class Report {
  static const String table = '_reports';
  static const String dateColumn = '_date';
  static const String entryKey = 'entries';
  static const String entryColumn = '_entry';

  final DateTime date;
  final List<EntryModel> entries;
  late final double carbohydrates;
  late final double proteins;
  late final double fats;

  Report({
    required this.date,
    required this.entries,
  }) {
    double carbohydrates = 0;
    double proteins = 0;
    double fats = 0;
    for (final entry in entries) {
      carbohydrates += entry.carbohydrate;
      proteins += entry.protein;
      fats += entry.fat;
    }
    this.carbohydrates = carbohydrates;
    this.proteins = proteins;
    this.fats = fats;
  }

  get formattedTotal {
    return 'פחממות = ${carbohydrates.toStringAsFixed(1)}, חלבון = ${proteins.toStringAsFixed(1)}, שומן = ${fats.toStringAsFixed(1)}';
  }

  Report.fromMap(Map<String, dynamic> map)
      : date = map[dateColumn],
        entries = map[entryKey] is Iterable
            ? (map[entryKey] as Iterable<EntryModel>).toList()
            : List.from(map[entryKey])
                .map((e) => EntryModel.fromMap(e))
                .toList();

  String get formattedDate => '${date.day}/${date.month}/${date.year}';
}
