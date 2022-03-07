import 'package:work_report/app/models/report.dart';

abstract class ReportRepository {
  Future<List<Report>> loadReports();
  Future<List<Report>> loadReportsByFinishedAttribute(bool finished);
  Future<Report> loadReportById(String id);
}
