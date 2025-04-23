import 'package:moi_market/core/api/base_api_service.dart';
import 'package:moi_market/core/exceptions/failure_exception.dart';
import 'package:moi_market/core/exceptions/response_is_null_exception.dart';

class AuthApi extends BaseApiService {
  AuthApi(super.client);

  Future<String?> login({required String phone, required String password}) async {
    if (phone == '0333112233' && password == '1234') {
      return 'OK';
    } else {
      return 'error';
    }
  }
}
