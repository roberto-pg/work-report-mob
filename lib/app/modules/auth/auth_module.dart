import 'package:flutter_modular/flutter_modular.dart';
import 'package:work_report/app/modules/auth/login/login_store.dart';
import 'login/login_page.dart';
import 'register/register_page.dart';
import 'register/register_store.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore(authService: i())),
    Bind.lazySingleton((i) => RegisterStore(authService: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/login', child: (_, args) => const LoginPage()),
    ChildRoute('/register', child: (_, args) => const RegisterPage()),
  ];
}
