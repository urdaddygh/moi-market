import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/features/personal_account/presentation/cubit/personal_account_cubit.dart';

class PersonalAccountPage extends StatelessWidget {
  const PersonalAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultCustomWrapper(
      headerTitle: 'Личный кабинет',
      body: Column(
        children: [
          Spacer(),
          DefaultElevatedButton(text: 'Выйти', onPressed: (){
            BlocProvider.of<PersonalAccountCubit>(context).logout(context);
          })
        ],
      ),
    );
  }
}
