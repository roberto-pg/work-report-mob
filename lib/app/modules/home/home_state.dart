import 'package:work_report/app/models/user.dart';

abstract class HomeState {}

class InitialHome extends HomeState {}

class LoadingHome extends HomeState {}

class LoadedHome extends HomeState {
  final User user;
  LoadedHome(this.user);
}

class ErrorHome extends HomeState {
  final String message;
  ErrorHome(this.message);
}
