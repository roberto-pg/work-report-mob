import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

alertFactory({
  bool dismissible = false,
  String? titleText,
  String? contentText,
  String? confirmButtonText,
  String? cancelButtonText,
  String? dioButtonText,
  VoidCallback? confirmFunction,
  VoidCallback? cancelFunction,
  VoidCallback? dioFunction,
}) {
  return asuka.showDialog(
      barrierDismissible: dismissible,
      builder: (BuildContext context) => AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 50),
            title: Text(
              titleText ?? '',
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
              contentText ?? '',
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
                  confirmButtonText ?? '',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onPressed:
                    confirmFunction != null ? () => confirmFunction() : null,
              ),
              TextButton(
                child: Text(
                  cancelButtonText ?? '',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onPressed:
                    cancelFunction != null ? () => cancelFunction() : null,
              ),
              TextButton(
                  child: Text(
                    dioButtonText ?? '',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onPressed: dioFunction == null
                      ? null
                      : () => [
                            dioFunction(),
                            Navigator.of(context).pop(),
                            Navigator.of(context).pop()
                          ]),
            ],
          ));
}
