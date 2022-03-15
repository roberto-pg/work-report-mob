import 'package:dio/dio.dart';
import 'package:work_report/app/models/report.dart';

abstract class ReportRepository {
  Future<List<Report>> loadReports();
  Future<List<Report>> loadReportsByFinishedAttribute(bool finished);
  Future<Report> loadReportById(String id);
  Future<Report> startReport(FormData formData);
  Future<Report> stopReport(FormData formData, String id);
  Future<String> deleteReport(String id, String initialImage);
}
