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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moi_market/features/personal_account/presentation/cubit/personal_account_state.dart';

class PersonalAccountPage extends StatefulWidget {
  const PersonalAccountPage({super.key});

  @override
  State<PersonalAccountPage> createState() => _PersonalAccountPageState();
}

class _PersonalAccountPageState extends State<PersonalAccountPage> {
  @override
  void initState() {
    BlocProvider.of<PersonalAccountCubit>(context)
        .loadUserInfo(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultCustomWrapper(
      headerTitle: AppLocalizations.of(context)!.personalAccount,
      body: RefreshIndicator(
        onRefresh: () async {
          await BlocProvider.of<PersonalAccountCubit>(context)
              .loadUserInfo(context: context);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                  vertical: Style.defaultPaddingVertical, horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    BlocBuilder<PersonalAccountCubit, PersonalAccountState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            const IconContainer(
                              svgPath:
                                  'assets/svgs/active_personal_account_icon.svg',
                            ),
                            const SizedBox(width: Style.defaultSpacing + 2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.userInfo?.user?.fullName ??
                                      AppLocalizations.of(context)!.unknown,
                                  style: Style.bigText,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svgs/snowflake.svg'),
                                    const SizedBox(width: 6),
                                    Text(
                                        "${state.userInfo?.level ?? AppLocalizations.of(context)!.unknown} уровень"),
                                  ],
                                )
                              ],
                            )
                          ],
                        );
                      },
                    ),
                    const DefaultDivider(),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DefaultElevatedButton(
                      textColor: Style.primarySecondColor,
                      color: Style.primaryWhiteColor,
                      side: const BorderSide(
                          width: 1.5, color: Style.primarySecondColor),
                      text: AppLocalizations.of(context)!.exit,
                      onPressed: () {
                        showDialog(
                          barrierColor: Colors.grey.withAlpha(50),
                          context: context,
                          builder: (context) => DefaultAlertDialog(
                            title: Text(
                              AppLocalizations.of(context)!
                                  .messageExitInYourAccount,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: Style.titleText,
                            ),
                            content: Text(
                              AppLocalizations.of(context)!
                                  .thisActionIsIrreversible,
                              textAlign: TextAlign.center,
                              style: Style.bigText,
                            ),
                            actions: [
                              Expanded(
                                child: DefaultElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<PersonalAccountCubit>(
                                            context)
                                        .logout(context);
                                  },
                                  text: AppLocalizations.of(context)!.exit,
                                  color: Style.primarySecondColor,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: DefaultElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  text: AppLocalizations.of(context)!.cancel,
                                  color: Style.primaryWhiteColor,
                                  textColor: Style.primaryColor,
                                  side: const BorderSide(
                                      width: 1.5, color: Style.primaryColor),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: Style.defaultPaddingVertical),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
