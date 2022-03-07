import 'package:flutter/foundation.dart';
import 'package:work_report/app/modules/home/home_state.dart';
import 'package:work_report/app/services/auth/auth_service.dart';

class HomeStore extends ValueNotifier<HomeState> {
  final AuthService _authService;

  HomeStore({required AuthService authService})
      : _authService = authService,
        super(InitialHome());

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
