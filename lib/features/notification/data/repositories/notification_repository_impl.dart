import 'package:moi_market/features/notification/data/api/notification_api.dart';
import 'package:moi_market/features/notification/data/models/app_notification.dart';
import 'package:moi_market/features/notification/data/models/common_notifications_respons.dart';
import 'package:moi_market/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApi api;

  NotificationRepositoryImpl({required this.api});

  @override
  Future<CommonNotificationsRespons> getNotifications({required int limit, required int page}) {
    return api.getNotifications(limit: limit, page: page);
  }

  @override
  Future<AppNotification> getNotificationById({required int id}) {
    return api.getNotificationById(id: id);
  }
}