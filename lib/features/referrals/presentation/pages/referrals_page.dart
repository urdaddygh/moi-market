import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_cubit.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_state.dart';
import 'package:moi_market/features/referrals/presentation/widgets/add_referral_form.dart';
import 'package:moi_market/features/referrals/presentation/widgets/list_referrals_screen.dart';
import 'package:moi_market/features/referrals/presentation/widgets/success_error_screen.dart';

class ReferralsPage extends StatelessWidget {
  const ReferralsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferralsCubit, ReferralsState>(
      builder: (context, state) {
        if (state.referralScreen == ReferralScreen.listReferralsScreen) {
        return const ListReferralsScreen();
        } else if (state.referralScreen == ReferralScreen.addReferralScreen){
          return const AddReferralForm();
        } else {
          return const SuccessErrorScreen();
        }
      },
    );
  }
}
