import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

abstract class JsonObject {
  JsonObject.fromJson(Map<String, dynamic> map);
  String toJson();
}

extension ProductImage on Product {
  Widget? get imageFileOrNull {
    if (image != null) {
      return Image.file(image!);
    }
    return null;
  }
}

class Product extends JsonObject {
  final String id;
  File? image;
  String name;
  String units;
  double quantity;
  double carbohydrates;
  double proteins;
  double fats;

  Product({
    id,
    this.image,
    this.name = '',
    this.units = '',
    this.quantity = 0,
    this.carbohydrates = 0,
    this.proteins = 0,
    this.fats = 0,
  })  : id = id ?? uuid.v4(),
        super.fromJson({});

  Product.fromJson(super.map)
      : id = map['id'],
        image = map['image'] != null ? File(map['image']) : map['image'],
        name = map['name'],
        units = map['units'],
        quantity = map['quantity'],
        carbohydrates = map['carbohydrates'],
        proteins = map['proteins'],
        fats = map['fats'],
        super.fromJson();

  @override
  String toJson() => jsonEncode({
        'id': id,
        'image': image?.path,
        'name': name,
        'units': units,
        'quantity': quantity,
        'carbohydrates': carbohydrates,
        'proteins': proteins,
        'fats': fats,
      });
}

class ReportEntry extends JsonObject {
  final String id;
  String productId;
  double quantity;
  double carbohydrates;
  double proteins;
  double fats;

  ReportEntry({
    id,
    this.productId = '',
    this.quantity = 0,
    this.carbohydrates = 0,
    this.proteins = 0,
    this.fats = 0,
  })  : id = id ?? uuid.v4(),
        super.fromJson({});

  ReportEntry.fromJson(super.map)
      : id = map['id'],
        productId = map['productId'],
        quantity = map['quantity'],
        carbohydrates = map['carbohydrates'],
        proteins = map['proteins'],
        fats = map['fats'],
        super.fromJson();

  @override
  String toJson() => jsonEncode({
        'id': id,
        'productId': productId,
        'quantity': quantity,
        'carbohydrates': carbohydrates,
        'proteins': proteins,
        'fats': fats,
      });
}

class Report extends JsonObject {
  final String id;
  final List<ReportEntry> entries;
  DateTime date;
  double totalCarbohydrates;
  double totalProteins;
  double totalFats;
  Report({
    id,
    date,
    this.entries = const [],
    this.totalCarbohydrates = 0,
    this.totalProteins = 0,
    this.totalFats = 0,
  })  : id = id ?? uuid.v4(),
        date = date ?? DateTime.now(),
        super.fromJson({});

  Report.fromJson(super.map)
      : id = map['id'],
        date = DateTime.parse(map['date']),
        totalCarbohydrates = map['totalCarbohydrates'],
        totalProteins = map['totalProteins'],
        totalFats = map['totalFats'],
        entries = (map['entries'] ?? [])
            .map<ReportEntry>((e) => ReportEntry.fromJson(jsonDecode(e)))
            .toList(),
        super.fromJson();

  @override
  String toJson() => jsonEncode({
        'id': id,
        'date': date.toUtc().toString(),
        'totalCarbohydrates': totalCarbohydrates,
        'totalProteins': totalProteins,
        'totalFats': totalFats,
        'entries': entries.map((e) => e.toJson()).toList(),
      });

  void addEntry(ReportEntry entry) {
    entries.add(entry);
    totalCarbohydrates += entry.carbohydrates;
    totalProteins += entry.proteins;
    totalFats += entry.fats;
  }

  void removeEntry(ReportEntry entry) {
    entries.removeWhere((element) => element.id == entry.id);
    totalCarbohydrates -= entry.carbohydrates;
    totalProteins -= entry.proteins;
    totalFats -= entry.fats;
  }
}
