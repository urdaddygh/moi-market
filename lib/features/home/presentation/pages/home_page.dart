
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/features/home/domain/repositories/home_repository.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';
import 'package:moi_market/features/home/presentation/widgets/all_card_screen.dart';
import 'package:moi_market/features/home/presentation/widgets/item_card_detailed_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moi_market/global_repository/notification_repository/firebase_notification_repository.dart';
import 'package:moi_market/global_repository/notification_repository/model/default_notification.dart';
import 'package:moi_market/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
      initializeGlobalPushNotificationHandler(context: context);
      initLocalNotifications();
      _sendFirebaseToken();
    super.initState();
  }
  void _sendFirebaseToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    logger.d('FCM Token: $token');
    if (token != null) {
      await GetIt.I.get<HomeRepository>().sendFirebaseToken(token: token);
    }
  }
  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    if (kDebugMode) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Notification onDidReceiveLocalNotification handler ($title)',
      )));
    }
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) {
    if (details.payload == null) return;
    _pushNotificationHandler(context: context, notification: DefaultNotification.fromJson(jsonDecode(details.payload!)));
  }

  void initLocalNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return DefaultCustomWrapper(
          headerTitle: AppLocalizations.of(context)!.myGroup,
          body: state.group != null
              ? const ItemCardDetailedScreen()
              : const AllCardScreen(),
        );
      },
    );
  }

}
Future<void> initializeGlobalPushNotificationHandler({required BuildContext context}) async {
  final repos = context.read<FirebaseNotificationRepository>();
  repos.onForegroundNotification.listen((event) async {
    try {
    logger.d(event);
      // final pushCommand = event.data?['fs_push_json'];
      // switch (pushCommand['cmd']) {
      //   case 'change_status':
          
      // }
    } catch (e) {
      if (!context.mounted) return;
      logger.e(e.toString());
    }
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'default_notification_channel',
      'default',
      channelDescription: '_',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    try {
      FlutterLocalNotificationsPlugin().show(0, event.title, event.body, notificationDetails, payload: jsonEncode(event.toJson()));
    }
    catch(e) {
      logger.e(e);
    }
  });
  repos.onNotificationOpened.listen((event) {
    _pushNotificationHandler(context: context, notification: event);
  });
}

Future<void> _pushNotificationHandler({required BuildContext context, required DefaultNotification notification}) async {
  try {
    logger.d(notification);
    // final pushCommand = notification.data?['fs_push_json'];
    // switch (pushCommand['cmd']) {
    //   case 'change_status':
    //     {

    //     }
    //     break;

    // }
  } catch (e) {
    logger.e(e.toString());
  }
}