import 'package:diet_tracker/resources/api/reports.dart';
import 'package:diet_tracker/resources/models.dart';
import 'package:mobx/mobx.dart';

part 'reports.g.dart';

class ReportsStore extends _ReportsStore with _$ReportsStore {
  ReportsStore() {
    load();
  }
}

abstract class _ReportsStore with Store {
  final _reportsApi = ReportsApi();

  @observable
  var reports = ObservableList<ReportModel>();

  @action
  Future<void> load() async {
    final fetchedReports = await _reportsApi.getReports();
    if (fetchedReports != null) {
      reports.addAll(fetchedReports);
    }
  }

  @action
  Future<void> create(ReportWithEntries reportWithEntries) async {
    final createdReport = await _reportsApi.createReport(reportWithEntries);
    print("createdReport : $createdReport");
    if (createdReport != null) {
      reports.add(createdReport);
    }
  }

  @action
  Future<void> delete(String reportId) async {
    if (await _reportsApi.deleteReport(reportId)) {
      reports.removeWhere((element) => element.id == reportId);
    }
  }
}
