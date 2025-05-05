import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';
import 'package:moi_market/features/home/presentation/widgets/first_tab.dart';
import 'package:moi_market/core/widgets/triple_tab_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moi_market/features/home/presentation/widgets/second_tab.dart';
import 'package:moi_market/features/home/presentation/widgets/third_tab.dart';

class AllCardScreen extends StatelessWidget {
  const AllCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Style.bigSpacing),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return TripleTabCard(
                indicatorColor: Style.primaryColor,
                firstTitle: AppLocalizations.of(context)!.all,
                secondTitle: AppLocalizations.of(context)!.active,
                thirdTitle: AppLocalizations.of(context)!.unActive,
                firstTab: const FirstTab(),
                secondTab: const SecondTab(),
                thirdTab: const ThirdTab(),
              );
            },
          ),
        ),
      ],
    );
  }
}
