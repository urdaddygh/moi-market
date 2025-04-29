import 'dart:io';

import 'package:dio/dio.dart';
import 'package:moi_market/core/constants/request_type.dart';
import 'package:moi_market/core/exceptions/data_is_empty_exception.dart';
import 'package:moi_market/core/exceptions/status_code_exception.dart';
import 'package:moi_market/core/exceptions/unexpected_error_exception.dart';
import 'package:moi_market/main.dart';

abstract class BaseApiService {
  final Dio client;

  BaseApiService(this.client);

  Future<dynamic> baseRequest({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? data,
    RequestType type = RequestType.post,
  }) async {
    final strQueryParams =
        queryParameters == null ? '' : queryParameters.entries.fold<String>('?', (prev, e) => '$prev&${e.key}=${e.value}');

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

      return response.data;
    } on DioException catch (e) {
      logger.e('[BaseApiService] DioException: ${e.response?.statusCode} - ${e.type}');
      if (e.response?.statusCode == 401) {
        throw StatusCodeException('${e.response?.data['detail']}');
      }
      throw UnexpectedErrorException('Status - ${e.response?.statusCode}, error - ${e.error}, type - ${e.type}');
    } catch (e) {
      logger.e('[BaseApiService] Exception: $e');
      throw UnexpectedErrorException('Произошла непредвиденная ошибка, попробуйте позже');
    }
  }

  Future<dynamic> uploadMediaResponse({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    required File photo,
    Map<String, dynamic>? extraFields,
  }) async {
    logger.d('[ApiService] sending request to ${client.options.baseUrl}$endpoint');

    FormData formData = FormData();

    if (extraFields != null) {
      extraFields.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
    }

    String fileName = photo.path.split('/').last;
    formData.files.add(MapEntry(
      "photo",
      await MultipartFile.fromFile(photo.path, filename: fileName),
    ));

    try {
      var response = await client.post(endpoint, queryParameters: queryParameters, data: formData);
      if (response.statusCode != 200) {
        throw StatusCodeException('${response.statusCode} - ${response.statusMessage}');
      }

      if (response.data == null) {
        throw DataIsEmptyException('Запрос пришел без данных');
      }

      return response.data;
    } on DioException catch (e) {
      logger.e('[BaseApiService] DioException: ${e.response?.statusCode} - ${e.type}');
      if (e.response?.statusCode == 401) {
        throw StatusCodeException('${e.response?.data['detail']}');
      }
      throw UnexpectedErrorException('Status - ${e.response?.statusCode}, error - ${e.error}, type - ${e.type}');
    } catch (e) {
      logger.e('[ApiService] Upload failed: $e');
      throw UnexpectedErrorException("Ошибка загрузки медиа: $e");
    }
  }

}
