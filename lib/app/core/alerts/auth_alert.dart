import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

authAlert(final String message) {
  return asuka.showDialog(
    builder: (BuildContext context) => Padding(
      padding: const EdgeInsets.all(30.0),
      child: AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Erro',
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
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ),
  );
}
