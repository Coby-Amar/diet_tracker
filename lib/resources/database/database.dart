import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/resources/database/product.table.dart';
import 'package:diet_tracker/resources/database/report.table.dart';
import 'package:sqlite3/sqlite3.dart';

part 'database.g.dart';

// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationSupportDirectory();
//     final file = File(join(dbFolder.path, 'diet_tracker_db.sqlite'));

//     // if (!await file.exists()) {
//     //   final blob = await rootBundle.load('assets/diet_tracker_db.sqlite');
//     //   final buffer = blob.buffer;
//     //   await file.writeAsBytes(
//     //       buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes));
//     // }

//     final cachebase = (await getTemporaryDirectory()).path;
//     sqlite3.tempDirectory = cachebase;
//     return NativeDatabase.createInBackground(file);
//   });
// }

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
      },
    );
  }
}
