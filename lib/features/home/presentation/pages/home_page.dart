import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_custom_scaffold.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/features/home/presentation/widgets/requisites_wrapper.dart';
import 'package:moi_market/features/home/presentation/widgets/triple_tab_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultCustomWrapper(headerTitle: 'Мои группы',body: Column(
        children: [
          const SizedBox(height: Style.bigSpacing),
          const RequisitesWrapper(
            phone: '+996 500 500 500',
          ),
          const SizedBox(height: Style.bigSpacing),
          Expanded( /// 🔧 ОБЯЗАТЕЛЬНО! Даёт ограничение по высоте
            child: RentTripleTab(
              firstTitle: 'Все',
              secondTitle: 'Активные',
              thirdTitle: 'Неактивные',
              firstTab: Container(color: Style.primarySecondColor),
              secondTab: Container(color: Style.primarySecondColor),
              thirdTab: Container(color: Style.primarySecondColor),
            ),
          ),
        ],
      ));
  }
}
