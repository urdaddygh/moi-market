import 'package:moi_market/core/api/base_api_service.dart';
import 'package:moi_market/core/constants/request_type.dart';
import 'package:moi_market/core/exceptions/response_is_null_exception.dart';
import 'package:moi_market/features/notification/data/models/common_notifications_respons.dart';

class NotificationApi extends BaseApiService {
  NotificationApi(super.client);

  Future<CommonNotificationsRespons> getNotifications({required int limit, required int page}) async {
    var res = await baseRequest(
        endpoint: 'groups/',
        queryParameters: {
          "limit": limit,
          "page": page,
        },
        type: RequestType.get
    );

    if(res == null) throw ResponseIsNullException('Response is null');
    // print('RESPONSE BODY: ${res.toString()}');
    return CommonNotificationsRespons.fromJson(res);
  }
}