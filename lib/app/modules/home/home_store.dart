import 'package:flutter/foundation.dart';
import 'package:work_report/app/modules/home/home_state.dart';
import 'package:work_report/app/services/user/user_service.dart';

class HomeStore extends ValueNotifier<HomeState> {
  final UserService _userService;

  HomeStore({required UserService userService})
      : _userService = userService,
        super(InitialHome());

  Future<void> loadUserById() async {
    value = LoadingHome();
    try {
      final user = await _userService.loadUserById();
      value = LoadedHome(user);
    } catch (e) {
      value = ErrorHome(e.toString());
    }
  }
}
