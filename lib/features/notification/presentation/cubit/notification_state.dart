import 'package:freezed_annotation/freezed_annotation.dart';

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
    String? message,
  }) = _Initial;
}