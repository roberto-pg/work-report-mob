import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:work_report/app/core/dio/custom_dio.dart';
import 'package:work_report/app/core/dio/custom_dio_auth.dart';
import 'package:work_report/app/core/validators/validator_impl.dart';
import 'package:work_report/app/modules/splash/splash_store.dart';
import 'package:work_report/app/modules/home/home_module.dart';
import 'modules/auth/login/login_module.dart';
import 'modules/auth/register/register_module.dart';
import 'modules/splash/splash_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => const FlutterSecureStorage()),
    Bind.singleton((i) => ValidatorImpl(storage: i())),
    Bind.singleton((i) => CustomDio()),
    Bind.singleton((i) => CustomDioAuth(storage: i(), validate: i())),
    Bind.singleton((i) => SplashStore(storage: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const SplashPage()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/auth', module: LoginModule()),
    ModuleRoute('/register', module: RegisterModule())
  ];
}
