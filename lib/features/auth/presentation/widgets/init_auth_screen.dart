import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/features/auth/presentation/widgets/auth_text.dart';

class InitAuthScreen extends StatelessWidget {
  const InitAuthScreen({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Style.defaultSpacing, vertical: Style.defaultPaddingVertical),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/auth_init_icon.png'),
                ),
              ),
              Column(children: [
                const AuthText(color: Style.primaryWhiteColor),
                const SizedBox(height: Style.largeSpacing),
                DefaultElevatedButton(onPressed: onTap, text: 'Войти', color: Style.primaryWhiteColor, textColor: Style.primaryColor)
              ],)
            ],
          ),
        ));
  }
}
