import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  final String message;

  const CustomException(this.message);

  @override
  String toString() => message;

  @override
  List<Object?> get props => [];
}
