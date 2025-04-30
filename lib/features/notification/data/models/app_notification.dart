import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'app_notification.g.dart';

List<AppNotification> listAppNotificationFromJson(dynamic data) =>
    List<AppNotification>.from(data.map((x) => AppNotification.fromJson(x)));

String listAppNotificationToJson(List<AppNotification> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class AppNotification {
  AppNotification(this.id, this.title, this.message, this.createdAt, this.isRead, this.isSystem);
  final int? id;
  final String? title;
  final String? message;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'is_read')
  final bool? isRead;
  @JsonKey(name: 'is_system')
  final bool? isSystem;

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$AppNotificationToJson(this);

    AppNotification copyWith({
    int? id,
    String? title,
    String? message,
    DateTime? createdAt,
    bool? isRead,
    bool? isSystem,
  }) {
    return AppNotification(
      id ?? this.id,
      title ?? this.title,
      message ?? this.message,
      createdAt ?? this.createdAt,
      isRead ?? this.isRead,
      isSystem ?? this.isSystem,
    );
  }

}
