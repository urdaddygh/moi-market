import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_divider.dart';
import 'package:moi_market/features/home/data/models/group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ItemCard extends StatelessWidget {
  const ItemCard({super.key, this.onTap, required this.group});
  final void Function()? onTap;
  final Group? group;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 1, left: 1, bottom: 12, top: 1),
        decoration: BoxDecoration(
          color: Style.primaryWhiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: Style.itemShadows,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Style.defaultSpacing,
            vertical: Style.defaultSpacing + 2,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Style.primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset('assets/svgs/people.svg'),
                  ),
                  const SizedBox(width: Style.defaultSpacing + 2),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.group} №${group?.id ?? '—'}',
                        style: Style.bigText,
                        textAlign: TextAlign.start,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: Style.middleSpacing + 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.createDate}:',
                              style: Style.smallText.copyWith(
                                fontSize: 10,
                                color: Style.primaryBlackColor
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                            Text(
                              group?.createdAt == null
                                  ? '—'
                                  : Style.greenSpaceDateFormat
                                      .format(group!.createdAt!),
                              style: Style.smallText,
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
              const DefaultDivider(),
              const SizedBox(height: Style.bigSpacing),
              Row(
                spacing: Style.largeSpacing + 6,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.payStatus}:',
                        style: Style.smallText.copyWith(
                          color: Style.primaryBlackColor
                              .withValues(alpha: 0.7),
                        ),
                      ),
                      const Text('Не оплачено', style: Style.mainText),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.repaymentSchedule}:',
                        style: Style.smallText.copyWith(
                          color: Style.primaryBlackColor
                              .withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        group?.nextPaymentSchedule == null
                            ? '—'
                            : Style.defaultDateFormat
                                .format(group!.nextPaymentSchedule!),
                        style: Style.mainText,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
