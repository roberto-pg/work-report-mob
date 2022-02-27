import 'package:work_report/app/models/user.dart';

abstract class AuthService {
  Future<User> login(String cpf, String password);
  Future<String> logout();
}
