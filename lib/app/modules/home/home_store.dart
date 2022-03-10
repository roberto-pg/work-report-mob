import 'package:flutter/foundation.dart';
import 'package:work_report/app/core/validators/validator.dart';
import 'package:work_report/app/modules/home/home_state.dart';
import 'package:work_report/app/services/auth/auth_service.dart';

class HomeStore extends ValueNotifier<HomeState> {
  final AuthService _authService;
  final Validator _validate;

  HomeStore({required AuthService authService, required Validator validate})
      : _authService = authService,
        _validate = validate,
        super(InitialHome());

  bool _isTokenExpired = false;

  bool get isTokenExpired => _isTokenExpired;

  Future<void> validToken() async {
    _isTokenExpired = await _validate.expiredToken();
  }

  logout() async {
    await _validate.logoutUser();
  }

  Future<void> loadUserById() async {
    value = LoadingHome();
    try {
      final user = await _authService.loadUserById();
      value = LoadedHome(user);
    } catch (e) {
      value = ErrorHome(e.toString());
    }
  }
}
