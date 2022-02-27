import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get baseUrl => _get('baseUrl');

  static String _get(String name) => dotenv.env[name] ?? '';
}
