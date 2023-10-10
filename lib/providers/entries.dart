import 'dart:async';

import 'package:diet_tracker/providers/db.dart';
import 'package:diet_tracker/providers/models.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class EntriesProvider {
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
  }

  Future<EntryModel> createEntry(EntryModel entry) async {
    final db = await DBHelper().database;
    final entryMap = entry.toMap();
    int id = await db.insert(EntryModel.table, entryMap);
    final createdEntry = EntryModel.fromMap({
      ...entryMap,
      EntryModel.productKey: entry.product,
      BaseModel.idColumn: id
    });
    return createdEntry;
  }

  Future<List<EntryModel>> createEntries(List<EntryModel> entries) async {
    List<EntryModel> createdEntries = [];
    for (final entry in entries) {
      final createdEntry = await createEntry(entry);
      createdEntries.add(createdEntry);
    }
    return createdEntries;
  }
}
