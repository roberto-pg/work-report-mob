import 'package:dio/dio.dart';
import 'package:work_report/app/models/report.dart';

abstract class ReportService {
  Future<List<Report>> loadReports();
  Future<List<Report>> loadReportsByFinishedAttribute(bool finished);
  Future<Report> loadReportById(String id);
  Future<Report> startReport(FormData formData);
  Future<Report> stopReport(FormData formData, String id);
}
