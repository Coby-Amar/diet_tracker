import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/resources/database/product.table.dart';
import 'package:diet_tracker/resources/database/report.table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [DBProduct, DBReportEntry, DBReport])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static QueryExecutor _openConnection() {
    final db = driftDatabase(
      name: 'diet_tracker_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationDocumentsDirectory,
        // databaseDirectory: getApplicationSupportDirectory,
      ),
    );
    return db;
  }

  @override
  int get schemaVersion => 1;

  Future<void> _insertBaseProducts() async {
    final baseProductsString =
        await rootBundle.loadString('assets/base_products.json');
    final baseProducts = jsonDecode(baseProductsString);
    for (final productJson in baseProducts) {
      await customStatement(
          'INSERT INTO ${dBProduct.aliasedName} (image, name, units, quantity, carbohydrates, proteins, fats, cooked) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)',
          [
            base64Decode(productJson['image']),
            productJson['name'],
            productJson['units'],
            productJson['quantity'],
            productJson['carbohydrates'],
            productJson['proteins'],
            productJson['fats'],
            productJson['cooked'],
          ]);
    }
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (openingDetails) async {
        // final m = Migrator(this);
        // for (final table in allTables) {
        //   await m.deleteTable(table.actualTableName);
        //   await m.createTable(table);
        // }
        if (openingDetails.wasCreated) {
          await _insertBaseProducts();
        }
      },
    );
  }
}
