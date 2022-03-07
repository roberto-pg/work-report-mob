import 'package:work_report/app/models/report.dart';

abstract class DetailReportState {}

class InitialDetail extends DetailReportState {}

class LoadingDetail extends DetailReportState {}

class LoadedDetail extends DetailReportState {
  final Report report;
  LoadedDetail(this.report);
}

class ErrorDetail extends DetailReportState {
  final String message;
  ErrorDetail(this.message);
}
