

import 'package:moi_market/core/api/base_api_service.dart';
import 'package:moi_market/core/exceptions/failure_exception.dart';
import 'package:moi_market/core/exceptions/response_is_null_exception.dart';

class AuthApi extends BaseApiService {
  AuthApi(super.client);

  Future<String?> fetchToken({required String login, required String password}) async {
    var response = await baseRequest(
      endpoint: '/login',
      queryParameters: {
        'email': login,
        'password': password,
      },
    );

    if (response == null) throw ResponseIsNullException('response is null');

    if (response.success) {
      return response.result;
    } else {
      throw FailureException(response.message);
    }
  }
}