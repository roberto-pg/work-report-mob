import 'package:flutter_modular/flutter_modular.dart';
import 'package:work_report/app/repositories/user/user_repository_impl.dart';
import 'package:work_report/app/services/user/user_service_impl.dart';
import 'home_store.dart';
import './home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => UserRepositoryImpl(customDioAuth: i())),
    Bind.lazySingleton((i) => UserServiceImpl(repository: i())),
    Bind.lazySingleton((i) => HomeStore(userService: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage()),
  ];
}
