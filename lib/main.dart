import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:moi_market/application.dart';
import 'package:moi_market/core/cubit/language/language_state.dart';
import 'package:moi_market/core/local_storage/local_storage.dart';
import 'package:moi_market/di/service_locator.dart';

final logger = Logger(
  printer: SimplePrinter(
    printTime: true,
    colors: true,
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await _initCertificateForOldAndroids();
  await ServiceLocator().initModules();
  await _setupFlutterNotifications();
  final language = await _fetchLanguageLocal();
  runApp(
    Application(lang: language),
  );
}

/// 🔥 Фоновое сообщение
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  logger.d('📩 Фоновое сообщение: ${message.notification?.title}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _setupFlutterNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      final String? payload = response.payload;
      logger.d('🔔 Нажали на локальное уведомление: $payload');
      
      if (payload != null) {
        // Пример: GoRouter.of(context).go('/notifications');
        // Но здесь context недоступен, надо передать через callback или использовать service locator
      }
    },
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Основной канал',
    description: 'Используется для важных уведомлений',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

Future _initCertificateForOldAndroids() async {
  ByteData isr = await PlatformAssetBundle().load('assets/ca/isrgrootx1.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(isr.buffer.asUint8List());
  ByteData etsEncryptR3 =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(etsEncryptR3.buffer.asUint8List());
}

void initSystemUiMode() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

Future<Language?> _fetchLanguageLocal() async {
  try {
    switch (await GetIt.I.get<LocalStorage>().readLanguageCode()) {
      case 'ru':
        return Language.ru;
      case 'ky':
        return Language.ky;
      default:
        return null;
    }
  } catch (e) {
    logger.e(e);
  }
  return null;
}
