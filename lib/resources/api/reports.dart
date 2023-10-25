import 'package:diet_tracker/dio_client.dart';
import 'package:diet_tracker/resources/models.dart';

class ReportsApi {
  final dioClient = DioClient().dio;

  Future<List<ReportModel>?> getReports() async {
    try {
      final response = await dioClient.get("reports");
      print(response.data);
      if (response.data != null) {
        return (response.data as Iterable)
            .map((e) => ReportModel.fromMap(e))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ReportModel?> createReport(ReportWithEntries report) async {
    try {
      final response = await dioClient.post("reports", data: report);
      final data = response.data;
      if (data is Map<String, dynamic>) {
        print(data);
        return ReportModel.fromMap(data);
      }
      return null;
    } catch (e) {
      print("createReport error: $e");
      return null;
    }
  }

  Future<ReportModel?> updateReport(ReportModel report) async {
    final response =
        await dioClient.patch("reports/${report.id}", data: report);
    if (response.data) {
      return ReportModel.fromMap(response.data);
    }
    return null;
  }

  Future<bool> deleteReport(String reportId) async {
    try {
      await dioClient.delete("reports/$reportId");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<ReportModel?> createEntry(EntryModel entry) async {
    final response = await dioClient.post("reports", data: entry);
    if (response.data) {
      return ReportModel.fromMap(response.data);
    }
    return null;
  }

  Future<ReportModel?> updateEntry(EntryModel entry) async {
    final response = await dioClient.patch("reports/${entry.id}", data: entry);
    if (response.data) {
      return ReportModel.fromMap(response.data);
    }
    return null;
  }

  Future<void> deleteEntry(String reportId) async {
    await dioClient.delete("report/$reportId");
  }
}
