import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'default_notification.g.dart';

List<DefaultNotification> listDefaultNotificationFromJson(dynamic data) =>
    List<DefaultNotification>.from(data.map((x) => DefaultNotification.fromJson(x)));

String listDefaultNotificationToJson(List<DefaultNotification> data) =>
    jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class DefaultNotification extends Equatable {
  const DefaultNotification({required this.title, required this.body, required this.data});

  final String title;

  final String body;

  final Map<String, dynamic>? data;
  @override
  List<Object> get props => [title, body];

  factory DefaultNotification.fromJson(Map<String, dynamic> json) => _$DefaultNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultNotificationToJson(this);
}