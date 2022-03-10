import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_report/app/core/alerts/alert_factory.dart';
import 'package:work_report/app/models/report.dart';
import 'package:intl/intl.dart';
import 'package:work_report/app/modules/home/home_store.dart';
import 'package:work_report/app/modules/home/widgets/all_reports/all_reports_store.dart';

class AllReportsWidget extends StatefulWidget {
  final List<Report> _reports;

  const AllReportsWidget({Key? key, required List<Report> reports})
      : _reports = reports,
        super(key: key);

  @override
  State<AllReportsWidget> createState() => _AllReportsWidgetState();
}

class _AllReportsWidgetState
    extends ModularState<AllReportsWidget, AllReportsStore> {
  final homeStore = Modular.get<HomeStore>();

  bool get _isTokenExpired => homeStore.isTokenExpired;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget._reports.length,
          itemBuilder: (context, index) {
            DateTime start = DateTime.parse(widget._reports[index].startedAt);
            final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
            String formatedTime =
                dateFormat.format(DateTime.parse(start.toString()));

            return GestureDetector(
              onTap: () async {
                await homeStore.validToken();
                if (_isTokenExpired) {
                  alertFactory(
                      titleText: 'Oops!!',
                      contentText: 'Algo deu errado...\nFaça o login novamente',
                      cancelButtonText: 'Fechar',
                      cancelFunction: () => {
                            homeStore.logout(),
                            Modular.to.navigate('/auth/login'),
                            Navigator.of(context, rootNavigator: true).pop()
                          });
                } else {
                  String id = widget._reports[index].id;
                  Modular.to.pushNamed('/report/detail', arguments: id);
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        widget._reports[index].initialImage,
                        alignment: Alignment.topLeft,
                        fit: BoxFit.cover,
                        height: 80.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          formatedTime,
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                      ),
                      Text(
                        widget._reports[index].finished ? 'Finalizado' : '',
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black45,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
