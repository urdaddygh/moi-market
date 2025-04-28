import 'package:moi_market/core/api/base_api_service.dart';
import 'package:moi_market/core/constants/request_type.dart';
import 'package:moi_market/core/exceptions/response_is_null_exception.dart';
import 'package:moi_market/features/referrals/data/models/referral.dart';
import 'package:moi_market/features/referrals/data/models/referrals_common_response.dart';

class ReferralsApi extends BaseApiService {
  ReferralsApi(super.client);

  Future<ReferralsCommonResponse?> getReferrals() async {
    var res = await baseRequest(endpoint: 'referrals/', type: RequestType.get);

    if (res == null) throw ResponseIsNullException('Response is null');

    return ReferralsCommonResponse.fromJson(res);
  }

  Future<Referral?> createReferral({required String name, required String phone}) async {
    var res = await baseRequest(data: {"full_name": name, "phone_number": phone}, endpoint: 'referrals/', type: RequestType.post);

    if (res == null) throw ResponseIsNullException('Response is null');

    return Referral.fromJson(res);
  }
}
