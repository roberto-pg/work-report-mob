import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:work_report/app/services/auth/auth_service.dart';

class RegisterStore {
  final AuthService _authService;

  RegisterStore({required AuthService authService})
      : _authService = authService;

  String _userRegister = '';

  String get userRegister => _userRegister;

  String _errorRegister = '';

  String get errorRegister => _errorRegister;

  Future<void> addUser(
      String name, String email, String cpf, String password) async {
    try {
      final user = await _authService.addUser(name, email, cpf, password);
      Modular.to.navigate('/auth/login');
      _userRegister = user.id;
    } catch (e, s) {
      log(s.toString());
      _errorRegister = e.toString();
    }
  }
}
