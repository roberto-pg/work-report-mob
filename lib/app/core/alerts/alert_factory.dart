import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

alertFactory(
  final String title,
  final String content,
  final String confirm,
  final String cancel,
  final VoidCallback confirmFunction,
  final VoidCallback cancelFunction,
) {
  return asuka.showDialog(
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.green[100],
            insetPadding: const EdgeInsets.only(left: 40, right: 40),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            content: Text(
              content,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            actions: [
              TextButton(
                child: Text(confirm),
                onPressed: () => confirmFunction(),
              ),
              TextButton(
                child: Text(cancel),
                onPressed: () => cancelFunction(),
              ),
            ],
          ));
}
