import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:work_report/app/core/alerts/alert_factory.dart';
import 'package:work_report/app/core/validators/validator_impl.dart';
import 'package:work_report/app/modules/home/home_store.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends ModularState<BottomNavigationWidget, HomeStore> {
  final _validate = Modular.get<ValidatorImpl>();
  int _selectedIndex = 0;
  bool get _isTokenExpired => store.isTokenExpired;

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      await store.validToken();
      if (_isTokenExpired) {
        alertFactory(
            '',
            'Fechar',
            () => {},
            () => {
                  store.logout(),
                  Modular.to.navigate('/auth/login'),
                  Navigator.of(context, rootNavigator: true).pop()
                });
      } else {
        Modular.to.pushNamed('/report/', arguments: true);
      }
    }
    if (_selectedIndex == 1) {
      await store.validToken();
      if (_isTokenExpired) {
        alertFactory(
            '',
            'Fechar',
            () => {},
            () => {
                  store.logout(),
                  Modular.to.navigate('/auth/login'),
                  Navigator.of(context, rootNavigator: true).pop()
                });
      } else {
        Modular.to.pushNamed('/report/', arguments: false);
      }
    }
    if (_selectedIndex == 2) {
      _validate.logoutUser();
      Modular.to.navigate('/auth/login');
    }
    if (_selectedIndex == 3) {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.white,
      unselectedItemColor: Colors.white,
      backgroundColor: const Color(0XFF3a4750),
      currentIndex: _selectedIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.playlist_add_check, color: Colors.white),
          label: 'Finalizadas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.build, color: Colors.white),
          label: 'Abertas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.exit_to_app, color: Colors.white),
          label: 'Logout',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.power_settings_new, color: Colors.white),
          label: 'Fechar',
        ),
      ],
    );
  }
}
