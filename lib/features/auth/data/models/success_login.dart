import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'success_login.g.dart';

List<SuccessLogin> listSuccessLoginFromJson(dynamic data) =>
    List<SuccessLogin>.from(data.map((x) => SuccessLogin.fromJson(x)));

String listSuccessLoginToJson(List<SuccessLogin> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class SuccessLogin {
  SuccessLogin(this.refresh, this.access, this.userType, this.fullName);
  final String? refresh;
  final String? access;
  @JsonKey(name: 'user_type')
  final String? userType;
  @JsonKey(name: 'full_name')
  final String? fullName;

  factory SuccessLogin.fromJson(Map<String, dynamic> json) => _$SuccessLoginFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessLoginToJson(this);
}