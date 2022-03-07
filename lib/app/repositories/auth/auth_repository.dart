import 'package:work_report/app/models/user.dart';

abstract class AuthRepository {
  Future<User> addUser(String name, String email, String cpf, String password);
  Future<User> login(String cpf, String password);
  Future<User> loadUserById();
  Future<String> logout();
}
