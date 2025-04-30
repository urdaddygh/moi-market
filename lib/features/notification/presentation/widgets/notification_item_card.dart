import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_alert_dialog.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/features/notification/data/models/app_notification.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_state.dart';

class NotificationItemCard extends StatelessWidget {
  const NotificationItemCard({super.key, this.onTap, this.notification});

  final void Function()? onTap;
  final AppNotification? notification;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.only(right: 1, left: 1, bottom: 12, top: 1),
        decoration: BoxDecoration(
          color: Style.primaryWhiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: Style.itemShadows,
        ),
        child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification?.createdAt == null
                            ? '—'
                            : Style.greenSpaceDateFormat
                            .format(notification!.createdAt!),
                        style: Style.smallText.copyWith(
                          color: Style.primaryBlackColor.withValues(alpha: 0.4),
                        ),
                      ),
                      const SizedBox(
                        height: Style.smallSpacing,
                      ),
                      Text(
                        notification?.id?.toString() ?? '',
                        style: Style.mainText.copyWith(fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: Style.smallSpacing,
                      ),
                      Text(
                        notification?.message ?? '',
                        style: Style.smallText.copyWith(
                          color: Style.primaryBlackColor.withValues(alpha: 0.4),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: Style.bigSpacing),
                Column(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: notification?.isRead ?? false ? Colors.transparent : Style.primarySecondColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                    ),
                    const SizedBox(height: Style.largeSpacing),
                    Material(
                      child: InkWell(
                        onTap: () =>
                        {
                          showDialog(
                            barrierColor: Colors.grey.withValues(alpha: 0.2),
                            context: context,
                            builder: (context) =>
                                DefaultAlertDialog(
                                    title: Text(
                                      AppLocalizations.of(context)!.messageDeleteNotification,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: Style.titleText,
                                    ),
                                    content: Text(
                                      AppLocalizations.of(context)!.thisActionIsIrreversible,
                                      textAlign: TextAlign.center,
                                      style: Style.bigText,
                                    ),
                                    actions: [
                                      Expanded(
                                        child: DefaultElevatedButton(
                                          onPressed: () {
                                            BlocProvider.of<NotificationCubit>(context)
                                                .removeNotification();
                                          },
                                          text: AppLocalizations.of(context)!.delete,
                                          color: Style.primarySecondColor,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: DefaultElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          text: AppLocalizations.of(context)!.cancel,
                                          color: Style.primaryWhiteColor,
                                          textColor: Style.primaryColor,
                                          side: const BorderSide(
                                              width: 1.5, color: Style.primaryColor),
                                        ),
                                      )
                                    ]),
                          )
                        },
                        child: Ink(
                          child: SvgPicture.asset('assets/svgs/trash_icon.svg'),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
