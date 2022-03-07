import 'package:work_report/app/models/report.dart';

abstract class AllReportsState {}

class InitialReport extends AllReportsState {}

class LoadedReport extends AllReportsState {
  final List<Report> report;
  LoadedReport(this.report);
}

class LoadingReport extends AllReportsState {}

class ErrorReport extends AllReportsState {
  final String message;
  ErrorReport(this.message);
}
