import 'package:diet_tracker/resources/db.dart';
import 'package:diet_tracker/resources/extensions/dates.extension.dart';
import 'package:diet_tracker/resources/models.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String _searchReportsQuery = '';
  String _searchProductsQuery = '';
  final List<Report> reports = [];
  final List<Product> products = [];
  AppProvider() {
    loadReports();
    loadProducts();
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
        .where((element) => element.date.toDayMonthYear
            .replaceAll('/', '')
            .contains(_searchReportsQuery.replaceAll('/', '')))
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
    final response = await DBService.instance.loadReports();
    reports.clear();
    reports.addAll(response);
    notifyListeners();
  }

  Future<void> loadProducts() async {
    final response = await DBService.instance.loadProducts();
    products.clear();
    products.addAll(response);
    notifyListeners();
  }

  Future<void> addReport(Report report) async {
    final response = await DBService.instance.addReport(report);
    if (!response) {
      return Future.value();
    }
    reports.add(report);
    notifyListeners();
  }

  Future<void> updateReport(Report report) async {
    final response = await DBService.instance.updateReport(report);
    if (!response) {
      return Future.value();
    }
    final foundIndex = reports.indexWhere((element) => element.id == report.id);
    if (foundIndex < 0) {
      return Future.value();
    }
    reports.removeAt(foundIndex);
    reports.insert(foundIndex, report);
    notifyListeners();
  }

  Future<void> deleteReport(String id) async {
    final response = await DBService.instance.deleteReport(id);
    if (!response) {
      return Future.value();
    }
    final foundIndex = reports.indexWhere((element) => element.id == id);
    if (foundIndex < 0) {
      return Future.value();
    }
    reports.removeAt(foundIndex);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final response = await DBService.instance.addProduct(product);
    if (!response) {
      return Future.value();
    }
    products.add(product);
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final response = await DBService.instance.updateProduct(product);
    if (!response) {
      return Future.value();
    }
    final foundIndex =
        products.indexWhere((element) => element.id == product.id);
    if (foundIndex < 0) {
      return Future.value();
    }
    products.removeAt(foundIndex);
    products.insert(foundIndex, product);
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final response = await DBService.instance.deleteProduct(id);
    if (!response) {
      return Future.value();
    }
    final foundIndex = products.indexWhere((element) => element.id == id);
    if (foundIndex < 0) {
      return Future.value();
    }
    products.removeAt(foundIndex);
    notifyListeners();
  }
}
