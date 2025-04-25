import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_market/core/local_storage/local_storage.dart';
import 'package:moi_market/routes/app_router.dart';
import 'personal_account_state.dart';

class PersonalAccountCubit extends Cubit<PersonalAccountState> {
  PersonalAccountCubit({PersonalAccountState? state}) : super(state ?? const PersonalAccountState());

  Future<void> logout(BuildContext context) async {
    await GetIt.I.get<LocalStorage>().flushAccount();
    if(!context.mounted) return;
    context.goNamed(Routes.auth);
  }
}