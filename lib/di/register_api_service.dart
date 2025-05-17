import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

Future<void> registerApiServiceDi({String? token}) async {
  if (kDebugMode) print('registerApiServiceDi JWT = $token');

  if (GetIt.I.isRegistered<Dio>()) {
    GetIt.I.unregister<Dio>();
  }

  final headers = <String, dynamic>{};
  if (token != null) {
    headers['Authorization'] = 'JWT $token';
  }

  GetIt.I.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: 'http://206.189.43.230/api/client/',
        headers: headers,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
      ),
    ),
  );
}
