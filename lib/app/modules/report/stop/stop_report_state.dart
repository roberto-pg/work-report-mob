import 'package:work_report/app/models/report.dart';

abstract class StopState {}

class InitialStop extends StopState {}

class LoadingStop extends StopState {}

class LoadedStop extends StopState {
  final Report report;
  LoadedStop(this.report);
}

class ErrorStop extends StopState {
  final String message;
  ErrorStop(this.message);
}
