import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moi_market/features/home/data/models/schedule.dart';

part 'payment.g.dart';

List<Payment> listPaymentFromJson(dynamic data) =>
    List<Payment>.from(data.map((x) => Payment.fromJson(x)));

String listPaymentToJson(List<Payment> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Payment {
  Payment(this.id, this.schedule, this.paidAt, this.amount, this.isApproved, this.approvedAt, this.approvedBy);
  final int id;
  final Schedule schedule;
  @JsonKey(name: 'paid_at')
  final String paidAt;
  final String amount;
  @JsonKey(name: 'is_approved')
  final bool isApproved;
  @JsonKey(name: 'approved_at')
  final String approvedAt;
  @JsonKey(name: 'approved_by')
  final int approvedBy;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}