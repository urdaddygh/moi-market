

import 'package:moi_market/features/auth/data/api/auth_api.dart';
import 'package:moi_market/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;

  AuthRepositoryImpl({required this.api});

  @override
  Future<String?> fetchToken(String login, String password) {
    return api.fetchToken(login: login, password: password);
  }
}