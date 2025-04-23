import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class DefaultElevatedButton extends StatelessWidget {
  const DefaultElevatedButton(
      {super.key, required this.text, required this.onPressed, this.isLoading = false, this.canTap = false, this.color, this.textColor});

  final String text;
  final bool isLoading;
  final void Function()? onPressed;
  final bool canTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Style.primaryWhiteColor)
          : Text(
              text,
              style: Style.formButtonText.copyWith(color: textColor),
            ),
    );
  }
}
