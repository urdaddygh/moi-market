import 'package:moi_market/features/notification/data/api/notification_api.dart';
import 'package:moi_market/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApi api;

  NotificationRepositoryImpl({required this.api});

  @override
  Future<String?> getNotification() {
    return api.getNotification();
  }
}