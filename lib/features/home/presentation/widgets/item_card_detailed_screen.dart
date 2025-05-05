import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_divider.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/core/widgets/icon_container.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';
import 'package:moi_market/features/home/presentation/widgets/participants_table.dart';
import 'package:moi_market/features/home/presentation/widgets/payment_schedule_table.dart';
import 'package:moi_market/features/home/presentation/widgets/requisites_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemCardDetailedScreen extends StatelessWidget {
  const ItemCardDetailedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: Style.bigSpacing),
            RequisitesWrapper(
              phone: state.group?.paymentDetails ??
                  AppLocalizations.of(context)!.unknown,
            ),
            const SizedBox(height: Style.defaultPaddingVertical),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const IconContainer(svgPath: 'assets/svgs/people.svg'),
                        const SizedBox(width: Style.defaultSpacing + 2),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${AppLocalizations.of(context)!.group} №${state.group?.id ?? '—'}',
                                style: Style.bigText),
                            Row(
                              children: [
                                Text(
                                    '${AppLocalizations.of(context)!.createDate}: ${state.group?.createdAt == null ? '—' : Style.greenSpaceDateFormat.format(state.group!.createdAt!)}'),
                                const SizedBox(
                                  width: Style.defaultSpacing,
                                ),
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                    const DefaultDivider(),
                    const SizedBox(height: Style.largeSpacing),
                    if (state.group != null && state.group!.myTickets != null)
                      ...state.group!.myTickets!.asMap().entries.map(
                        (entry) {
                          final index = entry.key + 1;
                          final ticket = entry.value;
                          return PaymentScheduleTable(
                            myTickets: ticket,
                            index: index,
                          );
                        },
                      ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        const IconContainer(
                          svgPath: 'assets/svgs/people.svg',
                          backroundColor: Style.dividerGreyColor,
                          color: Style.primaryBlackColor,
                        ),
                        const SizedBox(width: Style.defaultSpacing + 2),
                        Text(
                          '${AppLocalizations.of(context)!.listOfParticipants}:',
                          style: Style.bigText,
                        )
                      ],
                    ),
                    const DefaultDivider(),
                    const SizedBox(height: Style.largeSpacing),
                    ParticipantsTable(tickets: state.group?.tickets)
                  ],
                ),
              ),
            ),
            DefaultElevatedButton(
              text: AppLocalizations.of(context)!.back,
              onPressed: () => BlocProvider.of<HomeCubit>(context).flushGroup(),
              color: Style.primaryWhiteColor,
              textColor: Style.primaryColor,
              side: const BorderSide(
                width: 1.5,
                color: Style.primaryColor,
              ),
            ),
            const SizedBox(height: Style.defaultSpacing)
          ],
        );
      },
    );
  }
}
