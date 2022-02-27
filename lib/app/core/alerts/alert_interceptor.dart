import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

alertInterceptor(
  final VoidCallback confirmFunction,
) {
  return asuka.showDialog(
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            title: const Text('Oops'),
            content: const Text('Algo deu errado...\nFaça o login novamente'),
            actions: [
              TextButton(
                  child: const Text('Fechar'),
                  onPressed: () => [
                        confirmFunction(),
                        Navigator.of(context, rootNavigator: true).pop()
                      ]),
            ],
          ));
}
