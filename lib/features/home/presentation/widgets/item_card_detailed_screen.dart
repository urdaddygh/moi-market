import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/core/widgets/icon_container.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';
import 'package:moi_market/features/home/presentation/widgets/participants_table.dart';
import 'package:moi_market/features/home/presentation/widgets/payment_schedule_table.dart';
import 'package:moi_market/features/home/presentation/widgets/requisites_wrapper.dart';

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
              phone: state.group?.paymentDetails ?? 'Неизвестно',
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
                            Text('Группа №${state.group?.id ?? '—'}',
                                style: Style.bigText),
                            Row(
                              children: [
                                Text(
                                    'Дата создания: ${state.group?.createdAt == null ? '—' : Style.greenSpaceDateFormat.format(state.group!.createdAt!)}'),
                                const SizedBox(
                                  width: Style.defaultSpacing,
                                ),
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                    const Divider(thickness: 1, color: Style.dividerGreyColor),
                    const SizedBox(height: Style.largeSpacing),
                    const PaymentScheduleTable(),
                    const SizedBox(height: 40),
                    const Row(
                      children: [
                        IconContainer(
                          svgPath: 'assets/svgs/people.svg',
                          backroundColor: Style.dividerGreyColor,
                          color: Style.primaryBlackColor,
                        ),
                        SizedBox(width: Style.defaultSpacing + 2),
                        Text(
                          'Список участников:',
                          style: Style.bigText,
                        )
                      ],
                    ),
                    const Divider(thickness: 1, color: Style.dividerGreyColor),
                    const SizedBox(height: Style.largeSpacing),
                    ParticipantsTable(tickets: state.group?.tickets)
                  ],
                ),
              ),
            ),
            DefaultElevatedButton(
              text: 'Назад',
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
