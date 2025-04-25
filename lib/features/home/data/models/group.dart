import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

List<Group> listGroupFromJson(dynamic data) =>
    List<Group>.from(data.map((x) => Group.fromJson(x)));

String listGroupToJson(List<Group> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Group {
  Group(this.id, this.ticketLimit, this.entryFee, this.createdAt, this.status, this.paymentDetails, this.comment, this.shuffledAt,);
  final int id;
  @JsonKey(name: 'ticket_limit')
  final int ticketLimit;
  @JsonKey(name: 'entry_fee')
  final int entryFee;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String status;
  @JsonKey(name: 'payment_details')
  final String paymentDetails;
  final String comment;
  @JsonKey(name: 'shuffled_at')
  final String shuffledAt;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}