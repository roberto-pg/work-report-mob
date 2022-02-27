import 'package:work_report/app/models/user.dart';

abstract class UserService {
  Future<User> loadUserById();
}
