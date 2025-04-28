import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class DefaultDivider extends StatelessWidget {
  const DefaultDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: 1, color: Style.primaryBlackColor.withValues(alpha: 0.1));
  }
}
