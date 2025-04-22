import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class DefaultElevatedButton extends StatelessWidget {
  const DefaultElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false,
      this.canTap = false});
  final String text;
  final bool isLoading;
  final void Function()? onPressed;
  final bool canTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Style.formButtonDecoration.copyWith(
        backgroundColor: MaterialStateProperty.all(
          canTap ? Style.primaryColor : Style.primaryLightGreyColor,
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Style.primaryWhiteColor)
          : Text(
              text,
              style: Style.formButtonText,
            ),
    );
  }
}
