import 'dart:io';

import 'package:moi_market/features/home/data/models/groups_common_response.dart';

abstract class HomeRepository {
  Future<GroupsCommonResponse> getGroups({required int limit, required int page, String? status});

  Future<dynamic> addReceipt({required File cheque, required int schedule, required int ticket});

  Future<dynamic> sendFirebaseToken({required String token});
}