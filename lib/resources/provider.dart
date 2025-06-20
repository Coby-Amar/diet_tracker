import 'dart:convert';
import 'dart:io';

import 'package:diet_tracker/resources/database/database.dart';
import 'package:diet_tracker/resources/database/report.table.dart';
import 'package:diet_tracker/resources/models.dart';
import 'package:diet_tracker/resources/extensions/dates.extension.dart';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

extension CustomProductListSorts on List<Product> {
  void sortByName() {
    sort((a, b) => a.name.compareTo(b.name));
  }
}

extension CustomReportListSorts on List<Report> {
  void sortByDate() {
    sort((a, b) => b.date.compareTo(a.date));
  }
}

class AppProvider extends ChangeNotifier {
  final AppDatabase _database = AppDatabase();
  String _searchReportsQuery = '';
  String _searchProductsQuery = '';
  final reports = <Report>[];
  final products = <Product>[];
  DailyLimit _dailyLimit = DailyLimit();
  AppProvider() {
    loadReports();
    loadProducts();
    loadDailyLimit();
  }

  set searchReportsQuery(String query) {
    _searchReportsQuery = query;
    notifyListeners();
  }

  List<Report> get searchReportsFiltered {
    if (_searchReportsQuery.isEmpty) {
      return reports;
    }
    return reports
        .where(
          (element) => element.date.toDayMonthYear
              .replaceAll('/', '')
              .contains(_searchReportsQuery.replaceAll('/', '')),
        )
        .toList();
  }

  set searchProductsQuery(String query) {
    _searchProductsQuery = query;
    notifyListeners();
  }

  List<Product> get searchProductsFiltered => products
      .where((element) => element.name.contains(_searchProductsQuery))
      .toList();

