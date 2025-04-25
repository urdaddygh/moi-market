import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moi_market/features/home/data/models/group.dart';

part 'groups_common_response.g.dart';

List<GroupsCommonResponse> listGroupsCommonResponseFromJson(dynamic data) =>
    List<GroupsCommonResponse>.from(data.map((x) => GroupsCommonResponse.fromJson(x)));

String listGroupsCommonResponseToJson(List<GroupsCommonResponse> data) =>
    jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class GroupsCommonResponse {
  GroupsCommonResponse(this.count, this.next, this.previous, this.results, this.totalPages, this.currentPage);
  final int? count;
  final String? next;
  final String? previous;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  final List<Group>? results;

  factory GroupsCommonResponse.fromJson(Map<String, dynamic> json) => _$GroupsCommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsCommonResponseToJson(this);
}