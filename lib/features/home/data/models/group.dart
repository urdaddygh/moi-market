import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moi_market/features/home/data/models/my_tickets.dart';
import 'package:moi_market/features/home/data/models/schedule.dart';
import 'package:moi_market/features/home/data/models/ticket.dart';

part 'group.g.dart';

List<Group> listGroupFromJson(dynamic data) =>
    List<Group>.from(data.map((x) => Group.fromJson(x)));

String listGroupToJson(List<Group> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Group {
  Group(this.id, this.ticketLimit, this.entryFee, this.createdAt, this.status, this.paymentDetails, this.comment, this.shuffledAt, this.tickets, this.paymentSchedule, this.ticketCount, this.nextPaymentSchedule, this.myTickets,);
  final int? id;
  @JsonKey(name: 'ticket_limit')
  final int? ticketLimit;
  @JsonKey(name: 'entry_fee')
  final int? entryFee;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  final String? status;
  @JsonKey(name: 'payment_details')
  final String? paymentDetails;
  final String? comment;
  @JsonKey(name: 'shuffled_at')
  final String? shuffledAt;
  final List<Ticket>? tickets;
  @JsonKey(name: 'payment_schedule')
  final List<Schedule>? paymentSchedule;
  @JsonKey(name: 'ticket_count')
  final int? ticketCount;
  @JsonKey(name: 'next_payment_schedule')
  final DateTime? nextPaymentSchedule;
  @JsonKey(name: 'my_tickets')
  final List<MyTickets>? myTickets;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}