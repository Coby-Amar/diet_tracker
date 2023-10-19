import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart';

import 'package:diet_tracker/providers/reports.dart';
import 'package:diet_tracker/providers/products.dart';
import 'package:diet_tracker/providers/entries.dart';

class DBHelper {
  static const _databaseName = "diet_tracker.db";
  static const _databaseVersion = 1;

  DBHelper._privateConstructor();
  static final DBHelper _instance = DBHelper._privateConstructor();
  factory DBHelper() {
    return _instance;
  }
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database as Database;
    _database = await initDatabase();
    return _database as Database;
  }

  Future<Database> initDatabase() async {
    final dbpath = await getDatabasesPath();
    return openDatabase(
      join(dbpath, _databaseName),
      version: _databaseVersion,
      onCreate: (db, version) async {
        await ProductsProvider.onCreate(db, version);
        await EntriesProvider.onCreate(db, version);
        await ReportsProvider.onCreate(db, version);
      },
    );
  }
}
