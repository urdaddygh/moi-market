import 'package:moi_market/core/api/base_api_service.dart';

class PersonalAccountApi extends BaseApiService {
  PersonalAccountApi(super.client);

  Future<String?> getUserInfo() async {
      return 'OK';
  }
}