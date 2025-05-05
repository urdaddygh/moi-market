import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moi_market/features/personal_account/data/models/created_by.dart';
import 'package:moi_market/features/personal_account/data/models/user.dart';

part 'client.g.dart';

List<Client> listClientFromJson(dynamic data) =>
    List<Client>.from(data.map((x) => Client.fromJson(x)));

String listClientToJson(List<Client> data) =>
    jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Client {
  Client(
      this.id,
      this.user,
      this.additionalPhone,
      this.status,
      this.passportFront,
      this.passportBack,
      this.level,
      this.address,
      this.comment,
      this.createdBy,
      this.bonus,
      this.activeNotifications);
  final int? id;
  final User? user;
  @JsonKey(name: 'additional_phone')
  final String? additionalPhone;
  final String? status;
  @JsonKey(name: 'passport_front')
  final String? passportFront;
  @JsonKey(name: 'passport_back')
  final String? passportBack;
  final int? level;
  final String? address;
  final String? comment;
  @JsonKey(name: 'created_by')
  final CreatedBy? createdBy;
  final int? bonus;
  @JsonKey(name: 'active_notifications')
  final int? activeNotifications;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
