import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class DefaultAlertDialog extends StatelessWidget {
  const DefaultAlertDialog({
    required this.content,
    this.title,
    this.actions,
    this.actionsAlignment = MainAxisAlignment.center, // по умолчанию по центру
    super.key,
  });

  final Widget content;
  final Widget? title;
  final List<Widget>? actions;
  final MainAxisAlignment actionsAlignment;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero, // убираем отступы по краям
      child: Stack(
        children: [
          // размытие
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const SizedBox(),
            ),
          ),
          // контент
          Center(
            child: Container(
              width: double.infinity, // на всю ширину
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                boxShadow: Style.dialogShadows,
                color: Style.primaryWhiteColor,
                borderRadius: BorderRadius.circular(Style.defaultSplashRadius),
              ),
              child: Stack(
                children: [
                  Positioned(
                      top: 15,
                      right: 5,
                      child: IconButton(
                        icon: const Icon(Icons.clear, color: Style.hintTextColor),
                        onPressed: () => Navigator.pop(context),
                      )),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null) ...[
                        Padding(
                          padding: const EdgeInsets.all(Style.defaultPaddingVertical),
                          child: title!,
                        ),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Style.largeSpacing),
                        child: content,
                      ),
                      if (actions != null && actions!.isNotEmpty) ...[
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: Style.bigSpacing, vertical: Style.defaultPaddingVertical),
                          child: Row(
                            mainAxisAlignment: actionsAlignment,
                            children: actions!,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
