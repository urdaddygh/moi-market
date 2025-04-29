import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';
import 'package:moi_market/features/home/presentation/widgets/all_card_screen.dart';
import 'package:moi_market/features/home/presentation/widgets/item_card_detailed_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return DefaultCustomWrapper(
          headerTitle: AppLocalizations.of(context)!.myGroup,
          body: state.group != null
              ? const ItemCardDetailedScreen()
              : const AllCardScreen(),
        );
      },
    );
  }
}