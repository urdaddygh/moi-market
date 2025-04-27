import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moi_market/core/theme/style.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, required this.svgPath, this.color, this.backroundColor});
  final String svgPath;
  final Color? color;
  final Color? backroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backroundColor ?? Style.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SvgPicture.asset(svgPath, color: color),
    );
  }
}
