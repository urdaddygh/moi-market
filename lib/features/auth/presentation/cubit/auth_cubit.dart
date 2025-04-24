import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_market/core/utils/ui_tools.dart';
import 'package:moi_market/features/auth/domain/repositories/auth_repository.dart';
import 'package:moi_market/main.dart';
import 'package:moi_market/routes/app_router.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repos;

  AuthCubit(this.repos, {AuthState? state}) : super(state ?? const AuthState());

  Future<void> tryLogin({required String phone, required String password, required BuildContext context}) async {
    if (state.eventState == AuthEventState.loading) return;
    emit(state.copyWith(eventState: AuthEventState.loading));

    try {
      var message = await GetIt.I.get<AuthRepository>().login(phone, password);

      emit(state.copyWith(message: message));
      if(!context.mounted) return;

      if(message == 'OK') {
        context.goNamed(Routes.main);
      } else {
        UiTools.showSnackBar(context: context, message: 'Что то пошло не так', );
      }
    } catch (e) {
      logger.e(e);
    }

    emit(state.copyWith(eventState: AuthEventState.initial));
  }
}
