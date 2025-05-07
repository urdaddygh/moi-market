import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moi_market/features/referrals/data/models/referral.dart';

part 'referrals_common_response.g.dart';

List<ReferralsCommonResponse> listReferralsCommonResponseFromJson(dynamic data) =>
    List<ReferralsCommonResponse>.from(data.map((x) => ReferralsCommonResponse.fromJson(x)));

String listReferralsCommonResponseToJson(List<ReferralsCommonResponse> data) =>
    jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class ReferralsCommonResponse {
  ReferralsCommonResponse(this.count, this.next, this.previous, this.totalPages, this.currentPage, this.results);
  final int? count;
  final String? next;
  final String? previous;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  final List<Referral>? results;

  factory ReferralsCommonResponse.fromJson(Map<String, dynamic> json) => _$ReferralsCommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReferralsCommonResponseToJson(this);
}