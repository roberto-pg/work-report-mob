import 'package:dio/dio.dart';
import 'package:work_report/app/core/dio/custom_dio_auth.dart';
import 'package:work_report/app/core/errors/exceptions.dart';
import 'package:work_report/app/models/report.dart';

import './report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  final CustomDioAuth _customDioAuth;

  ReportRepositoryImpl({required CustomDioAuth customDioAuth})
      : _customDioAuth = customDioAuth;

  @override
  Future<List<Report>> loadReports() async {
    try {
      var response = await _customDioAuth.get<List>('/api/all-reports-by-user');
      List<Report>? reports =
          response.data?.map((report) => Report.fromMap(report)).toList();

      return reports ?? [];
    } on DioError catch (error) {
      if (error.type.toString() == 'DioErrorType.other') {
        throw const CustomException('Problema inesperado no servidor');
      } else {
        throw CustomException(error.response?.data);
      }
    }
  }

  @override
  Future<List<Report>> loadReportsByFinishedAttribute(bool finished) async {
    try {
      var response =
          await _customDioAuth.get<List>('/api/reports-by-finished/$finished');
      List<Report>? reports =
          response.data?.map((report) => Report.fromMap(report)).toList();

      return reports ?? [];
    } on DioError catch (error) {
      if (error.type.toString() == 'DioErrorType.other') {
        throw const CustomException('Problema inesperado no servidor');
      } else {
        throw CustomException(error.response?.data);
      }
    }
  }

  @override
  Future<Report> loadReportById(String id) async {
    try {
      var response = await _customDioAuth.get('/api/report-by-id/$id');
      Report report = Report.fromMap(response.data);
      return report;
    } on DioError catch (error) {
      if (error.type.toString() == 'DioErrorType.other') {
        throw const CustomException('Problema inesperado no servidor');
      } else {
        throw CustomException(error.response?.data);
      }
    }
  }

  @override
  Future<Report> startReport(FormData formData) async {
    try {
      var response =
          await _customDioAuth.post('/api/start-report', data: formData);
      Report report = Report.fromMap(response.data);
      return report;
    } on DioError catch (error) {
      if (error.type.toString() == 'DioErrorType.other') {
        throw const CustomException('Problema inesperado no servidor');
      } else {
        throw CustomException(error.response?.data);
      }
    }
  }

  @override
  Future<Report> stopReport(FormData formData, String id) async {
    try {
      var response =
          await _customDioAuth.patch('/api/close-report/$id', data: formData);
      Report report = Report.fromMap(response.data);
      return report;
    } on DioError catch (error) {
      if (error.type.toString() == 'DioErrorType.other') {
        throw const CustomException('Problema inesperado no servidor');
      } else {
        throw CustomException(error.response?.data);
      }
    }
  }

  @override
  Future<String> deleteReport(String id, String initialImage) async {
    try {
      var response = await _customDioAuth.delete('/api/delete-report',
          data: {'id': id, 'initialImage': initialImage});
      return response.data;
    } on DioError catch (error) {
      if (error.type.toString() == 'DioErrorType.other') {
        throw const CustomException('Problema inesperado no servidor');
      } else {
        throw CustomException(error.response?.data);
      }
    }
  }
}
