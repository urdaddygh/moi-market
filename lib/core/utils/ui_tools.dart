
import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UiTools {
  static void showSnackBar({required BuildContext context, required String message, int? displayDuration=2000, Color? backgroundColor, Color? color}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: message,
        icon: const SizedBox(),
        textStyle: Style.noticeableText.copyWith(color: color),
        backgroundColor: backgroundColor ?? Style.primaryWhiteColor,
        borderRadius: BorderRadius.circular(10),
        maxLines: 3,
      ),
      dismissType: DismissType.onSwipe,
      dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
      // onTap: () => Overlay.of(context). Clipboard.setData(ClipboardData(text: message)),
      padding: const EdgeInsets.only(top: 70, right: Style.defaultSpacing, left: Style.defaultSpacing),
      curve: Curves.easeOutCirc,
      animationDuration: const Duration(milliseconds: 800),
      displayDuration: Duration(milliseconds: displayDuration!),
    );
  }
}