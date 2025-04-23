import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class DefaultCustomScaffold extends StatelessWidget {
  const DefaultCustomScaffold({super.key, this.isLoading = false, required this.body, this.backgroundColor, this.padding, this.onTap});

  final bool isLoading;
  final Widget body;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Style.primaryWhiteColor,
      body: GestureDetector(
          onTap: onTap ?? () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding:
                padding ?? const EdgeInsets.symmetric(horizontal: Style.defaultSpacing, vertical: Style.defaultPaddingVertical),
            child: Stack(children: [isLoading ? const CircularProgressIndicator() : body]),
          )),
    );
  }
}
