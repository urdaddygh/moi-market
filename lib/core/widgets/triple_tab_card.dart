import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class TripleTabCard extends StatelessWidget {
  final String firstTitle;
  final String secondTitle;
  final String thirdTitle;
  final Widget firstTab;
  final Widget secondTab;
  final Widget thirdTab;
  final Color? indicatorColor;

  const TripleTabCard({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    required this.thirdTitle,
    required this.firstTab,
    required this.secondTab,
    required this.thirdTab, this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 43,
                decoration: BoxDecoration(
                  border: Border.all(color: Style.hintTextColor),
                  borderRadius: BorderRadius.circular(Style.defaultSplashRadius),
                ),
              ),
              SizedBox(
                height: 43,
                child: TabBar(
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFFC5C5C5),
                  indicator: BoxDecoration(
                    color: indicatorColor,
                    borderRadius: BorderRadius.circular(Style.defaultSplashRadius),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  tabs: [
                    Tab(text: firstTitle),
                    Tab(text: secondTitle),
                    Tab(text: thirdTitle),
                  ],
                  dividerColor: Colors.transparent,
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11.5),
                  child: Row(
                    children: [
                      const Spacer(),
                      Container(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      const Spacer(),
                      Container(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                firstTab,
                secondTab,
                thirdTab,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
