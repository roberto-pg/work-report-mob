import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:work_report/app/core/alerts/alert_factory.dart';
import 'package:work_report/app/core/utils/time_ago.dart';
import 'package:work_report/app/modules/home/home_store.dart';
import 'package:work_report/app/modules/report/list/list_report_state.dart';
import 'package:work_report/app/modules/report/list/list_report_store.dart';

class ListReportPage extends StatefulWidget {
  final bool finished;

  const ListReportPage({Key? key, required this.finished}) : super(key: key);

  @override
  _ListReportPageState createState() => _ListReportPageState();
}

class _ListReportPageState
    extends ModularState<ListReportPage, ListReportStore> {
  final homeStore = Modular.get<HomeStore>();
  bool get _isTokenExpired => homeStore.isTokenExpired;

  @override
  void initState() {
    super.initState();
    store.loadReportsByFinished(widget.finished);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF3a4750),
        title: Text(
          widget.finished ? 'Tarefas Finalizadas' : 'Tarefas Abertas',
          style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
        ),
      ),
      body: Container(
        color: const Color(0XFF3a4750),
        child: ValueListenableBuilder(
            valueListenable: store,
            builder: (context, state, child) {
              if (state is LoadingList) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }

              if (state is ErrorList) {
                return Text(state.message);
              }

              if (state is LoadedList) {
                return ListView.builder(
                    itemCount: state.report.length,
                    itemBuilder: (context, index) {
                      String status = state.report[index].finished.toString();
                      String? formattedEndTime;
                      String? taskDurationTime;

                      final dateFormat = DateFormat('dd-MM-yyyy HH:mm');

                      if (status == "true") {
                        DateTime? taskStart =
                            DateTime.parse(state.report[index].startedAt);
                        DateTime? taskEnd =
                            DateTime.parse(state.report[index].stopedAt);
                        taskDurationTime = timeAgo(taskEnd, taskStart);

                        DateTime? end =
                            DateTime.parse(state.report[index].stopedAt);
                        formattedEndTime =
                            dateFormat.format(DateTime.parse(end.toString()));
                      } else {
                        taskDurationTime = "Em execução...";
                        formattedEndTime = '';
                      }

                      DateTime? start =
                          DateTime.parse(state.report[index].startedAt);
                      String? formattedStartTime =
                          dateFormat.format(DateTime.parse(start.toString()));

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: GestureDetector(
                          onTap: () async {
                            await homeStore.validToken();
                            if (_isTokenExpired) {
                              alertFactory(
                                  titleText: 'Oops!!',
                                  contentText:
                                      'Algo deu errado...\nFaça o login novamente',
                                  cancelButtonText: 'Fechar',
                                  cancelFunction: () => {
                                        homeStore.logout(),
                                        Modular.to.navigate('/auth/login'),
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop()
                                      });
                            } else {
                              String id = state.report[index].id;
                              !(state.report[index].finished)
                                  ? Modular.to.pushNamed('/report/stop')
                                  : Modular.to.pushNamed('/report/detail',
                                      arguments: id);
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: SizedBox(
                              height: 100.0,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      state.report[index].initialImage,
                                      fit: BoxFit.cover,
                                      height: 80.0,
                                      width: 80.0,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 15.0,
                                                right: 20.0),
                                            child: Text(
                                              'Início:',
                                              style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w700,
                                              )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: Text(
                                              formattedStartTime,
                                              style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                fontSize: 11.0,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w700,
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 8.0,
                                                right: 24.0),
                                            child: status == 'true'
                                                ? Text(
                                                    'Final:',
                                                    style: GoogleFonts.roboto(
                                                        textStyle:
                                                            const TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black45,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                                  )
                                                : const Text(''),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              formattedEndTime,
                                              style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                fontSize: 11.0,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w700,
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 8.0,
                                                right: 5.0),
                                            child: Text(
                                              'Duração:',
                                              style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w700,
                                              )),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              taskDurationTime ?? '',
                                              style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w700,
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }

              return Container();
            }),
      ),
    );
  }
}
