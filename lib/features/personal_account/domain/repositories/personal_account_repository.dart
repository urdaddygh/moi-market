import 'package:moi_market/features/personal_account/data/models/client.dart';

abstract class PersonalAccountRepository {
  Future<Client?> getUserInfo();
}