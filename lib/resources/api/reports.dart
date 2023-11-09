import 'package:diet_tracker/dio_client.dart';
import 'package:diet_tracker/resources/models/api.dart';
import 'package:diet_tracker/resources/models/display.dart';

class ReportsApi {
  final dioClient = DioClient();

  Future<List<ApiReport>?> getReports() async {
    try {
      final response = await dioClient.get("reports");
      if (response.data != null) {
        return (response.data as Iterable)
            .map((e) => ApiReport.fromMap(e))
            .toList();
      }
    } catch (e) {
      print("getReports: $e");
    }
    return null;
  }

  Future<List<ApiEntry>?> getReportEntries(String reportId) async {
    try {
      final response = await dioClient.get("reports/$reportId/entries");
      if (response.data != null) {
        return (response.data as Iterable)
            .map((e) => ApiEntry.fromMap(e))
            .toList();
      }
    } catch (e) {
      print("getReports: $e");
    }
    return null;
  }

  Future<ApiReport?> createReport(
    DisplayReportWithEntries reportWithEntries,
  ) async {
    try {
      final response =
          await dioClient.post("reports", data: reportWithEntries.toMap());
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return ApiReport.fromMap(data);
      }
      return null;
    } catch (e) {
      print("createReport error: $e");
      return null;
    }
  }

  Future<ApiReport?> updateReport(
    DisplayReportWithEntries reportWithEntries,
  ) async {
    try {
      final response =
          await dioClient.put("reports", data: reportWithEntries.toMap());
      if (response.data) {
        return ApiReport.fromMap(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteReport(String reportId) async {
    try {
      await dioClient.delete("reports/$reportId");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<ApiEntry?> createEntry(DisplayEntry entry) async {
    final response = await dioClient.post("reports", data: entry);
    if (response.data) {
      return ApiEntry.fromMap(response.data);
    }
    return null;
  }

  Future<ApiEntry?> updateEntry(ApiEntry entry) async {
    final response = await dioClient.put("reports/${entry.id}", data: entry);
    if (response.data) {
      return ApiEntry.fromMap(response.data);
    }
    return null;
  }

  Future<void> deleteEntry(String reportId) async {
    await dioClient.delete("report/$reportId");
  }
}
