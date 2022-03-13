import 'package:dio/dio.dart';
import 'package:work_report/app/core/errors/exceptions.dart';
import 'package:work_report/app/services/report/report_service.dart';

class StartReportStore {
  final ReportService _reportService;

  StartReportStore({required ReportService reportService})
      : _reportService = reportService;

  Future<void> startReport(FormData formData) async {
    try {
      await _reportService.startReport(formData);
    } catch (error) {
      throw CustomException(error.toString());
    }
  }
}
