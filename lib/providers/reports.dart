import 'dart:async';

import 'package:diet_tracker/providers/db.dart';
import 'package:diet_tracker/providers/entries.dart';
import 'package:diet_tracker/providers/models.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ReportsProvider with ChangeNotifier {
  static const _relTable = '_report_entries';
  static const _reportIdColumn = '_report_id';
  static const _entryIdColumn = '_entry_id';
  final EntriesProvider? _entriesProvider;
  final List<Report> reports = [];

  ReportsProvider(this._entriesProvider) {
    loadReports();
  }

  loadReports() async {
    // final db = await DBHelper().database;
    reports.add(Report(
      date: DateTime.now(),
      entries: [
        const EntryModel(
          product: ProductModel(
              name: 'תותים', amount: 200, carbohydrate: 1, protein: 0, fat: 0),
          amount: 400,
        ),
      ],
    ));
    notifyListeners();
  }

  static FutureOr<void> onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${Report.table} ( 
            ${BaseModel.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, 
            ${Report.dateColumn} TEXT NOT NULL
          )
        ''');
    await db.execute('''
          CREATE TABLE $_relTable ( 
            $_reportIdColumn INTEGER NOT NULL,
            $_entryIdColumn INTEGER NOT NULL,
            FOREIGN KEY ($_reportIdColumn) REFERENCES ${Report.table}(${BaseModel.idColumn}),
            FOREIGN KEY ($_entryIdColumn) REFERENCES ${EntryModel.table}(${BaseModel.idColumn})
          )
        ''');
  }

  Future<Report> _createReport(Report report) async {
    if (_entriesProvider == null) {
      throw Exception('createReport - internal issue EntriesProvider is null');
    }
    final db = await DBHelper().database;
    final createEntries = await _entriesProvider!.createEntries(report.entries);
    final id = await db.insert(Report.table, {
      Report.dateColumn: report.formattedDate,
    });
    for (final entry in createEntries) {
      await db.insert(_relTable, {
        _reportIdColumn: id,
        _entryIdColumn: entry.id,
      });
    }
    return Report(date: report.date, entries: createEntries);
  }

  Future<bool> createReport(Report report) async {
    try {
      final createdReport = await _createReport(report);
      reports.add(createdReport);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
