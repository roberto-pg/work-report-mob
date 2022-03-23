import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:work_report/app/core/utils/elapsed_time.dart';
import 'package:work_report/app/modules/report/detail/detail_report_store.dart';

import 'detail_report_state.dart';

class DetailReportPage extends StatefulWidget {
  final String id;

  const DetailReportPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailReportPageState createState() => _DetailReportPageState();
}

class _DetailReportPageState
    extends ModularState<DetailReportPage, DetailReportStore> {
  String get _userName => store.userName;

  @override
  void initState() {
    super.initState();
    store.loadReportById(widget.id);
    store.getUserName();
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
          'Detalhe da Tarefa',
          style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ValueListenableBuilder(
            valueListenable: store,
            builder: (context, state, child) {
              if (state is LoadedDetail) {
                DateTime? taskStart = DateTime.parse(state.report.startedAt);
                DateTime? taskEnd = DateTime.parse(state.report.stopedAt);
                String? taskDurationTime = elapsedTime(taskEnd, taskStart);

                final dateFormat = DateFormat('dd-MM-yyyy HH:mm');

                DateTime? end = DateTime.parse(state.report.stopedAt);
                DateTime? start = DateTime.parse(state.report.startedAt);

                String? formattedEndTime =
                    dateFormat.format(DateTime.parse(end.toString()));
                String? formattedStartTime =
                    dateFormat.format(DateTime.parse(start.toString()));

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: Text(
                            'Responsável:',
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                          ),
                        ),
                        Text(
                          _userName,
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: Text(
                            'Início:',
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                          ),
                        ),
                        Text(
                          formattedStartTime,
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: Text(
                            'Final:',
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                          ),
                        ),
                        Text(
                          formattedEndTime,
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: Text(
                            'Duração:',
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                          ),
                        ),
                        Text(
                          taskDurationTime ?? '',
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0, bottom: 5.0),
                      child: Text(
                        'Avaliação inicial:',
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          state.report.initialDescription,
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic)),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0, bottom: 5.0),
                      child: Text(
                        'Serviço executado:',
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          state.report.finalDescription,
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic)),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 5.0),
                      child: Text(
                        'Imagem inicial',
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Modular.to.pushNamed('/report/initial-image',
                                  arguments: state.report.initialImage);
                            },
                            child: Image.network(
                              state.report.initialImage,
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              height: 180.0,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white, border: Border.all())),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 5.0),
                      child: Text(
                        'Imagem final',
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Modular.to.pushNamed('/report/final-image',
                                arguments: state.report.finalImage);
                          },
                          child: Image.network(
                            state.report.finalImage,
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            height: 180.0,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white, border: Border.all()),
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
