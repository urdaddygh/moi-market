import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

List<CommonResponse> listCommonResponseFromJson(dynamic data) =>
    List<CommonResponse>.from(data.map((x) => CommonResponse.fromJson(x)));

String listCommonResponseToJson(List<CommonResponse> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class CommonResponse {
  CommonResponse(this.success, this.result, this.message);
  final bool success;
  final dynamic result;
  final String message;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => _$CommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);
}