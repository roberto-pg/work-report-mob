import 'package:flutter_modular/flutter_modular.dart';
import 'package:work_report/app/modules/auth/login/login_store.dart';
import 'package:work_report/app/repositories/auth/auth_repository_impl.dart';
import 'package:work_report/app/services/auth/auth_service_impl.dart';
import 'login_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthRepositoryImpl(customDio: i())),
    Bind.lazySingleton((i) => AuthServiceImpl(repository: i(), storage: i())),
    Bind.lazySingleton((i) => LoginStore(service: i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const LoginPage()),
  ];
}
