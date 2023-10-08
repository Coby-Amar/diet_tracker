import 'dart:async';

import 'package:diet_tracker/providers/db.dart';
import 'package:diet_tracker/providers/models.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class ProductsProvider with ChangeNotifier {
  static const String table = 'products';

  List<ProductModel> products = [];

  ProductsProvider() {
    loadProducts();
  }

  loadProducts() async {
    final db = await DBHelper().database;
    final productsMaps = await db.query(table);
    products = productsMaps.map((e) => ProductModel.fromMap(e)).toList();
    notifyListeners();
  }

  static FutureOr<void> onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table ( 
            ${BaseModel.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, 
            ${BaseModel.createdAtColumn} TEXT NOT NULL,
            ${BaseModel.updatedAtColumn} TEXT NOT NULL,
            ${ProductModel.imageColumn} TEXT DEFAULT NULL,
            ${ProductModel.nameColumn} TEXT NOT NULL UNIQUE,
            ${ProductModel.amountColumn} INTEGER NOT NULL,
            ${ProductModel.carbohydrateColumn} INTEGER NOT NULL,
            ${ProductModel.proteinColumn} INTEGER NOT NULL,
            ${ProductModel.fatColumn} INTEGER NOT NULL
          )
        ''');
  }

  createProduct(ProductModel product) async {
    final db = await DBHelper().database;
    try {
      final mapProduct = product.toMap();
      final id = await db.insert(table, mapProduct);
      products
          .add(ProductModel.fromMap({BaseModel.idColumn: id, ...mapProduct}));
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  updateProduct(ProductModel product) async {
    final db = await DBHelper().database;
    try {
      final mapProduct = product.toMap();
      await db.update(table, mapProduct, where: product.id.toString());
      final index = products.indexOf(product);
      if (index > -1) {
        products.replaceRange(index, index + 1, [product]);
        notifyListeners();
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
