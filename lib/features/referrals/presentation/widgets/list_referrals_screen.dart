import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/core/widgets/default_divider.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/core/widgets/icon_container.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_cubit.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_state.dart';
import 'package:moi_market/features/referrals/presentation/widgets/referrals_table.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ListReferralsScreen extends StatefulWidget {
  const ListReferralsScreen({super.key});

  @override
  State<ListReferralsScreen> createState() => _ListReferralsScreenState();
}

class _ListReferralsScreenState extends State<ListReferralsScreen> {
  @override
  void initState() {
    BlocProvider.of<ReferralsCubit>(context).loadReferrals(context: context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultCustomWrapper(
      headerTitle: AppLocalizations.of(context)!.referrals,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: Style.defaultPaddingVertical),
          Row(
              children: [
                const IconContainer(
                  svgPath: 'assets/svgs/people.svg',
                ),
                const SizedBox(width: Style.defaultSpacing + 2),
                Text(
                  '${AppLocalizations.of(context)!.listOfReferrals}:',
                  style: Style.bigText,
                )
              ],
            ),
            const DefaultDivider(),
            const SizedBox(height: Style.largeSpacing),
            Expanded(
              child: BlocBuilder<ReferralsCubit, ReferralsState>(
                builder: (context, state) {
                  if (state.eventState == ReferralsEventState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ReferralsTable(referrals: state.referrals);
                },
              ),
            ),
            const Spacer(),
            DefaultElevatedButton(
              text: AppLocalizations.of(context)!.addReferral,
              onPressed: () => BlocProvider.of<ReferralsCubit>(context).changeScreen(ReferralScreen.addReferralScreen),
            ),
          const SizedBox(height: Style.defaultPaddingVertical),
        ],
      ),
    );
  }
}
