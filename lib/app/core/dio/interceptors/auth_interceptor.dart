import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../alerts/alert_interceptor.dart';
import '../../validators/validator.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Validator _validate;

  AuthInterceptor(
      {required FlutterSecureStorage storage, required Validator validate})
      : _storage = storage,
        _validate = validate;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await _storage.read(key: 'jwt');

    bool isTokenExpired = await _validate.expiredToken();

    if (isTokenExpired) {
      alertInterceptor(
        () => [
          _validate.logoutUser(),
          Modular.to.navigate('/auth/'),
        ],
      );
    }

    if (!isTokenExpired) {
      options.headers.addAll({
        HttpHeaders.authorizationHeader: ('Bearer ' + token!),
      });
    }

    handler.next(options);
  }
}
