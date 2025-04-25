import 'package:moi_market/core/api/base_api_service.dart';
import 'package:moi_market/core/constants/request_type.dart';
import 'package:moi_market/core/exceptions/response_is_null_exception.dart';
import 'package:moi_market/features/auth/data/models/success_login.dart';

class AuthApi extends BaseApiService {
  AuthApi(super.client);

  Future<SuccessLogin> login({required String phone, required String password}) async {
    var res = await baseRequest(
      endpoint: 'auth/',
      data: {
        "phone": phone,
        "password": password,
      },
      type: RequestType.post
    );

    if(res == null) throw ResponseIsNullException('Response is null');
    
    return SuccessLogin.fromJson(res);
  }
}