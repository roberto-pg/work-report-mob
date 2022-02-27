import 'package:work_report/app/models/user.dart';
import 'package:work_report/app/repositories/user/user_repository.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _repository;

  UserServiceImpl({required UserRepository repository})
      : _repository = repository;

  @override
  Future<User> loadUserById() => _repository.loadUserById();
}
