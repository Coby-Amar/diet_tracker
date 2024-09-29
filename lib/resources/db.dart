import 'dart:convert';
import 'dart:io';

import 'package:diet_tracker/resources/models.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _getLocalPath async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}

Future<String> get _getImagePath async {
  final imageDir = Directory('${await _getLocalPath}${separator}images');
  if (!imageDir.existsSync()) {
    imageDir.createSync();
  }
  return imageDir.path;
}

class DBService {
  DBService._();
  static final instance = DBService._();

  Future<String> get productsPath async =>
      '${await _getLocalPath}${separator}products.json';
  Future<String> get reportsPath async =>
      '${await _getLocalPath}${separator}reports.json';
  Future<String> get imageFolderPath async =>
      '${await _getLocalPath}${separator}images';

  void writeToFile<T extends JsonObject>(String filename, List<T> content) {
    final file = File(filename);
    file.writeAsString(jsonEncode(content.map((e) => e.toJson()).toList()));
  }

  List _loadFromFile(String filename, {bool reset = false}) {
    final file = File(filename);
    if (!file.existsSync() || reset) {
      file.writeAsStringSync('[]');
    }
    final content = file.readAsStringSync();
    return jsonDecode(content);
  }

  Future<File> copyProductImageFile(Product product) async =>
      product.image!.copySync('${await _getImagePath}$separator${product.id}');

  /// ********************************************************
  /// Report DB content
  /// ********************************************************
  Future<Iterable<Report>> loadReports() async {
    final contents = _loadFromFile(await reportsPath);
    return contents.map((e) => Report.fromJson(jsonDecode(e)));
  }

  Future<bool> addReport(Report report) async {
    final reports = (await loadReports()).toList();
    reports.add(report);
    writeToFile(await reportsPath, reports);
    return true;
  }

  Future<bool> updateReport(Report report) async {
    final reports = (await loadReports()).toList();
    final foundIndex = reports.indexWhere((element) => element.id == report.id);
    if (foundIndex < 0) {
      return Future.value(false);
    }
    reports.removeAt(foundIndex);
    reports.insert(foundIndex, report);
    writeToFile(await reportsPath, reports);
    return true;
  }

  Future<bool> deleteReport(String id) async {
    final reports = (await loadReports()).toList();
    final foundIndex = reports.indexWhere((element) => element.id == id);
    if (foundIndex < 0) {
      return Future.value(false);
    }
    reports.removeAt(foundIndex);
    writeToFile(await reportsPath, reports);
    return true;
  }

  /// ********************************************************
  /// Product DB content
  /// ********************************************************
  Future<Iterable<Product>> loadProducts() async {
    final productsContents = _loadFromFile(await productsPath);
    return productsContents.map((e) => Product.fromJson(jsonDecode(e)));
  }

  Future<bool> addProduct(Product product) async {
    final products = (await loadProducts()).toList();
    if (product.image != null) {
      product.image = await copyProductImageFile(product);
    }
    products.add(product);
    writeToFile(await productsPath, products);
    return true;
  }

  Future<bool> updateProduct(Product product) async {
    final products = (await loadProducts()).toList();
    final foundIndex =
        products.indexWhere((element) => element.id == product.id);
    if (foundIndex < 0) {
      return Future.value(false);
    }
    products.removeAt(foundIndex);
    products.insert(foundIndex, product);
    if (product.image != null && !product.image!.path.contains('images')) {
      product.image = await copyProductImageFile(product);
    }
    writeToFile(await productsPath, products);
    return true;
  }

  Future<bool> deleteProduct(String id) async {
    final products = (await loadProducts()).toList();
    final foundIndex = products.indexWhere((element) => element.id == id);
    if (foundIndex < 0) {
      return Future.value(false);
    }
    products.removeAt(foundIndex);
    writeToFile(await productsPath, products);
    return true;
  }
}
