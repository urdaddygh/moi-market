import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moi_market/global_repository/notification_repository/model/default_notification.dart';
import 'package:moi_market/main.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseNotificationRepository {
  FirebaseNotificationRepository({
    String? vapidKey,
    FirebaseMessaging? firebaseMessaging,
    Stream<RemoteMessage>? onNotificationOpened,
    Stream<RemoteMessage>? onForegroundNotification,
  })  : _vapidKey = vapidKey,
        _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance,
        _onForegroundNotification =
            onForegroundNotification ?? FirebaseMessaging.onMessage,
        _onNotificationOpenedController = BehaviorSubject<DefaultNotification>() {
    _initialize(onNotificationOpened ?? FirebaseMessaging.onMessageOpenedApp);
  }

  final String? _vapidKey;
  final FirebaseMessaging _firebaseMessaging;
  final Stream<RemoteMessage> _onForegroundNotification;
  final BehaviorSubject<DefaultNotification> _onNotificationOpenedController;


  Future _initialize(Stream<RemoteMessage> onNotificationOpened) async {
    final response = await _firebaseMessaging.requestPermission();
    final status = response.authorizationStatus;
    FirebaseMessaging.onBackgroundMessage(FirebaseNotificationRepository.onBackgroundMessage);
    FirebaseMessaging.onMessage.listen((event) async {
      logger.d('onMessage: ${event.toString()}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      logger.d('onMessageOpenedApp: ${event.toString()}');
    });
    if (status == AuthorizationStatus.authorized) {
      final message = await _firebaseMessaging.getInitialMessage();
      if (message != null) {
        _onMessageOpened(message);
      }
      onNotificationOpened.listen(_onMessageOpened);
    }
  }

  // Future<void> _initialize(Stream<RemoteMessage> onNotificationOpened) async {
  //   final response = await _firebaseMessaging.requestPermission();
  //   final status = response.authorizationStatus;
  //   if (status == AuthorizationStatus.authorized) {
  //     final message = await _firebaseMessaging.getInitialMessage();
  //     final token = await _firebaseMessaging.getToken(vapidKey: _vapidKey);
  //     await _sendTokenToServer(token!);
  //     if (message != null) {
  //       _onMessageOpened(message);
  //     }
  //     onNotificationOpened.listen(_onMessageOpened);
  //   }
  // }

  void _onMessageOpened(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      _onNotificationOpenedController.sink.add(
        DefaultNotification(
          title: notification.title ?? '',
          body: notification.body ?? '',
          data: message.data,
        ),
      );
    }
  }

  /// Returns a [Stream] that emits when a user presses a [DefaultNotification]
  /// message displayed via FCM.
  ///
  /// If your app is opened via a notification whilst the app is terminated,
  /// see [FirebaseMessaging.getInitialMessage].
  Stream<DefaultNotification> get onNotificationOpened {
    return _onNotificationOpenedController.stream;
  }

  /// Returns a [Stream] that emits when an incoming [DefaultNotification] is
  /// received whilst the Flutter instance is in the foreground.
  Stream<DefaultNotification> get onForegroundNotification {
    return _onForegroundNotification.mapNotNull((message) {
      final notification = message.notification;
      if (notification == null) {
        return null;
      }
      return DefaultNotification(
        title: notification.title ?? '',
        body: notification.body ?? '',
        data: null,
      );
    });
  }

  static Future<void> onBackgroundMessage(message) async {
    logger.d('onBackgroundMessage: ${message.toString()}');
  }
}
