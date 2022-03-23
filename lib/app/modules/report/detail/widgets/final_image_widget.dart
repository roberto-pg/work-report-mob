import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalImageWidget extends StatelessWidget {
final String id;

  const FinalImageWidget({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF3a4750),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0XFF3a4750),
        title: Text(
          'Imagem Final',
          style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
        ),
      ),
      body: Container(),
    );
  }
}
