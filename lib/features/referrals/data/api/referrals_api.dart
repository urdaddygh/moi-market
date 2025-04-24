import 'package:moi_market/core/api/base_api_service.dart';

class ReferralsApi extends BaseApiService {
  ReferralsApi(super.client);

  Future<String?> getReferrals() async {
      return 'OK';
  }
}