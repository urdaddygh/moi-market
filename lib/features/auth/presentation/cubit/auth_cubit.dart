import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_market/core/api/api_service_exception_handler.dart';
import 'package:moi_market/core/local_storage/local_storage.dart';
import 'package:moi_market/di/register_api_service.dart';
import 'package:moi_market/features/auth/domain/repositories/auth_repository.dart';
import 'package:moi_market/routes/app_router.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repos;

  AuthCubit(this.repos, {AuthState? state}) : super(state ?? const AuthState());

  Future<void> tryLogin(
      {required String phone,
      required String password,
      required BuildContext context}) async {
    if (state.eventState == AuthEventState.loading) return;
    emit(state.copyWith(eventState: AuthEventState.loading));

    await ApiServiceExceptionHandler().apiServiceExceptionHandler(
      context: context,
      code: () async {
        var res = await GetIt.I.get<AuthRepository>().login(phone, password);

        if (!context.mounted) return;

        await GetIt.I.get<LocalStorage>().writeAccount(res);

        if (!context.mounted) return;
        registerApiServiceDi(token: res.access);
        context.goNamed(Routes.main);
      },
    );

    emit(state.copyWith(eventState: AuthEventState.initial));
  }
}
