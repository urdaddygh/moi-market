import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_custom_header.dart';

class DefaultCustomWrapper extends StatelessWidget {
  const DefaultCustomWrapper({super.key, this.isLoading = false, required this.body, this.padding, this.onTap, this.headerTitle, this.paddingTop = 0,  this.paddingBot = 0});
  final bool isLoading;
  final Widget body;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  final String? headerTitle;
  final double paddingTop;
  final double paddingBot;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onTap ?? () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: padding ??
              EdgeInsets.only(
                left: Style.defaultSpacing,
                right: Style.defaultSpacing,
                bottom: paddingBot,
                top: paddingTop,
              ),
          child: Column(
            children: [
              if (headerTitle != null) ...[
                SizedBox(height: MediaQuery.of(context).padding.top),
                DefaultCustomHeader(title: headerTitle!),
              ],
              Expanded(
                child: Stack(
                  children: [isLoading ? const CircularProgressIndicator() : body],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
