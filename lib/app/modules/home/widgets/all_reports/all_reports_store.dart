import 'package:flutter/foundation.dart';
import 'package:work_report/app/modules/home/widgets/all_reports/all_reports_state.dart';
import 'package:work_report/app/services/report/report_service.dart';

class AllReportsStore extends ValueNotifier<AllReportsState> {
  final ReportService _reportService;

  AllReportsStore({required ReportService reportService})
      : _reportService = reportService,
        super(InitialReport());

  Future<void> loadReports() async {
    value = LoadingReport();
    try {
      final reports = await _reportService.loadReports();
      value = LoadedReport(reports);
    } catch (e) {
      value = ErrorReport(e.toString());
    }
  }
}
