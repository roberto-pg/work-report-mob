import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:work_report/app/services/auth/auth_service.dart';

class RegisterStore {
  final AuthService _authService;

  RegisterStore({required AuthService authService})
      : _authService = authService;

  Future<void> addUser(
      String name, String email, String cpf, String password) async {
    try {
      await _authService.addUser(name, email, cpf, password);
      // Modular.to.navigate('/auth/login');
    } catch (e, s) {
      log(s.toString());
      log(e.toString());
    }
  }
}
