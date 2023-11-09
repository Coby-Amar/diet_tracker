import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/models/display.dart';
import 'package:mobx/mobx.dart';

import 'package:diet_tracker/resources/api/reports.dart';

part 'reports.g.dart';

class ReportsStore extends _ReportsStore with _$ReportsStore {
  ReportsStore() {
    load();
  }
}

abstract class _ReportsStore with Store {
  final _reportsApi = ReportsApi();

  @observable
  var reports = ObservableList<ApiReport>();

  @action
  Future<void> load() async {
    try {
      final fetchedReports = await _reportsApi.getReports();
      if (fetchedReports != null) {
        reports.addAll(fetchedReports);
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<List<ApiEntry>?> loadEntries(String reportId) async {
    try {
      final loadedEntries = await _reportsApi.getReportEntries(reportId);
      if (loadedEntries != null) {
        return loadedEntries;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @action
  Future<void> create(DisplayReportWithEntries reportWithEntries) async {
    try {
      final createdReport = await _reportsApi.createReport(reportWithEntries);
      if (createdReport != null) {
        reports.add(createdReport);
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> update(DisplayReportWithEntries reportWithEntries) async {
    try {
      final updatedReport = await _reportsApi.updateReport(reportWithEntries);
      if (updatedReport != null) {
        final foundIndex =
            reports.indexWhere((product) => product.id == updatedReport.id);
        if (foundIndex > -1) {
          reports.replaceRange(
            foundIndex,
            foundIndex + 1,
            [updatedReport],
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> delete(String reportId) async {
    try {
      await _reportsApi.deleteReport(reportId);
      reports.removeWhere((element) => element.id == reportId);
    } catch (e) {
      print(e);
    }
  }
}
