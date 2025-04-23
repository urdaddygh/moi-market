import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class AuthText extends StatelessWidget {
  const AuthText({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Авторизация',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: color),
        ),
        const SizedBox(
          height: Style.bigSpacing,
        ),
        Text(
          'Авторизуйтесь с помощью номера телефона для доступа к аккаунту.',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color),
        ),
      ],
    );
  }
}
