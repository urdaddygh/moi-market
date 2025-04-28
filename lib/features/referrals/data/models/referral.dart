import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moi_market/features/home/data/models/client.dart';

part 'referral.g.dart';

List<Referral> listReferralFromJson(dynamic data) => List<Referral>.from(data.map((x) => Referral.fromJson(x)));

String listReferralToJson(List<Referral> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Referral {
  Referral(this.id, this.createdAt, this.fullName, this.phoneNumber, this.approved, this.rewardAmount, this.client);
  final int? id;
  final Client? client;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final bool? approved;
  @JsonKey(name: 'reward_amount')
  final int? rewardAmount;

  factory Referral.fromJson(Map<String, dynamic> json) => _$ReferralFromJson(json);

  Map<String, dynamic> toJson() => _$ReferralToJson(this);
}