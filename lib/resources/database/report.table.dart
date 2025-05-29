import 'package:diet_tracker/resources/database/product.table.dart';

import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.table.g.dart';

typedef DBReportWithEntries = ({
  DBReport cart,
  List<DBReportEntry> items,
});

abstract class DBReportRepository {
  Future<DBReportWithEntries> createReportWithEntries();
  Future<void> updateCart(DBReportWithEntries report);
}

class DBReportEntry extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get quantity => real()();
  RealColumn get carbohydrates => real()();
  RealColumn get proteins => real()();
  RealColumn get fats => real()();
  IntColumn get productId => integer().references(DBProduct, #id)();
}

class DBReport extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().unique()();
  RealColumn get totalCarbohydrates => real()();
  RealColumn get totalProteins => real()();
  RealColumn get totalFats => real()();
  TextColumn get entries => text().map(DBReportEntries.converter)();
}

@JsonSerializable()
class DBReportEntries {
  final List<int> items;

  DBReportEntries({required this.items});

  factory DBReportEntries.fromJson(Map<String, Object?> json) =>
      _$DBReportEntriesFromJson(json);

  Map<String, Object?> toJson() {
    return _$DBReportEntriesToJson(this);
  }

  static final converter = TypeConverter.json2(
    fromJson: (json) => DBReportEntries.fromJson(json as Map<String, Object?>),
    toJson: (entries) => entries.toJson(),
  );
}
