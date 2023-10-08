import 'dart:async';
import 'dart:convert';

import 'package:diet_tracker/providers/db.dart';
import 'package:diet_tracker/providers/models.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ReportsProvider with ChangeNotifier {
  List<Report> reports = [];

  ReportsProvider() {
    loadReports();
  }

  loadReports() async {
    final db = await DBHelper().database;
    final reportsMaps = await db.rawQuery(
      '''
      SELECT ${Report.dateColumn},
      GROUP_CONCAT(${Report.entryIdColumn})
      AS ${Report.entryKey}
      FROM ${Report.table} AS r
      INNER JOIN ${EntryModel.table} AS e ON e.${BaseModel.idColumn} = r.${Report.entryIdColumn}  
    ''',
    );
    final entriesMaps = await db.rawQuery(
      '''
      SELECT *
      FROM ${EntryModel.table} as e
      INNER JOIN ${ProductModel.table} AS p ON p.${BaseModel.idColumn} = e.${EntryModel.productIdColumn}
      WHERE e.${BaseModel.idColumn} in (${reportsMaps.map((e) => e[Report.entryKey]).join()})
    ''',
    );
    final entries = entriesMaps.map((entry) =>
        EntryModel.fromMap({...entry, EntryModel.productKey: entry}));
    reports = reportsMaps
        .map((e) => Report.fromMap({
              ...e,
              Report.entryKey: entries.where((entry) =>
                  (e[Report.entryKey] as String)
                      .split(',')
                      .map((e) => int.tryParse(e))
                      .contains(entry.id)),
            }))
        .toList();
    notifyListeners();
  }

  static FutureOr<void> onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE  ${EntryModel.table} ( 
            ${BaseModel.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, 
            ${BaseModel.createdAtColumn} TEXT NOT NULL,
            ${BaseModel.updatedAtColumn} TEXT NOT NULL,
            ${EntryModel.productIdColumn} TEXT NOT NULL,
            ${EntryModel.amountColumn} INTEGER NOT NULL,
            FOREIGN KEY (${EntryModel.productIdColumn}) REFERENCES ${ProductModel.table}(${BaseModel.idColumn})
          )
        ''');
    await db.execute('''
          CREATE TABLE  ${Report.table} ( 
            ${Report.dateColumn} TEXT NOT NULL,
            ${Report.entryIdColumn} INTEGER NOT NULL UNIQUE,
            FOREIGN KEY (${Report.entryIdColumn}) REFERENCES ${EntryModel.table}(${BaseModel.idColumn})
          )
        ''');
  }

  Future<EntryModel> _createEntry(EntryModel entry) async {
    final db = await DBHelper().database;
    final entryMap = entry.toMap();
    int id = await db.insert(EntryModel.table, entryMap);
    return EntryModel.fromMap({
      ...entryMap,
      EntryModel.productKey: entry.product,
      BaseModel.idColumn: id
    });
  }

  Future<Report> _createReport(Report report) async {
    final db = await DBHelper().database;
    List<EntryModel> createdEntries = [];
    for (final entry in report.entries) {
      final createdEntry = await _createEntry(entry);
      createdEntries.add(createdEntry);
      await db.insert(Report.table, {
        Report.dateColumn: report.date.toString(),
        Report.entryIdColumn: createdEntry.id,
      });
    }
    return Report(date: report.date, entries: createdEntries);
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
