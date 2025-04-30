import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moi_market/features/notification/data/models/app_notification.dart';
import 'package:moi_market/features/notification/data/models/common_notifications_respons.dart';

part 'notification_state.freezed.dart';

enum NotificationEventState {
  initial,
  loading,
  error,
}

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(NotificationEventState.initial) NotificationEventState eventState,
    @Default(null) List<AppNotification>? notifications,
    @Default(null) List<AppNotification>? readNotifications,
    @Default(null) List<AppNotification>? unreadNotifications,
    @Default(null) AppNotification? notification,
    @Default(null) CommonNotificationsRespons? commonResponse,
    @Default(false) bool isLoadingMore,
    String? message,
  }) = _Initial;
}