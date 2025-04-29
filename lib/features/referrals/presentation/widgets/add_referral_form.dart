import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/utils/text_field_validators.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/core/widgets/default_text_form_field.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_cubit.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddReferralForm extends StatefulWidget {
  const AddReferralForm({super.key});

  @override
  State<AddReferralForm> createState() => _AddReferralFormState();
}

class _AddReferralFormState extends State<AddReferralForm> {
  final TextEditingController _nameController = TextEditingController(text: '');
  final TextEditingController _phoneController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (!didPop) {
          BlocProvider.of<ReferralsCubit>(context).changeScreen(ReferralScreen.listReferralsScreen);
          return;
        }
      },
      child: DefaultCustomWrapper(
        headerTitle: AppLocalizations.of(context)!.referrals,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Style.defaultPaddingVertical),
            Text(AppLocalizations.of(context)!.addReferral, style: Style.bigText),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.addReferralFillingInTheirDetails,
              style: Style.mainText,
            ),
            const SizedBox(height: Style.bigSpacing),
            Form(
                key: _formKey,
                child: Expanded(
                  child: Column(
                    children: [
                      DefaultTextFormField(
                        hintText: AppLocalizations.of(context)!.fioReferral,
                        controller: _nameController,
                        validator: TextFieldValidators.cantBeEmptyValidator(context: context),
                      ),
                      const SizedBox(height: 10),
                      DefaultTextFormField(
                        hintText: AppLocalizations.of(context)!.phoneNumberReferral,
                        validator: TextFieldValidators.cantBeEmptyValidator(context: context),
                        controller: _phoneController,
                      ),
                      const Spacer(),
                      DefaultElevatedButton(
                        text: AppLocalizations.of(context)!.addReferral,
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await BlocProvider.of<ReferralsCubit>(context).addReferral(
                              context: context,
                              name: _nameController.text,
                              phone: _phoneController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: Style.defaultPaddingVertical),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
