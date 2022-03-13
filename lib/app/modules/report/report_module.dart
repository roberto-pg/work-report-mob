import 'package:flutter_modular/flutter_modular.dart';
import 'package:work_report/app/modules/report/detail/detail_report_store.dart';
import 'package:work_report/app/modules/report/list/list_report_store.dart';
import 'package:work_report/app/modules/report/report_store.dart';
import 'package:work_report/app/modules/report/start/start_report_page.dart';
import 'package:work_report/app/modules/report/start/start_report_store.dart';
import 'package:work_report/app/modules/report/stop/stop_report_page.dart';
import 'package:work_report/app/modules/report/stop/stop_report_store.dart';
import 'detail/detail_report_page.dart';
import 'list/list_report_page.dart';

class ReportModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ReportStore(validate: i())),
    Bind.lazySingleton((i) => StartReportStore(reportService: i())),
    Bind.lazySingleton((i) => StopReportStore(reportService: i())),
    Bind.lazySingleton((i) => ListReportStore(reportService: i())),
    Bind.lazySingleton(
        (i) => DetailReportStore(reportService: i(), authService: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ListReportPage(finished: args.data)),
    ChildRoute('/start', child: (_, args) => const StartReportPage()),
    ChildRoute('/stop', child: (_, args) => StopReportPage(id: args.data)),
    ChildRoute('/detail', child: (_, args) => DetailReportPage(id: args.data)),
  ];
}
