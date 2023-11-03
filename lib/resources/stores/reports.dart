import 'package:mobx/mobx.dart';

import 'package:diet_tracker/resources/api/reports.dart';
import 'package:diet_tracker/resources/models/create.dart';
import 'package:diet_tracker/resources/models/display.dart';

part 'reports.g.dart';

class ReportsStore extends _ReportsStore with _$ReportsStore {
  ReportsStore() {
    load();
  }
}

abstract class _ReportsStore with Store {
  final _reportsApi = ReportsApi();

  @observable
  var reports = ObservableList<DisplayReport>();

  @action
  Future<void> load() async {
    final fetchedReports = await _reportsApi.getReports();
    if (fetchedReports != null) {
      reports.addAll(fetchedReports.map((e) => DisplayReport(e)));
    }
  }

  @action
  Future<List<DisplayEntry>?> loadEntries(DisplayReport report) async {
    final loadedEntries = await _reportsApi.getReportEntries(report.id);
    if (loadedEntries != null) {
      return loadedEntries.map((e) => DisplayEntry(e)).toList();
    }
    return null;
  }

  @action
  Future<void> create(CreateUpdateReportWithEntries reportWithEntries) async {
    final createdReport = await _reportsApi.createReport(reportWithEntries);
    if (createdReport != null) {
      reports.add(DisplayReport(createdReport));
    }
  }

  @action
  Future<void> update(
    String reportId,
    CreateUpdateReportWithEntries reportWithEntries,
  ) async {
    final createdReport =
        await _reportsApi.updateReport(reportId, reportWithEntries);
    if (createdReport != null) {
      reports.add(DisplayReport(createdReport));
    }
  }

  @action
  Future<void> delete(String reportId) async {
    if (await _reportsApi.deleteReport(reportId)) {
      reports.removeWhere((element) => element.id == reportId);
    }
  }
}
