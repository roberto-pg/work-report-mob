import 'package:dio/dio.dart';
import 'package:work_report/app/services/report/report_service.dart';

class StopReportStore {
  final ReportService _reportService;

  StopReportStore({required ReportService reportService})
      : _reportService = reportService;

  Future<String> stopReport(FormData formData, String id) async {
    try {
      await _reportService.stopReport(formData, id);
      return 'Relatório iniciado';
    } catch (error) {
      return 'Falha na operação';
    }
  }
}
