import 'package:work_report/app/models/user.dart';

abstract class UserRepository {
  Future<User> loadUserById();
}
