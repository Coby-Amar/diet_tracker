import 'package:diet_tracker/resources/models.dart';
import 'package:drift/drift.dart';

class DBProduct extends Table {
  IntColumn get id => integer().autoIncrement()();
  BlobColumn get image => blob().nullable()();
  TextColumn get name => text().withLength(min: 3, max: 32).unique()();
  IntColumn get units => intEnum<Units>()();
  RealColumn get quantity => real()();
  RealColumn get carbohydrates => real()();
  RealColumn get proteins => real()();
  RealColumn get fats => real()();
  BoolColumn get cooked => boolean()();
}
