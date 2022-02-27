import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:work_report/app/core/env.dart';



class CustomDio extends DioForNative {
  static final _baseOptions = BaseOptions(
    baseUrl: Env.baseUrl,
    connectTimeout: 20000,
    receiveTimeout: 20000,
  );

  CustomDio() : super(_baseOptions);
}
