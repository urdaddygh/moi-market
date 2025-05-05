import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moi_market/features/home/data/models/payment_info.dart';

part 'schedule.g.dart';

List<Schedule> listScheduleFromJson(dynamic data) =>
    List<Schedule>.from(data.map((x) => Schedule.fromJson(x)));

String listScheduleToJson(List<Schedule> data) => jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Schedule {
  Schedule(this.id, this.group, this.step, this.dueDate, this.payment);
  final int? id;
  final int? group;
  final int? step;
  @JsonKey(name: 'due_date')
  final DateTime? dueDate;
  @JsonKey(name: 'payment')
  final PaymentInfo? payment;

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}