import 'package:flutter/material.dart';
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
            Container(width: 44, height: 40, color: Style.primaryColor),
            Container(width: 44, height: 40, color: Style.primarySecondColor)
          ],
        )
      ],
    );
  }
}
