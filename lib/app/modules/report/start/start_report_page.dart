import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _selectorImageSource();
                },
                child: Card(
                  color: Colors.white,
                  child: Container(
                    decoration: const BoxDecoration(),
                    width: MediaQuery.of(context).size.width,
                    height: 190.0,
                    child: imageFile == null
                        ? Column(
                            children: <Widget>[
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
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text('Descreva o serviço:',
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
                    label: 'Salvar',
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

  _selectorImageSource() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AlertDialog(
              title: Text('Escolha a origem:',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  )),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _openCamera();
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(9.0)),
                      child: Text("Camera",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openGallery();
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(9.0)),
                      child: Text("Galeria",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _openCamera() async {
    final imagePicker = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 50);
    if (imagePicker == null) return;
    setState(() {
      imageFile = File(imagePicker.path);
    });
  }

  _openGallery() async {
    final imagePicker = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 50);
    if (imagePicker == null) return;
    setState(() {
      imageFile = File(imagePicker.path);
    });
  }
}
