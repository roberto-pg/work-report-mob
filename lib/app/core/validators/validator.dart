abstract class Validator {
  Future<bool> expiredToken();
  Future<void> logoutUser();
}
