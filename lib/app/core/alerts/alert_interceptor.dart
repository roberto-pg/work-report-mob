import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

alertInterceptor(
  final VoidCallback confirmFunction,
) {
  return asuka.showDialog(
      barrierDismissible: false,
      builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: AlertDialog(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text(
                'Oops',
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
                'Algo deu errado...\nFaça o login novamente',
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
                      'Fechar',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    onPressed: () => [
                          confirmFunction(),
                          Navigator.of(context).pop(),
                          Navigator.of(context).pop()
                        ]),
              ],
            ),
          ));
}
