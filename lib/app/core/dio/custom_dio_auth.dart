import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:work_report/app/core/env.dart';
import 'package:work_report/app/core/validators/validator.dart';
import 'interceptors/auth_interceptor.dart';

class CustomDioAuth extends DioForNative {
  final FlutterSecureStorage _storage;
  final Validator _validate;

  static final _baseOptions = BaseOptions(
    baseUrl: Env.baseUrl,
    connectTimeout: 20000,
    receiveTimeout: 20000,
  );

  CustomDioAuth(
      {required FlutterSecureStorage storage, required Validator validate})
      : _storage = storage,
        _validate = validate,
        super(_baseOptions) {
    interceptors.addAll([
      AuthInterceptor(storage: _storage, validate: _validate),
    ]);
  }
}
