import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: asuka.builder,
      theme: ThemeData(
        primaryColor: const Color(0XFFf64e8b),
        primaryColorLight: const Color(0XFFf6c90e),
        primaryColorDark: const Color(0XFF3a4750),
      ),
      title: 'Work Report',
      debugShowCheckedModeBanner: false,
      // ignore: deprecated_member_use
    ).modular();
  }
}
