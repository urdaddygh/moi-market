import 'package:moi_market/features/personal_account/data/api/personal_account_api.dart';
import 'package:moi_market/features/personal_account/data/models/client.dart';
import 'package:moi_market/features/personal_account/domain/repositories/personal_account_repository.dart';

class PersonalAccountRepositoryImpl implements PersonalAccountRepository {
  final PersonalAccountApi api;

  PersonalAccountRepositoryImpl({required this.api});

  @override
  Future<Client> getUserInfo() {
    return api.getUserInfo();
  }
}