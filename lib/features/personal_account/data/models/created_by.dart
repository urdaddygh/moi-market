import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moi_market/features/personal_account/data/models/user.dart';

part 'created_by.g.dart';

List<CreatedBy> listCreatedByFromJson(dynamic data) =>
    List<CreatedBy>.from(data.map((x) => CreatedBy.fromJson(x)));

String listCreatedByToJson(List<CreatedBy> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class CreatedBy {
  CreatedBy(this.id, this.user);
  final int? id;
  final User user;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);
}