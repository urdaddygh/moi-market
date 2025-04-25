import 'package:moi_market/features/home/data/models/groups_common_response.dart';

abstract class HomeRepository {
  Future<GroupsCommonResponse> getGroups({required int limit, required int page});
}