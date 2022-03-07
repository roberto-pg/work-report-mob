import 'package:work_report/app/models/report.dart';

abstract class StartState {}

class InitialStart extends StartState {}

class LoadingStart extends StartState {}

class LoadedStart extends StartState {
  final Report report;
  LoadedStart(this.report);
}

class ErrorStart extends StartState {}
