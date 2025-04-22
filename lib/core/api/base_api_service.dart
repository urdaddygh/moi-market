
import 'package:dio/dio.dart';
import 'package:moi_market/core/constants/request_type.dart';
import 'package:moi_market/core/exceptions/data_is_empty_exception.dart';
import 'package:moi_market/core/exceptions/status_code_exception.dart';
import 'package:moi_market/core/exceptions/unexpected_error_exception.dart';
import 'package:moi_market/main.dart';
import 'package:moi_market/models/common_response.dart';

abstract class BaseApiService {
  final Dio client;

  BaseApiService(this.client);

  Future<CommonResponse?> baseRequest({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    RequestType type = RequestType.post,
  }) async {
    final strQueryParams = queryParameters == null
        ? ''
        : queryParameters.entries.fold<String>(
            '?', (prev, e) => '$prev&${e.key}=${e.value}');

    logger.d('[BaseApiService] sending request to ${client.options.baseUrl}$endpoint$strQueryParams');
    if (data != null) logger.d(data);

    try {
      late final Response response;

      switch (type) {
        case RequestType.post:
          response = await client.post(endpoint, queryParameters: queryParameters, data: data);
          break;
        case RequestType.get:
          response = await client.get(endpoint, queryParameters: queryParameters);
          break;
        case RequestType.put:
          response = await client.put(endpoint, queryParameters: queryParameters, data: data);
          break;
      }

      if (response.statusCode != 200) {
        throw StatusCodeException('${response.statusCode} - ${response.statusMessage}');
      }

      if (response.data == null) {
        throw DataIsEmptyException('Запрос пришел без данных');
      }

      return CommonResponse.fromJson(response.data);
    } on DioException catch (e) {
      logger.e('[BaseApiService] DioException: ${e.response?.statusCode} - ${e.type}');
      throw UnexpectedErrorException('Status - ${e.response?.statusCode}, error - ${e.error}, type - ${e.type}');
    } catch (e) {
      logger.e('[BaseApiService] Exception: $e');
      throw UnexpectedErrorException('Произошла непредвиденная ошибка, попробуйте позже');
    }
  }
}