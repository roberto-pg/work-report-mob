import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashStore {
  final FlutterSecureStorage _storage;
  final int splashDuration = 1000;

  SplashStore({required FlutterSecureStorage storage}) : _storage = storage;

  countDownTimeSplash() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      var isLogged = await _storage.read(key: 'isLogged');

      if (isLogged == 'true') {
        return Timer(Duration(milliseconds: splashDuration), () {
          Modular.to.navigate('/home/');
        });
      } else {
        return Timer(Duration(milliseconds: splashDuration), () {
          Modular.to.navigate('/auth/');
        });
      }
    }

    return connectivityResult;
  }
}