  Future<void> loadReports() async {
    final dbReports = await (_database.select(_database.dBReport)
          ..orderBy([
            (report) => OrderingTerm(
                  expression: report.date,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
    reports.clear();
    for (var dbReport in dbReports) {
      final dbReportEntries = await (_database.select(
        _database.dBReportEntry,
      )..where((entry) => entry.id.isIn(dbReport.entries.items)))
          .get();
      reports.add(
        Report(
          id: dbReport.id,
          date: dbReport.date,
          totalCarbohydrates: dbReport.totalCarbohydrates,
          totalFats: dbReport.totalFats,
          totalProteins: dbReport.totalProteins,
          entries: dbReportEntries
              .map((dbEntry) => ReportEntry.fromJson(dbEntry.toJson()))
              .toSet(),
        ),
      );
    }
    notifyListeners();
  }

  Future<List<int>> _addReportEntries(Set<ReportEntry> entries) async {
    final addedEntries = <int>[];
    for (final entry in entries) {
      final id = await _database.into(_database.dBReportEntry).insert(
            DBReportEntryCompanion.insert(
              quantity: entry.quantity,
              carbohydrates: entry.carbohydrates,
              proteins: entry.proteins,
              fats: entry.fats,
              productId: entry.productId,
            ),
          );
      entry.id = id;
      addedEntries.add(id);
    }
    return addedEntries;
  }

  Future<void> addReport(Report report) async {
    final addedEntries = await _addReportEntries(report.entries);
    final id = await _database.into(_database.dBReport).insert(
          DBReportCompanion.insert(
            date: report.date.normalize,
            totalCarbohydrates: report.totalCarbohydrates,
            totalProteins: report.totalProteins,
            totalFats: report.totalFats,
            entries: DBReportEntries(items: addedEntries),
          ),
        );
    report.id = id;
    reports.add(report);
    reports.sortByDate();
    notifyListeners();
  }

  Future<void> updateReport(Report report) async {
    final foundPrevReport =
        reports.firstWhere((element) => element.id == report.id);

    // Delete then Add Report Entries
    await (_database.delete(_database.dBReportEntry)
          ..where(
            (entry) =>
                entry.id.isIn(foundPrevReport.entries.map((entry) => entry.id)),
          ))
        .go();
    await _addReportEntries(report.entries);

    // Update Report
    final dbReport = DBReportData(
      id: report.id,
      date: report.date,
      totalCarbohydrates: report.totalCarbohydrates,
      totalProteins: report.totalProteins,
      totalFats: report.totalFats,
      entries: DBReportEntries(
        items: report.entries.map((entry) => entry.id).toList(),
      ),
    );
    await _database.update(_database.dBReport).replace(dbReport);
    reports.remove(foundPrevReport);
    reports.add(report);
    reports.sortByDate();
    notifyListeners();
  }

  Future<void> deleteReport(int id) async {
    final wasDeleted = await (_database.delete(
      _database.dBReport,
    )..where((e) => e.id.equals(id)))
        .go();
    if (wasDeleted < 1) {
      return;
    }
    final foundIndex = reports.firstWhere((element) => element.id == id);
    reports.remove(foundIndex);
    reports.sortByDate();
    notifyListeners();
  }

  Future<void> loadProducts() async {
    final response = await (_database.select(_database.dBProduct)
          ..orderBy([
            (product) => OrderingTerm(
                  expression: product.name,
                  mode: OrderingMode.asc,
                ),
          ]))
        .get();
    products.clear();
    products.addAll(response.map(
      (product) => Product(
        id: product.id,
        name: product.name,
        image: product.image,
        units: product.units,
        quantity: product.quantity,
        carbohydrates: product.carbohydrates,
        proteins: product.proteins,
        fats: product.fats,
        cooked: product.cooked,
      ),
    ));
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final id = await _database.into(_database.dBProduct).insert(
          DBProductCompanion.insert(
            name: product.name,
            image: Value(product.image),
            units: product.units,
            quantity: product.quantity,
            carbohydrates: product.carbohydrates,
            proteins: product.proteins,
            fats: product.fats,
            cooked: product.cooked,
          ),
        );
    product.id = id;
    products.add(product);
    products.sortByName();
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final wasChanged = await _database.update(_database.dBProduct).replace(
          DBProductData(
            id: product.id,
            image: product.image,
            name: product.name,
            units: product.units,
            quantity: product.quantity,
            carbohydrates: product.carbohydrates,
            proteins: product.proteins,
            fats: product.fats,
            cooked: product.cooked,
          ),
        );
    if (!wasChanged) {
      return;
    }
    final foundProductIndex =
        products.indexWhere((element) => element.id == product.id);
    products[foundProductIndex] = product;
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    final wasDelete = await (_database.delete(_database.dBProduct)
          ..where((e) => e.id.equals(id)))
        .go();
    if (wasDelete < 1) {
      return;
    }
    final foundProductToDelete =
        products.firstWhere((element) => element.id == id);
    products.remove(foundProductToDelete);
    notifyListeners();
  }

  Future<void> loadDailyLimit() async {
    final rootPath = await getApplicationSupportDirectory();
    final dailyLimitFile = File(join(rootPath.path, 'daily_limit.json'));
    if (dailyLimitFile.existsSync()) {
      final dailyLimitjson = jsonDecode(dailyLimitFile.readAsStringSync());
      _dailyLimit = DailyLimit.fromJson(dailyLimitjson);
    }
  }

  DailyLimit get dailyLimit {
    return DailyLimit.fromJson(_dailyLimit.toJson());
  }

  Future<void> setDailyLimit(DailyLimit dailyLimit) async {
    final rootPath = await getApplicationSupportDirectory();
    _dailyLimit = dailyLimit;
    File(join(rootPath.path, 'daily_limit.json'))
        .writeAsStringSync(jsonEncode(dailyLimit.toJson()));
  }

  Future<void> exportProducts() async {
    final products = await (_database.select(_database.dBProduct)
          ..orderBy([
            (product) => OrderingTerm(
                  expression: product.name,
                  mode: OrderingMode.asc,
                ),
          ]))
        .get();
    final dir = await getApplicationDocumentsDirectory();
    final exportFile = File(
      join(
        dir.path,
        'diet_tracker_${DateTime.now().toIso8601String()}.json',
      ),
    );
    final jsonData = jsonEncode(
      products.map((product) => product.toJson()).toList(),
    );
    exportFile.createSync();
    exportFile.writeAsStringSync(jsonData);
  }
}
