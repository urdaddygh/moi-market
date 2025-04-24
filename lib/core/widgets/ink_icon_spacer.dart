import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class InkIconSpacer extends StatelessWidget {
  const InkIconSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: Style.defaultIconSize,
      height: Style.defaultIconSize,
    );
  }
}
