import 'package:dio/dio.dart';
import 'package:work_report/app/core/dio/custom_dio.dart';
import 'package:work_report/app/core/errors/exceptions.dart';
import 'package:work_report/app/models/user.dart';
import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio _customDio;

  AuthRepositoryImpl({required CustomDio customDio}) : _customDio = customDio;

  @override
  Future<User> login(String cpf, String password) async {
    try {
      var response = await _customDio.post(
        '/api/auth-user',
        data: {'cpf': cpf, 'password': password},
      );

      return User.fromMap(response.data);
    } on DioError catch (error) {
      if (error.type.toString() == 'DioErrorType.other') {
        throw const CustomException('Problema inesperado no servidor');
      } else {
        throw CustomException(error.response?.data);
      }
    }
  }

  @override
  Future<String> logout() {
    throw UnimplementedError();
  }
}
