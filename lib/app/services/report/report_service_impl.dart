import 'package:work_report/app/models/report.dart';
import 'package:work_report/app/repositories/report/report_repository.dart';

import './report_service.dart';

class ReportServiceImpl implements ReportService {
  final ReportRepository _repository;

  ReportServiceImpl({required ReportRepository repository})
      : _repository = repository;

  @override
  Future<List<Report>> loadReports() => _repository.loadReports();

  @override
  Future<List<Report>> loadReportsByFinishedAttribute(bool finished) =>
      _repository.loadReportsByFinishedAttribute(finished);

  @override
  Future<Report> loadReportById(String id) => _repository.loadReportById(id);
}
