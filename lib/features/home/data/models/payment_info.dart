import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'payment_info.g.dart';

List<PaymentInfo> listPaymentInfoFromJson(dynamic data) => List<PaymentInfo>.from(data.map((x) => PaymentInfo.fromJson(x)));

String listPaymentInfoToJson(List<PaymentInfo> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class PaymentInfo {
  PaymentInfo(this.paidAt, this.amount, this.isApproved, this.approvedAt, this.cheque);
  @JsonKey(name: 'paid_at')
  final DateTime? paidAt;
  final int? amount;
  @JsonKey(name: 'is_approved')
  final bool? isApproved;
  @JsonKey(name: 'approved_at')
  final DateTime? approvedAt;
  final String? cheque;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => _$PaymentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInfoToJson(this);
}