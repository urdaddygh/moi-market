import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

void registerApiServiceDi({String? token}) {
  if (kDebugMode) print('registerApiServiceDi JWT = $token');

  if (GetIt.I.isRegistered<Dio>()) {
    GetIt.I.unregister<Dio>();
  }

  GetIt.I.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: 'http://206.189.43.230:8000/api/client/',
        headers: token != null ? {
          'Authorization': 'JWT $token',
        } : null,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
      ),
    ),
  );

}
