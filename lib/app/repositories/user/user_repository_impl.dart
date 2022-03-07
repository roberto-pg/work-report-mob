import 'package:dio/dio.dart';
import 'package:work_report/app/core/dio/custom_dio_auth.dart';
import 'package:work_report/app/core/errors/exceptions.dart';
import 'package:work_report/app/models/user.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final CustomDioAuth _customDioAuth;

  UserRepositoryImpl({required CustomDioAuth customDioAuth})
      : _customDioAuth = customDioAuth;

  @override
  Future<User> loadUserById() async {
    try {
      var response = await _customDioAuth.get('/api/user-by-id');
      User user = User.fromMap(response.data);
      return user;
    } on DioError catch (error) {
      if (error.type.toString() == 'DioErrorType.other') {
        throw const CustomException('Problema inesperado no servidor');
      } else {
        throw CustomException(error.response?.data);
      }
    }
  }
}
