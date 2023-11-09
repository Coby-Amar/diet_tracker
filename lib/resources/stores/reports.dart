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
    final fetchedReports = await _reportsApi.getReports();
    if (fetchedReports != null) {
      reports.addAll(fetchedReports);
    }
  }

  @action
  Future<List<ApiEntry>?> loadEntries(String reportId) async {
    final loadedEntries = await _reportsApi.getReportEntries(reportId);
    if (loadedEntries != null) {
      return loadedEntries;
    }
    return null;
  }

  @action
  Future<void> create(DisplayReportWithEntries reportWithEntries) async {
    final createdReport = await _reportsApi.createReport(reportWithEntries);
    if (createdReport != null) {
      reports.add(createdReport);
    }
  }

  @action
  Future<void> update(DisplayReportWithEntries reportWithEntries) async {
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
  }

  @action
  Future<void> delete(String reportId) async {
    if (await _reportsApi.deleteReport(reportId)) {
      reports.removeWhere((element) => element.id == reportId);
    }
  }
}
