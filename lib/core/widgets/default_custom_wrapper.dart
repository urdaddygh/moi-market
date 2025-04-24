import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_custom_header.dart';

class DefaultCustomWrapper extends StatelessWidget {
  const DefaultCustomWrapper({super.key, this.isLoading = false, required this.body, this.padding, this.onTap, this.headerTitle});
  final bool isLoading;
  final Widget body;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  final String? headerTitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: Style.defaultSpacing,
              vertical: Style.defaultPaddingVertical,
            ),
        child: Column(
          children: [
            if (headerTitle != null) ...[
              SizedBox(height: MediaQuery.of(context).padding.top + Style.largeSpacing),
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
    );
  }
}
