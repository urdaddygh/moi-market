import 'dart:io';

import 'package:moi_market/features/home/data/api/home_api.dart';
import 'package:moi_market/features/home/data/models/groups_common_response.dart';
import 'package:moi_market/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApi api;

  HomeRepositoryImpl({required this.api});

  @override
  Future<GroupsCommonResponse> getGroups({required int limit, required int page, String? status}) {
    return api.getGroups(limit:limit, page:page, status: status);
  }

  @override
  Future<String?> addReceipt({required File cheque, required int schedule, required int ticket}) {
    return api.addReceipt(cheque: cheque, schedule: schedule, ticket: ticket);
  }
}