import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moi_market/core/cubit/language/language_cubit.dart';
import 'package:moi_market/core/cubit/language/language_state.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moi_market/features/personal_account/presentation/cubit/personal_account_cubit.dart';
import 'package:moi_market/features/personal_account/presentation/cubit/personal_account_state.dart';

class DefaultCustomHeader extends StatelessWidget {
  const DefaultCustomHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Style.titleText,
          maxLines: 3,
          textAlign: TextAlign.center,
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.zero,
              width: 48,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Style.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: BlocBuilder<PersonalAccountCubit, PersonalAccountState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: SvgPicture.asset('assets/svgs/coins.svg')),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Style.primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Text(
                          state.userInfo?.bonus?.toString() ?? '0',
                          style: Style.iconText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            const SizedBox(width: 6),
            Material(
              child: InkWell(
                onTap: () async {
                  var langCode =
                      BlocProvider.of<LanguageCubit>(context).langCode;
                  if (langCode == 'ru') {
                    BlocProvider.of<LanguageCubit>(context)
                        .changeLanguage(Language.ky);
                  } else {
                    BlocProvider.of<LanguageCubit>(context)
                        .changeLanguage(Language.ru);
                  }
                },
                child: Ink(
                  padding: EdgeInsets.zero,
                  width: 48,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Style.primarySecondColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: SvgPicture.asset('assets/svgs/translate.svg')),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Style.primarySecondColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.lang,
                          style: Style.iconText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
