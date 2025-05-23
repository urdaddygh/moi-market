import 'package:moi_market/core/api/base_api_service.dart';
import 'package:moi_market/core/constants/request_type.dart';
import 'package:moi_market/core/exceptions/response_is_null_exception.dart';
import 'package:moi_market/features/notification/data/models/app_notification.dart';
import 'package:moi_market/features/notification/data/models/common_notifications_respons.dart';

class NotificationApi extends BaseApiService {
  NotificationApi();

  Future<CommonNotificationsRespons> getNotifications({required int limit, required int page}) async {
    var res = await baseRequest(
        endpoint: 'notifications/',
        queryParameters: {
          "limit": limit,
          "page": page,
        },
        type: RequestType.get
    );

    if(res == null) throw ResponseIsNullException('Response is null');
    
    return CommonNotificationsRespons.fromJson(res);
  }

  Future<AppNotification> getNotificationById({required int id}) async {
    var res = await baseRequest(
        endpoint: 'notifications/$id/',
        type: RequestType.get
    );

    if(res == null) throw ResponseIsNullException('Response is null');

    return AppNotification.fromJson(res);
  }
}