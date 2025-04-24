import 'package:moi_market/core/api/base_api_service.dart';

class NotificationApi extends BaseApiService {
  NotificationApi(super.client);

  Future<String?> getNotification() async {
      return 'OK';
  }
}