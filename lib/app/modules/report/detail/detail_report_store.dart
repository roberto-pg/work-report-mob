import 'package:flutter/foundation.dart';
import 'package:work_report/app/modules/report/detail/detail_report_state.dart';
import 'package:work_report/app/services/auth/auth_service.dart';
import 'package:work_report/app/services/report/report_service.dart';

class DetailReportStore extends ValueNotifier<DetailReportState> {
  final ReportService _reportService;
  final AuthService _authService;

  DetailReportStore(
      {required ReportService reportService, required AuthService authService})
      : _reportService = reportService,
        _authService = authService,
        super(InitialDetail());

  String _userName = '';

  String get userName => _userName;

  Future<void> getUserName() async {
    var response = await _authService.loadUserById();
    _userName = response.name;
  }

  Future<void> loadReportById(String id) async {
    value = LoadingDetail();
    try {
      final report = await _reportService.loadReportById(id);
      value = LoadedDetail(report);
    } catch (e) {
      value = ErrorDetail(e.toString());
    }
  }
}
