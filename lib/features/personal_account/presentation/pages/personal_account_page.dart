import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_alert_dialog.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/core/widgets/default_divider.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/core/widgets/icon_container.dart';
import 'package:moi_market/features/personal_account/presentation/cubit/personal_account_cubit.dart';

class PersonalAccountPage extends StatelessWidget {
  const PersonalAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultCustomWrapper(
      headerTitle: 'Личный кабинет',
      body: Column(
        children: [
          const SizedBox(height: Style.defaultPaddingVertical),
          Row(
            children: [
              const IconContainer(
                svgPath: 'assets/svgs/active_personal_account_icon.svg',
              ),
              const SizedBox(width: Style.defaultSpacing + 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Токтосунова Айжан',
                    style: Style.bigText,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [SvgPicture.asset('assets/svgs/snowflake.svg'), const SizedBox(width: 6), const Text('1 уровень')],
                  )
                ],
              )
            ],
          ),
          const DefaultDivider(),
          const Spacer(),
          DefaultElevatedButton(
              textColor: Style.primarySecondColor,
              color: Style.primaryWhiteColor,
              side: const BorderSide(width: 1.5, color: Style.primarySecondColor),
              text: 'Удалить аккаунт',
              onPressed: () {
                showDialog(
                  barrierColor: Colors.grey.withValues(alpha: 0.2),
                  context: context,
                  builder: (context) => DefaultAlertDialog(
                    title: const Text('Удалить ваш аккаунт?', textAlign: TextAlign.center, maxLines: 1, style: Style.titleText,),
                    content: const Text('Это действие необратимо.', textAlign: TextAlign.center,style: Style.bigText,),
                      actions: [
                        Expanded(
                          child: DefaultElevatedButton(
                            onPressed: () {
                              BlocProvider.of<PersonalAccountCubit>(context).logout(context);
                            },
                            text: 'Удалить',
                            color: Style.primarySecondColor,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: DefaultElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: 'Отменить',
                            color: Style.primaryWhiteColor,
                            textColor: Style.primaryColor,
                            side: const BorderSide(width: 1.5, color: Style.primaryColor),
                          ),
                        )
                      ]
                  ),
                );
              }),
          const SizedBox(height: Style.defaultPaddingVertical)
        ],
      ),
    );
  }
}
