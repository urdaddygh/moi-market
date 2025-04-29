import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/features/home/data/models/ticket.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ParticipantsTable extends StatelessWidget {
  const ParticipantsTable({super.key, required this.tickets});

  final List<Ticket>? tickets;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeader(context),
        const SizedBox(height: Style.bigSpacing),
        if(tickets!=null)  
        ...tickets!.map((e) => _buildRow(
          name: e.client?.user?.fullName ?? '—',
          status: e.received ?? false,
        ))
        ,
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
