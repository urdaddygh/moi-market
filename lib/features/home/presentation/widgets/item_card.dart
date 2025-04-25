import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moi_market/core/theme/style.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    const Text(
                      'Группа №11',
                      style: Style.bigText,
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: Style.middleSpacing + 2),
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Дата создания:',
                            style: Style.smallText.copyWith(
                              fontSize: 10,
                              color:
                                  Style.primaryBlackColor.withValues(alpha: 0.5),
                            ),
                          ),
                          const Text(
                            '20.02.23',
                            style: Style.smallText,
                          ),
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
            const Divider(color: Style.hintTextColor, thickness: 1),
            const SizedBox(height: Style.bigSpacing),
            Row(
              spacing: Style.largeSpacing + 6,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Статус оплаты:',
                      style: Style.smallText.copyWith(
                        color: Style.primaryBlackColor.withValues(alpha: 0.7),
                      ),
                    ),
                    Text('Не оплачено', style: Style.mainText),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'График погашения:',
                      style: Style.smallText.copyWith(
                        color: Style.primaryBlackColor.withValues(alpha: 0.7),
                      ),
                    ),
                    Text('15 февраля 2025 г.', style: Style.mainText),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
