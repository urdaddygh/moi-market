import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/features/home/presentation/widgets/show_photo_dialog.dart';

class PaymentScheduleTable extends StatelessWidget {
  const PaymentScheduleTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeader(),
        const SizedBox(height: Style.bigSpacing),
        _buildRow(
          context: context,
          paymentDate: '15 февраля 2025 г.',
          status: 'Оплачено',
          check: 'sa',
        ),
        _buildRow(
          paymentDate: '15 февраля 2025 г.',
          context: context,
          status: 'Не оплачено',
          // check: 'sa',
        ),
        _buildRow(paymentDate: '15 февраля 2025 г.', context: context, status: 'Оплачено', check: '2'),
        _buildRow(
          context: context,
          paymentDate: '15 февраля 2025 г.',
          status: 'Не оплачено',
          // check: '2'
        ),
        _buildRow(context: context, paymentDate: '15 февраля 2025 г.', status: 'Оплачено', check: '2'),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'График оплаты:',
            style: Style.smallText.copyWith(
              color: Style.primaryBlackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Статус оплаты:',
            style: Style.smallText.copyWith(
              color: Style.primaryBlackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Чек об оплате:',
            style: Style.smallText.copyWith(
              color: Style.primaryBlackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow({required String paymentDate, required String status, String? check, required BuildContext context}) {
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
                  paymentDate,
                  style: Style.mainText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
            Expanded(
                flex: 2,
                child: Text(
                  status,
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
                        child: const Center(
                          child: Text('Добавить чек', style: Style.iconText),
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
