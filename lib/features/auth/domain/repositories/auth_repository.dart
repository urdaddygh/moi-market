abstract class AuthRepository {
  Future<String?> login(String phone, String password);
}