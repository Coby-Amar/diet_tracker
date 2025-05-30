import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

abstract class BaseModel {
  late int id;
}

enum ImageType {
  @JsonValue("none")
  none,
  @JsonValue("file")
  file,
  @JsonValue("asset")
  asset,
}

enum Units {
  @JsonValue("קלום")
  none,
  @JsonValue("גרם")
  grams,
  @JsonValue('ק"ג')
  kilograms,
  @JsonValue("פאונד")
  pounds,
  @JsonValue("המגישה")
  serving,
}

const _unitTranslations = {
  Units.none: '',
  Units.grams: 'גרם',
  Units.kilograms: 'ק"ג',
  Units.pounds: 'פאונד',
  Units.serving: 'המגישה',
};

extension UnitNames on Units {
  String get translation {
    return _unitTranslations[this] ?? '';
  }
}

class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(List<int>? json) {
    if (json == null) return null;

    return Uint8List.fromList(json);
  }

  @override
  List<int>? toJson(Uint8List? object) {
    if (object == null) return null;

    return object.toList();
  }
}

@JsonSerializable(explicitToJson: true)
class Product implements BaseModel {
  @override
  int id;
  @Uint8ListConverter()
  Uint8List? image;
  String name;
  Units units;
  double quantity;
  double carbohydrates;
  double proteins;
  double fats;
  bool cooked;

  Product({
    this.id = -1,
    this.image,
    this.name = '',
    this.units = Units.none,
    this.quantity = -1,
    this.carbohydrates = -1,
    this.proteins = -1,
    this.fats = -1,
    this.cooked = false,
  });

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);

  Map<String, Object?> toJson() {
    return _$ProductToJson(this);
  }
}

extension ProductImage on Product {
  Widget get imageOrDefault {
    if (image?.isNotEmpty ?? false) {
      return Image.memory(image!);
    }
    return const Image(image: AssetImage('assets/icon.png'));
  }
}

@JsonSerializable()
class ReportEntry implements BaseModel {
  @override
  int id;
  int productId;
  double quantity;
  double carbohydrates;
  double proteins;
  double fats;

  ReportEntry({
    this.id = -1,
    this.productId = -1,
    this.quantity = 0,
    this.carbohydrates = 0,
    this.proteins = 0,
    this.fats = 0,
  });

  factory ReportEntry.fromJson(Map<String, Object?> json) =>
      _$ReportEntryFromJson(json);

  Map<String, Object?> toJson() {
    return _$ReportEntryToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class Report implements BaseModel {
  @override
  int id;
  final Set<ReportEntry> entries;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime date;
  double totalCarbohydrates;
  double totalProteins;
  double totalFats;

  Report({
    this.id = -1,
    date,
    this.entries = const {},
    this.totalCarbohydrates = -1,
    this.totalProteins = -1,
    this.totalFats = -1,
  }) : date = date ?? DateTime.now();

  factory Report.fromJson(Map<String, Object?> json) => _$ReportFromJson(json);

  Map<String, Object?> toJson() {
    return _$ReportToJson(this);
  }

  static DateTime _fromJson(int time) =>
      DateTime.fromMillisecondsSinceEpoch(time);
  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;

  void addEntry(ReportEntry entry) {
    entries.add(entry);
    if (totalCarbohydrates < 0) {
      totalCarbohydrates = 0;
      totalProteins = 0;
      totalFats = 0;
    }
    totalCarbohydrates += entry.carbohydrates;
    totalProteins += entry.proteins;
    totalFats += entry.fats;
  }

  void removeEntry(ReportEntry entry) {
    entries.remove(entry);
    if (totalCarbohydrates <= 0) {
      return;
    }
    totalCarbohydrates -= entry.carbohydrates;
    totalProteins -= entry.proteins;
    totalFats -= entry.fats;
  }
}

@JsonSerializable(explicitToJson: true)
class DailyLimit implements BaseModel {
  double totalCarbohydrates;
  double totalProteins;
  double totalFats;

  DailyLimit({
    this.id = -1,
    this.totalCarbohydrates = -1,
    this.totalProteins = -1,
    this.totalFats = -1,
  });

  factory DailyLimit.fromJson(Map<String, Object?> json) =>
      _$DailyLimitFromJson(json);

  Map<String, Object?> toJson() {
    return _$DailyLimitToJson(this);
  }

  @override
  int id;
}
