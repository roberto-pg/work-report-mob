import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_report/app/modules/home/widgets/all_reports/all_reports_store.dart';
import 'package:work_report/app/modules/home/home_state.dart';
import 'package:work_report/app/modules/home/home_store.dart';
import 'package:work_report/app/modules/home/widgets/bottom_navigation/bottom_navigation_widget.dart';
import 'widgets/all_reports/all_reports_state.dart';
import 'widgets/all_reports/all_reports_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  final storeReport = Modular.get<AllReportsStore>();

  @override
  void initState() {
    super.initState();
    store.loadUserById();
    storeReport.loadReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF3a4750),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: SizedBox(
                          child: Image.asset(
                            'assets/images/bar_transp.png',
                            height: MediaQuery.of(context).size.height * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ValueListenableBuilder(
                              valueListenable: store,
                              builder: (context, state, child) {
                                if (state is LoadedHome) {
                                  return Text('Olá ${state.user.name}',
                                      style: GoogleFonts.ubuntu(
                                        textStyle: const TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                        fontWeight: FontWeight.w500,
                                      ));
                                }
                                if (state is LoadingHome) {
                                  return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive());
                                }

                                if (state is ErrorHome) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                }
                                return Container();
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text('O que você quer fazer agora?',
                                style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Iniciar uma nova tarefa:',
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: IconButton(
                                iconSize: 44,
                                alignment: Alignment.center,
                                onPressed: () {
                                  Modular.to.pushNamed('/report/start');
                                },
                                icon: const Icon(
                                  Icons.playlist_add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Finalizar uma tarefa:',
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: IconButton(
                                iconSize: 35,
                                alignment: Alignment.center,
                                onPressed: () {
                                  Modular.to
                                      .pushNamed('/report/', arguments: false);
                                },
                                icon: const Icon(
                                  Icons.build,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ValueListenableBuilder(
                    valueListenable: storeReport,
                    builder: (context, state, child) {
                      if (state is LoadedReport) {
                        return AllReportsWidget(reports: state.report);
                      }
                      if (state is LoadingReport) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }

                      if (state is ErrorReport) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      return Container();
                    })
                // const AllReportsWidget(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
