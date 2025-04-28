import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/features/notification/data/models/app_notification.dart';

class NotificationItemCard extends StatelessWidget {
  const NotificationItemCard({super.key, this.onTap, this.notification});

  final void Function()? onTap;
  final AppNotification? notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.only(right: 1, left: 1, bottom: 12, top: 1),
      decoration: BoxDecoration(
        color: Style.primaryWhiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: Style.itemShadows,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification?.createdAt == null ? '—' : Style.greenSpaceDateFormat.format(notification!.createdAt!),
                  style: Style.smallText.copyWith(
                    color: Style.primaryBlackColor.withValues(alpha: 0.4),
                  ),
                ),
                const SizedBox(
                  height: Style.smallSpacing,
                ),
                Text(
                  notification?.title ?? '',
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
          SizedBox(
            width: Style.bigSpacing
          ),
          Column(
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
              const SizedBox(height: Style.largeSpacing),
              SvgPicture.asset('assets/svgs/trash_icon.svg')
            ],
          ),
        ],
      ),
    );
  }
}
