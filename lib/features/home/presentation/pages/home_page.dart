import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';
import 'package:moi_market/features/home/presentation/widgets/all_card_screen.dart';
import 'package:moi_market/features/home/presentation/widgets/item_card_detailed_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moi_market/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    requestNotificationPermission();
    super.initState();
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

    void requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    logger.d('🔔 Разрешение: ${settings.authorizationStatus}');
  }

}