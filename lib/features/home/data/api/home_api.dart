import 'dart:io';

import 'package:moi_market/core/api/base_api_service.dart';
import 'package:moi_market/core/constants/request_type.dart';
import 'package:moi_market/core/exceptions/response_is_null_exception.dart';
import 'package:moi_market/features/home/data/models/groups_common_response.dart';

class HomeApi extends BaseApiService {
  HomeApi();

  Future<GroupsCommonResponse> getGroups(
      {required int limit, required int page, String? status}) async {
    Map<String, dynamic> queryParameters;
    if (status != null) {
      queryParameters = {
        "limit": limit,
        "page": page,
        "status": status,
      };
    } else {
      queryParameters = {
        "limit": limit,
        "page": page,
      };
    }

    var res = await baseRequest(
      endpoint: 'groups/',
      queryParameters: queryParameters,
      type: RequestType.get,
    );

    if (res == null) throw ResponseIsNullException('Response is null');
    // print('RESPONSE BODY: ${res.toString()}');
    return GroupsCommonResponse.fromJson(res);
  }

  Future<dynamic> addReceipt(
      {required File cheque,
      required int schedule,
      required int ticket}) async {
    var res = await uploadMediaResponse(extraFields: {
      "schedule": schedule,
      "ticket": ticket,
    }, endpoint: 'groups/add-payment/', photo: cheque);

    if (res == null) throw ResponseIsNullException('Response is null');

    return res;
  }

  Future<dynamic> sendFirebaseToken({required String token}) async {
    Map<String, dynamic> body;
    body = {
      "token": token,
    };

    var res = await baseRequest(
      data: body,
      endpoint: 'store-device-token/',
      type: RequestType.post,
    );

    if (res == null) throw ResponseIsNullException('Response is null');

    return res;
  }
}
