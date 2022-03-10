import 'package:flutter_modular/flutter_modular.dart';
import 'package:work_report/app/services/auth/auth_service.dart';

class LoginStore {
  final AuthService _authService;

  LoginStore({required AuthService authService}) : _authService = authService;

  String _userLogin = '';

  String get userLogin => _userLogin;

  String _errorLogin = '';

  String get errorLogin => _errorLogin;

  Future<void> login(String cpf, String password) async {
    try {
      final user = await _authService.login(cpf, password);
      _userLogin = user.id;
      Modular.to.navigate('/home/');
    } catch (e) {
      _errorLogin = e.toString();
    }
  }
}
