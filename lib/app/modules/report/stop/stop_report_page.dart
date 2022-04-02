import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:validatorless/validatorless.dart';
import 'package:work_report/app/core/alerts/alert_factory.dart';
import 'package:work_report/app/core/ui/widgets/work_button.dart';
import 'package:work_report/app/modules/report/stop/stop_report_store.dart';
import '../camera_screen_widget.dart';
import '../report_store.dart';

class StopReportPage extends StatefulWidget {
  final String id;
  final String initialImage;

  const StopReportPage({Key? key, required this.id, required this.initialImage})
      : super(key: key);

  @override
  _StopReportPageState createState() => _StopReportPageState();
}

class _StopReportPageState
    extends ModularState<StopReportPage, StopReportStore> {
  final reportStore = Modular.get<ReportStore>();
  bool get _isTokenExpired => reportStore.isTokenExpired;
  final _formKey = GlobalKey<FormState>();
  String description = '';
  DateTime stopReport = DateTime.now();
  String? get imageFile => reportStore.image.value;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    reportStore.image.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Dialog(
                            insetPadding: EdgeInsets.symmetric(vertical: 20),
                            child: CameraScreenWidget(),
                          );
                        });
                  },
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      decoration: const BoxDecoration(),
                      width: MediaQuery.of(context).size.width,
                      height: 190.0,
                      child: imageFile!.isEmpty
                          ? Column(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 100.0,
                                  color: Theme.of(context).primaryColor,
                                ),
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
                              child: Image.file(File(imageFile!),
                                  fit: BoxFit.contain),
                            ),
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
                const SizedBox(height: 5),
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
                    onSaved: (value) => description = value ?? '',
                    validator:
                        Validatorless.required('Descrição final obrigatória'),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WorkButton(
                      onPressed: () {
                        Modular.to.navigate('/home/');
                      },
                      label: 'Cancelar',
                      width: 120,
                      height: 50,
                    ),
                    WorkButton(
                      onPressed: () {
                        alertFactory(
                            titleText: 'Confirmação',
                            contentText: 'Deseja excluir a tarefa?',
                            confirmButtonText: 'Excluir',
                            cancelButtonText: 'Cancelar',
                            confirmFunction: () async => [
                                  await store.deleteReport(
                                      widget.id, widget.initialImage),
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(),
                                  Modular.to.navigate('/home'),
                                ],
                            cancelFunction: () => [
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(),
                                  Modular.to.navigate('/home'),
                                ]);
                      },
                      label: 'Excluir',
                      width: 120,
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                WorkButton(
                  onPressed: () async {
                    await reportStore.validToken();
                    if (_isTokenExpired) {
                      alertFactory(
                          titleText: 'Oops!!',
                          contentText:
                              'Algo deu errado...\nFaça o login novamente',
                          cancelButtonText: 'Fechar',
                          cancelFunction: () => {
                                reportStore.logout(),
                                Modular.to.navigate('/auth/login'),
                                Navigator.of(context, rootNavigator: true).pop()
                              });
                    } else {
                      var formValid =
                          _formKey.currentState?.validate() ?? false;

                      if (formValid) {
                        _formKey.currentState!.save();

                        if (imageFile!.isEmpty) {
                          alertFactory(
                            dismissible: true,
                            titleText: 'Oops!!',
                            contentText: 'Imagem obrigatória',
                          );
                          return;
                        }

                        var formData = FormData.fromMap({
                          "finalDescription": description,
                          "imageUrl": await MultipartFile.fromFile(imageFile!,
                              filename: imageFile!,
                              contentType: MediaType('image', 'png')),
                          "stopedAt": stopReport,
                        });

                        await store.stopReport(formData, widget.id);
                        alertFactory(
                            titleText: 'Sucesso!',
                            contentText: 'Serviço finalizado',
                            cancelButtonText: 'Fechar',
                            cancelFunction: () => {
                                  Modular.to.navigate('/home/'),
                                  Navigator.of(context, rootNavigator: true)
                                      .pop()
                                });
                      }
                    }
                  },
                  label: 'Finalizar',
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
