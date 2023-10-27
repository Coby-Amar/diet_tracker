import 'package:diet_tracker/resources/models/api.dart';

/// ----------------------------------------------------------------------------
/// abstract DisplayModel class
/// ----------------------------------------------------------------------------
abstract class DisplayModel {
  const DisplayModel();
}

/// ----------------------------------------------------------------------------
/// abstract DisplayAutoCompleteModel class
/// ----------------------------------------------------------------------------
abstract class AutoCompleteModel {
  String get toStringDisplay;
}

/// ----------------------------------------------------------------------------
/// DisplayUser extends DisplayModel
/// ----------------------------------------------------------------------------
class DisplayUser extends DisplayModel {
  final ApiUser _user;

  const DisplayUser(this._user);

  int get carbohydrate {
    return _user.carbohydrate;
  }

  int get protein {
    return _user.protein;
  }

  int get fat {
    return _user.fat;
  }

  String get carbohydrateString {
    return _user.carbohydrate.toStringAsFixed(2);
  }

  String get proteinString {
    return _user.protein.toStringAsFixed(2);
  }

  String get fatString {
    return _user.fat.toStringAsFixed(2);
  }
}

/// ----------------------------------------------------------------------------
/// DisplayProduct extends DisplayModel implements AutoCompleteModel
/// ----------------------------------------------------------------------------
class DisplayProduct extends DisplayModel implements AutoCompleteModel {
  final ApiProduct _product;

  const DisplayProduct(this._product);

  String get id {
    return _product.id;
  }

  String? get image {
    return _product.image;
  }

  String get name {
    return _product.name;
  }

  int get amount {
    return _product.amount;
  }

  int get carbohydrate {
    return _product.carbohydrate;
  }

  int get protein {
    return _product.protein;
  }

  int get fat {
    return _product.fat;
  }

  @override
  String get toStringDisplay => _product.name;
}

/// ----------------------------------------------------------------------------
/// DisplayEntry extends DisplayModel
/// ----------------------------------------------------------------------------
class DisplayEntry extends DisplayModel {
  final ApiEntry _entry;
  const DisplayEntry(this._entry);
  String get productId {
    return _entry.productId;
  }

  int get amount {
    return _entry.amount;
  }

  double get carbohydrates {
    return _entry.carbohydrates;
  }

  double get proteins {
    return _entry.proteins;
  }

  double get fats {
    return _entry.fats;
  }
}

/// ----------------------------------------------------------------------------
/// DisplayReport implements DisplayModel
/// ----------------------------------------------------------------------------
class DisplayReport extends DisplayModel {
  final ApiReport _report;

  const DisplayReport(this._report);

  String get id {
    return _report.id;
  }

  double get carbohydratesTotal {
    return _report.carbohydratesTotal;
  }

  double get proteinsTotal {
    return _report.proteinsTotal;
  }

  double get fatsTotal {
    return _report.fatsTotal;
  }

  String get carbohydratesTotalString {
    return _report.carbohydratesTotal.toStringAsFixed(2);
  }

  String get proteinsTotalString {
    return _report.proteinsTotal.toStringAsFixed(2);
  }

  String get fatsTotalString {
    return _report.fatsTotal.toStringAsFixed(2);
  }

  String get formattedDate {
    final date = _report.date;
    final day = date.day;
    final month = date.month;
    final year = date.year;
    return '$day/$month/$year';
  }
}

/// ----------------------------------------------------------------------------
/// DisplayReportWithEntries extends DisplayModelImplementation
/// ----------------------------------------------------------------------------
class DisplayReportWithEntries extends DisplayModel {
  final DisplayReport report;
  final List<DisplayEntry> entries;

  const DisplayReportWithEntries(this.report, this.entries);
}
