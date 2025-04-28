import 'package:moi_market/features/notification/data/models/common_notifications_respons.dart';

abstract class NotificationRepository {
  Future<CommonNotificationsRespons> getNotifications({required int limit, required int page});
}