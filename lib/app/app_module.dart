import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:work_report/app/core/dio/custom_dio.dart';
import 'package:work_report/app/core/dio/custom_dio_auth.dart';
import 'package:work_report/app/core/validators/validator_impl.dart';
import 'package:work_report/app/modules/report/report_module.dart';
import 'package:work_report/app/modules/splash/splash_store.dart';
import 'package:work_report/app/modules/home/home_module.dart';
import 'modules/auth/auth_module.dart';
import 'modules/splash/splash_page.dart';
import 'repositories/auth/auth_repository_impl.dart';
import 'repositories/report/report_repository_impl.dart';
import 'services/auth/auth_service_impl.dart';
import 'services/report/report_service_impl.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => const FlutterSecureStorage()),
    Bind.singleton((i) => ValidatorImpl(storage: i())),
    Bind.singleton((i) => CustomDio()),
    Bind.singleton((i) => CustomDioAuth(storage: i(), validate: i())),
    Bind.lazySingleton((i) => ReportRepositoryImpl(customDioAuth: i())),
    Bind.lazySingleton((i) => ReportServiceImpl(repository: i())),
    Bind.lazySingleton(
        (i) => AuthRepositoryImpl(customDio: i(), customDioAuth: i())),
    Bind.lazySingleton((i) => AuthServiceImpl(repository: i(), storage: i())),
    Bind.singleton((i) => SplashStore(storage: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const SplashPage()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/report', module: ReportModule()),
  ];
}
