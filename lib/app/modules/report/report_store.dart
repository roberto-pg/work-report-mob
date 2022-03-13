import 'package:work_report/app/core/validators/validator.dart';

class ReportStore {
  final Validator _validate;

  ReportStore({required Validator validate}) : _validate = validate;

  bool _isTokenExpired = false;

  bool get isTokenExpired => _isTokenExpired;

  Future<void> validToken() async {
    _isTokenExpired = await _validate.expiredToken();
  }

  logout() async {
    await _validate.logoutUser();
  }
}
