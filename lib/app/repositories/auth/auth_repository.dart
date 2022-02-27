import 'package:work_report/app/models/user.dart';

abstract class AuthRepository {
  Future<User> login(String cpf, String password);
  Future<String> logout();
}
