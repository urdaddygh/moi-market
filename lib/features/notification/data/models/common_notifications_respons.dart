import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moi_market/features/notification/data/models/app_notification.dart';

part 'common_notifications_respons.g.dart';

List<CommonNotificationsRespons> listCommonNotificationsResponsFromJson(dynamic data) =>
    List<CommonNotificationsRespons>.from(data.map((x) => CommonNotificationsRespons.fromJson(x)));

String listCommonNotificationsResponsToJson(List<CommonNotificationsRespons> data) =>
    jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class CommonNotificationsRespons {
  CommonNotificationsRespons(this.count, this.next, this.previous, this.totalPages, this.currentPage, this.results);
  final int? count;
  final String? next;
  final String? previous;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  final List<AppNotification>? results;

  factory CommonNotificationsRespons.fromJson(Map<String, dynamic> json) => _$CommonNotificationsResponsFromJson(json);

  Map<String, dynamic> toJson() => _$CommonNotificationsResponsToJson(this);
}