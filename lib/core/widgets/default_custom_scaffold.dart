import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class DefaultCustomScaffold extends StatelessWidget {
  const DefaultCustomScaffold({super.key, this.isLoading = false, required this.body, this.backgroundColor});
  final bool isLoading;
  final Widget body;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Style.primaryColor,
      body: GestureDetector(onTap: () => FocusScope.of(context).unfocus(),child: Stack(children: [isLoading ? const CircularProgressIndicator() : body])),
    );
  }
}