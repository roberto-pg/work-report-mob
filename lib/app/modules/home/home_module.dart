import 'package:flutter_modular/flutter_modular.dart';
import 'widgets/all_reports/all_reports_store.dart';
import 'home_store.dart';
import './home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AllReportsStore(reportService: i())),
    Bind.lazySingleton((i) => HomeStore(authService: i(), validate: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage()),
  ];
}
