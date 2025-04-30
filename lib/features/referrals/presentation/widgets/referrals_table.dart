import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/features/referrals/data/models/referral.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ReferralsTable extends StatelessWidget {
  const ReferralsTable({super.key, required this.referrals});

  final List<Referral>? referrals;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (referrals != null) ...[
        _buildHeader(context),
        const SizedBox(height: Style.bigSpacing),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => BlocProvider.of<ReferralsCubit>(context).loadReferrals(context: context),
              child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
                itemCount: referrals!.length,
                itemBuilder: (context, index) {
                  return _buildRow(
                    name: referrals![index].fullName ?? '—',
                    status: referrals![index].approved ?? false,
                  );
                },
              ),
            ),
          ),
        ]
        else
          Center(child: Column(
            children: [
              Text(AppLocalizations.of(context)!.empty, style: Style.mainText,),
              TextButton(
                onPressed: () =>
                    BlocProvider.of<ReferralsCubit>(context)
                        .loadReferrals(context: context),
                child: Text(
                  AppLocalizations.of(context)!.update,
                  style: Style.buttonText
                      .copyWith(color: Style.primaryColor),
                ),
              )
            ],
          ),)
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '${AppLocalizations.of(context)!.listOfParticipants}:',
            style: Style.smallText.copyWith(
              color: Style.primaryBlackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
        Expanded(
          child: Text(
            AppLocalizations.of(context)!.received,
            style: Style.smallText.copyWith(
              color: Style.primaryBlackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow({required String name, required bool status}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
              name,
              style: Style.mainText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: status ? SvgPicture.asset('assets/svgs/checked.svg') : const Text('—'),
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          color: Style.dividerGreyColor,
        )
      ],
    );
  }
}
