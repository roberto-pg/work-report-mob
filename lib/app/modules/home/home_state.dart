import 'package:work_report/app/models/user.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

class LoadedState extends HomeState {
  final User user;
  LoadedState(this.user);
}

class LoadingState extends HomeState {}

class ErrorState extends HomeState {
  final String message;
  ErrorState(this.message);
}
