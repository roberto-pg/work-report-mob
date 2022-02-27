import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:work_report/app/services/auth/auth_service.dart';

class LoginStore {
  final AuthService _service;

  LoginStore({required AuthService service}) : _service = service;

  Future<void> login(String cpf, String password) async {
    try {
      await _service.login(cpf, password);
      Modular.to.navigate('/home/');
    } catch (e) {
      log(e.toString());
    }
  }
}
