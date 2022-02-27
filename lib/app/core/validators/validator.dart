abstract class IValidator {
  Future<bool> expiredToken();
  Future<void> logoutUser();
}
