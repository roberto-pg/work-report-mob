import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:work_report/app/modules/splash/splash_store.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashStore> {
  @override
  initState() {
    super.initState();
    controller.countDownTimeSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFF3a4750),
      child: Center(
        child: Image.asset(
          'assets/images/logo_transp.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
