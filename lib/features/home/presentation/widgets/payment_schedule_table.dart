import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/features/home/data/models/schedule.dart';
import 'package:moi_market/features/home/presentation/widgets/show_photo_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class PaymentScheduleTable extends StatelessWidget {
  const PaymentScheduleTable({super.key, required this.schedules});
  final List<Schedule>? schedules;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeader(context),
        const SizedBox(height: Style.bigSpacing),
        if(schedules != null)
        ...schedules!.map((e) => _buildRow(paymentDate: e.dueDate, status: e.paymentInfo?.isApproved ?? false, check: e.paymentInfo?.cheque, context: context),)
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '${AppLocalizations.of(context)!.paymentSchedule}:',
            style: Style.smallText.copyWith(
              color: Style.primaryBlackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '${AppLocalizations.of(context)!.payStatus}:',
            style: Style.smallText.copyWith(
              color: Style.primaryBlackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '${AppLocalizations.of(context)!.paymentReceipt}:',
            style: Style.smallText.copyWith(
              color: Style.primaryBlackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow({required DateTime? paymentDate, required bool status, String? check, required BuildContext context}) {
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
                flex: 3,
                child: Text(
                    paymentDate!=null?
                 Style.defaultDateFormat.format(paymentDate) : '-',
                  style: Style.mainText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
            Expanded(
                flex: 2,
                child: Text(
                  status ? AppLocalizations.of(context)!.paid : AppLocalizations.of(context)!.notPaid,
                  style: Style.mainText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
            Expanded(
              flex: 2,
              child: check != null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => showDialog(context: context, builder: (context) => const ShowPhotoDialog()),
                        child: SvgPicture.asset('assets/svgs/eye.svg'),
                      ),
                    )
                  : SizedBox(
                      height: 26,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context, builder: (context) => const ShowPhotoDialog(), barrierColor: Colors.transparent);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Style.primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        child: Center(
                          child: Text(AppLocalizations.of(context)!.addReceipt, style: Style.iconText),
                        ),
                      ),
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
