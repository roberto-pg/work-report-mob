import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            backgroundColor: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            insetPadding: const EdgeInsets.only(left: 40, right: 40),
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            content: Text(
              content,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  confirm,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onPressed: () => confirmFunction(),
              ),
              TextButton(
                child: Text(
                  cancel,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onPressed: () => cancelFunction(),
              ),
            ],
          ));
}
