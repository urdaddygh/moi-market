import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

List<User> listUserFromJson(dynamic data) =>
    List<User>.from(data.map((x) => User.fromJson(x)));

String listUserToJson(List<User> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class User {
  User(this.id, this.phone, this.fullName, this.userType);
  final int id;
  final String phone;
  @JsonKey(name: 'full_name')
  final String fullName;
  @JsonKey(name: 'user_type')
  final String userType;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}