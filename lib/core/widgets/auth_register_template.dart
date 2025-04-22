
import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/custom_back_button.dart';
import 'package:moi_market/core/widgets/default_custom_scaffold.dart';

class AuthRegisterTemplate extends StatelessWidget {
  const AuthRegisterTemplate({super.key, required this.titleText, required this.underTitleText, this.backgroundColor, required this.content, this.showBackButton = false, this.hideLoginUsing = false});
  final String titleText;
  final String underTitleText;
  final Color? backgroundColor;
  final Widget content;
  final bool showBackButton;
  final bool hideLoginUsing;
  @override
  Widget build(BuildContext context) {
    return DefaultCustomScaffold(
      backgroundColor: backgroundColor,
        body: Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          child: Image.asset('assets/images/qwe.png'),
        ),
        if(showBackButton)
         Positioned(
          left: 20,
          top: 40,
          child: CustomBackButton(onTap: () => {}),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxHalfHeight = constraints.maxHeight * 0.57;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: Style.bigSpacing, left: Style.bigSpacing, top: 80,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          titleText,
                          style: Style.authPageTitleText,
                        ),
                        const SizedBox(height: Style.bigSpacing),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Style.primaryWhiteColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              height: 12,
                              width: 12,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              underTitleText,
                              style: Style.authPageTitleText.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: maxHalfHeight),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Style.primaryWhiteColor,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: Style.bigSpacing,
                        vertical: Style.defaultPaddingVertical,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                              content,
                              
                            ],
                          ),
                        ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ));
  }
}