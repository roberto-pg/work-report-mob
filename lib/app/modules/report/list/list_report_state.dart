import 'package:work_report/app/models/report.dart';

abstract class ListState {}

class InitialList extends ListState {}

class LoadingList extends ListState {}

class LoadedList extends ListState {
  final List<Report> report;
  LoadedList(this.report);
}

class ErrorList extends ListState {
  final String message;
  ErrorList(this.message);
}
