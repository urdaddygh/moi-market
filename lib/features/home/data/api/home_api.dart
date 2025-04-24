import 'package:moi_market/core/api/base_api_service.dart';

class HomeApi extends BaseApiService {
  HomeApi(super.client);

  Future<String?> getInfo() async {
      return 'OK';
  }
}