import 'package:flutter/foundation.dart';
import 'package:work_report/app/modules/report/list/list_report_state.dart';
import 'package:work_report/app/services/report/report_service.dart';

class ListReportStore extends ValueNotifier<ListState> {
  final ReportService _service;

  ListReportStore({required ReportService service})
      : _service = service,
        super(InitialList());

  Future<void> loadReportsByFinished(bool finished) async {
    value = LoadingList();
    try {
      final reports = await _service.loadReportsByFinishedAttribute(finished);
      value = LoadedList(reports);
    } catch (e) {
     value = ErrorList(e.toString());
    }
  }
}
