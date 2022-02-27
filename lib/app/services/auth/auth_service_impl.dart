import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:work_report/app/models/user.dart';
import 'package:work_report/app/repositories/auth/auth_repository.dart';
import 'package:work_report/app/services/auth/auth_service.dart';

class AuthServiceImpl implements AuthService {
  final AuthRepository _repository;
  final FlutterSecureStorage _storage;

  AuthServiceImpl(
      {required AuthRepository repository,
      required FlutterSecureStorage storage})
      : _repository = repository,
        _storage = storage;

  @override
  Future<User> login(String cpf, String password) async {
    var response = await _repository.login(cpf, password);
    await _storage.write(key: 'jwt', value: response.token);
    await _storage.write(key: 'userId', value: response.id);
    await _storage.write(key: 'isLogged', value: 'true');

    return response;
  }

  @override
  Future<String> logout() {
    throw UnimplementedError();
  }
}
