import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

void registerApiServiceDi({required String token}) {
  if (kDebugMode) print('Cookie = $token');

  if (GetIt.I.isRegistered<Dio>()) {
    GetIt.I.unregister<Dio>();
  }

  GetIt.I.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: 'https://example.com/api',
        headers: {
          'Authorization': token,
        },
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
      ),
    ),
  );

}
