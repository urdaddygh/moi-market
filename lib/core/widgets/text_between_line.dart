import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class TextBetweenLine extends StatelessWidget {
  const TextBetweenLine({super.key, required this.text, this.indent, this.endIndent});
  final String text;
  final double? indent;
  final double? endIndent;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(
          child: Divider(
            color: Style.primaryLightGreyColor,
            thickness: 2,
            endIndent: endIndent,
            indent: indent,
          ),
        ),
        Text(
          text,
          style: Style.mainText.copyWith(fontSize: 12),
        ),
        Expanded(
          child: Divider(
            color: Style.primaryLightGreyColor,
            thickness: 2,
            indent: endIndent,
            endIndent: indent,
          ),
        ),
      ],
    );
  }
}
