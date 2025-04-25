import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moi_market/features/home/data/models/client.dart';
import 'package:moi_market/features/home/data/models/payment.dart';

part 'ticket.g.dart';

List<Ticket> listTicketFromJson(dynamic data) =>
    List<Ticket>.from(data.map((x) => Ticket.fromJson(x)));

String listTicketToJson(List<Ticket> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Ticket {
  Ticket(this.id, this.client, this.createdAt, this.position, this.received, this.receiveDate, this.payments);
  final int? id;
  final Client? client;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final int? position;
  final bool? received;
  @JsonKey(name: 'receive_date')
  final String? receiveDate;
  final List<Payment>? payments;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}