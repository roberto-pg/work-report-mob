import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_report/app/core/ui/widgets/work_button.dart';

class StartReportPage extends StatefulWidget {
  const StartReportPage({Key? key}) : super(key: key);

  @override
  _StartReportPageState createState() => _StartReportPageState();
}

class _StartReportPageState extends State<StartReportPage> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF3a4750),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0XFF3a4750),
        title: Text(
          'Iniciar Tarefa',
          style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
        ),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(),
              width: 250.0,
              height: 190.0,
              child: imageFile == null
                  ? Column(children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Icon(Icons.camera_alt,
                            size: 100.0, color: Color(0xFF20A37F)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Toque para adicionar imagem',
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                      )
                    ])
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(imageFile!, fit: BoxFit.contain),
                    ),
            ),
          ),
          TextFormField(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'Descrição do serviço',
            ),
          ),
          WorkButton(
            onPressed: () {},
            label: 'Salvar',
            width: 120,
            height: 50,
          ),
          WorkButton(
            onPressed: () {},
            label: 'Salvar',
            width: 120,
            height: 50,
          )
        ],
      ),
    );
  }
}
