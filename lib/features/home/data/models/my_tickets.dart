import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moi_market/features/home/data/models/schedule.dart';
import 'package:moi_market/features/personal_account/data/models/client.dart';
import 'package:moi_market/features/home/data/models/payment.dart';

part 'my_tickets.g.dart';

List<MyTickets> listMyTicketsFromJson(dynamic data) =>
    List<MyTickets>.from(data.map((x) => MyTickets.fromJson(x)));

String listMyTicketsToJson(List<MyTickets> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class MyTickets {
  MyTickets(this.id, this.position, this.receiveDate, this.paymentSchedule);
  final int? id;
  final int? position;
  @JsonKey(name: 'receive_date')
  final String? receiveDate;
  @JsonKey(name: 'payment_schedule')
  final List<Schedule>? paymentSchedule;

  factory MyTickets.fromJson(Map<String, dynamic> json) => _$MyTicketsFromJson(json);

  Map<String, dynamic> toJson() => _$MyTicketsToJson(this);
}