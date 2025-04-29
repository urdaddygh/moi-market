import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_state.dart';
import 'package:moi_market/features/notification/presentation/widgets/notification_list_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return DefaultCustomWrapper(
          headerTitle: AppLocalizations.of(context)!.notifications,
          body: const NotificationListScreen(),
        );
      },
    );
  }
}
