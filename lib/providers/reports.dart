import 'dart:async';

import 'package:diet_tracker/providers/db.dart';
import 'package:diet_tracker/providers/models.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ReportsProvider with ChangeNotifier {
  List<ReportModel> reports = [];

  ReportsProvider() {
    loadReports();
  }

  loadReports() async {
    final db = await DBHelper().database;
    final entriesMaps = await db.rawQuery(
      '''
      SELECT * FROM ${EntryModel.table} 
      INNER JOIN ${ProductModel.table} on ${ProductModel.table}.${BaseModel.idColumn} =  ${EntryModel.table}.${BaseModel.idColumn} 
    '''
      '',
    );
    print('entriesMaps');
    print(entriesMaps);
    notifyListeners();
    // final entries = entriesMaps.map((e) => EntryModel.fromMap(e)).toList();
    // entries.reduce((value, element) => null)
  }

  static FutureOr<void> onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE  ${EntryModel.table} ( 
            ${BaseModel.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, 
            ${BaseModel.createdAtColumn} TEXT NOT NULL,
            ${BaseModel.updatedAtColumn} TEXT NOT NULL,
            ${EntryModel.productIdColumn} TEXT NOT NULL,
            ${EntryModel.dateColumn} TEXT NOT NULL,
            ${EntryModel.amountColumn} INTEGER NOT NULL,
            FOREIGN KEY (${EntryModel.productIdColumn}) REFERENCES ${ProductModel.table}(${BaseModel.idColumn})
          )
        ''');
  }
}
