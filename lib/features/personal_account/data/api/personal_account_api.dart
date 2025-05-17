import 'package:moi_market/core/api/base_api_service.dart';
import 'package:moi_market/core/constants/request_type.dart';
import 'package:moi_market/core/exceptions/response_is_null_exception.dart';
import 'package:moi_market/features/personal_account/data/models/client.dart';

class PersonalAccountApi extends BaseApiService {
  PersonalAccountApi();

  Future<Client> getUserInfo() async {
    var res = await baseRequest(endpoint: 'me/', type: RequestType.get);

    if (res == null) throw ResponseIsNullException('Response is null');

    return Client.fromJson(res);
  }
}