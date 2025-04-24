import 'package:moi_market/features/auth/data/models/success_login.dart';

abstract class AuthRepository {
  Future<SuccessLogin?> login(String phone, String password);
}