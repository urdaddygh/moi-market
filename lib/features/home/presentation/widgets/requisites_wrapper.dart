import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class RequisitesWrapper extends StatelessWidget {
  const RequisitesWrapper({super.key, required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Style.primarySecondColor.withValues(alpha: 0.1), borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(Style.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Реквизиты для оплаты группы:', style: Style.mainText.copyWith(fontSize: 12, color: Style.primarySecondColor)),
            const SizedBox(height: Style.smallSpacing),
            Text(phone,
                style: Style.mainText.copyWith(fontSize: 16, color: Style.primarySecondColor, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
