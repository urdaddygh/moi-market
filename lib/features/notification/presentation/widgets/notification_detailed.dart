import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationDetailed extends StatelessWidget {
  const NotificationDetailed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
            _onBackTap(context);
          },
          child: Scaffold(
            backgroundColor: Style.primaryWhiteColor,
            body: DefaultCustomWrapper(
              isLoading: state.eventState == NotificationEventState.loading,
              paddingBot: Style.defaultPaddingVertical,
              headerTitle: AppLocalizations.of(context)!.notifications,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Style.defaultPaddingVertical),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Style.primarySecondColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                      ),
                      const SizedBox(width: Style.bigSpacing),
                      Text(
                        state.notification?.createdAt == null
                            ? '—'
                            : Style.greenSpaceDateFormat
                                .format(state.notification!.createdAt!),
                        style: Style.smallText.copyWith(
                          color: Style.primaryBlackColor.withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Style.middleSpacing + 2),
                  Text(
                    state.notification?.title == null
                        ? '—'
                        : state.notification!.title!,
                    style: Style.bigText,
                  ),
                  const SizedBox(height: Style.middleSpacing + 2),
                  Text(
                    state.notification?.message == null
                        ? '—'
                        : state.notification!.message!,
                    style: Style.mainText,
                  ),
                  const Spacer(),
                  DefaultElevatedButton(
                    text: AppLocalizations.of(context)!.back,
                    onPressed: () => _onBackTap(context),
                    textColor: Style.primaryColor,
                    color: Style.primaryWhiteColor,
                    side:
                        const BorderSide(width: 1.5, color: Style.primaryColor),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void _onBackTap(BuildContext context) {
  Navigator.pop(context);
  BlocProvider.of<NotificationCubit>(context).flushNotification();
}
