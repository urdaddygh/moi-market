import 'package:moi_market/core/api/base_api_service.dart';
import 'package:moi_market/core/constants/request_type.dart';
import 'package:moi_market/core/exceptions/response_is_null_exception.dart';
import 'package:moi_market/features/home/data/models/groups_common_response.dart';

class HomeApi extends BaseApiService {
  HomeApi(super.client);

  Future<GroupsCommonResponse> getGroups({required int limit, required int page}) async {
    var res = await baseRequest(
        endpoint: 'groups/',
        queryParameters: {
          "limit": limit,
          "page": page,
        },
        type: RequestType.get
    );

    if(res == null) throw ResponseIsNullException('Response is null');

    return GroupsCommonResponse.fromJson(res);
  }
}