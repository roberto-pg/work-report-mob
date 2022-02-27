import 'package:flutter_modular/flutter_modular.dart';
import './register_controller.dart';
import './register_page.dart';

class RegisterModule extends Module {
    @override
    final List<Bind> binds = [
      Bind.lazySingleton((i) => RegisterController()),
    ];
 
    @override
    final List<ModularRoute> routes = [
      ChildRoute('/', child: (_, args) => const RegisterPage()),
    ];
 
}