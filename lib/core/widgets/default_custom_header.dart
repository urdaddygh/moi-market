import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moi_market/core/theme/style.dart';

class DefaultCustomHeader extends StatelessWidget {
  const DefaultCustomHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Style.titleText,
          maxLines: 3,
          textAlign: TextAlign.center,
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.zero,
              width: 48,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Style.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: SvgPicture.asset('assets/svgs/coins.svg')),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Style.primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: const Text(
                      '250',
                      style: Style.iconText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: EdgeInsets.zero,
              width: 48,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Style.primarySecondColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: SvgPicture.asset('assets/svgs/translate.svg')),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Style.primarySecondColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'RUS',
                      style: Style.iconText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
