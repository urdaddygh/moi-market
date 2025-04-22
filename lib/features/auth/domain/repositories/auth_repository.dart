abstract class AuthRepository {
  Future<String?> fetchToken(String login, String password);
}