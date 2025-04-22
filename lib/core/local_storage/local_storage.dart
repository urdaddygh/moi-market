
abstract class LocalStorage {
  Future<bool> readIsTestAccount();
  Future<void> writeIsTestAccount(String value);
  Future<void> flushIsTestAccount();

  Future<String?> fetchToken();
  Future<void> flushToken();
  Future<void> writeToken(String value);

  Future<String?> fetchLogin();
  Future<void> flushLogin();
  Future<void> writeLogin(String value);

  Future<String?> fetchPassword();
  Future<void> flushPassword();
  Future<void> writePassword(String value);
}