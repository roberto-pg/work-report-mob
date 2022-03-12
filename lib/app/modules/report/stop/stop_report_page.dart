import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_report/app/core/ui/widgets/work_button.dart';

class StopReportPage extends StatefulWidget {
  const StopReportPage({Key? key}) : super(key: key);

  @override
  _StopReportPageState createState() => _StopReportPageState();
}

class _StopReportPageState extends State<StopReportPage> {
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
          'Finalizar Tarefa',
          style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                child: Container(
                  decoration: const BoxDecoration(),
                  width: MediaQuery.of(context).size.width,
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
              const SizedBox(height: 30),
              Text('Serviço realizado:',
                  style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WorkButton(
                    onPressed: () {},
                    label: 'Finalizar',
                    width: 120,
                    height: 50,
                  ),
                  WorkButton(
                    onPressed: () {},
                    label: 'Cancelar',
                    width: 120,
                    height: 50,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
