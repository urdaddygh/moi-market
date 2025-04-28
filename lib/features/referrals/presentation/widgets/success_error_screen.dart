import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_cubit.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_state.dart';

class SuccessErrorScreen extends StatelessWidget {
  const SuccessErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (!didPop) {
          BlocProvider.of<ReferralsCubit>(context).changeScreen(ReferralScreen.addReferralScreen);
          return;
        }
      },
      child: DefaultCustomWrapper(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: BlocBuilder<ReferralsCubit, ReferralsState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state.referralScreen == ReferralScreen.errorScreen) ...[
                              Image.asset('assets/images/warning.png'),
                              const SizedBox(height: 43),
                              const Text('Реферал не добавлен. Произошла ошибка.', style: Style.bigText,)
                            ] else ...[
                              Image.asset('assets/images/success.png'),
                              const SizedBox(height: 43),
                              const Text('Реферал успешно добавлен!', style: Style.bigText)
                            ]
                          ],
                        ),
                      ),
                      DefaultElevatedButton(
                        color: state.referralScreen == ReferralScreen.errorScreen ? Style.primarySecondColor : null,
                        text: state.referralScreen == ReferralScreen.errorScreen ? 'Попробовать еще раз' : 'Добавить еще',
                        onPressed: () => BlocProvider.of<ReferralsCubit>(context).changeScreen(ReferralScreen.addReferralScreen),
                      ),
                      const SizedBox(height: Style.defaultPaddingVertical),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
