

import 'package:moi_market/features/auth/data/api/auth_api.dart';
import 'package:moi_market/features/auth/data/models/success_login.dart';
import 'package:moi_market/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;

  AuthRepositoryImpl({required this.api});

  @override
  Future<SuccessLogin?> login(String phone, String password) {
    return api.login(phone: phone, password: password);
  }
}