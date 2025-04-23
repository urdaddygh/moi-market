import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:moi_market/features/auth/domain/repositories/auth_repository.dart';
import 'package:moi_market/main.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repos;

  AuthCubit(this.repos, {AuthState? state}) : super(state ?? const AuthState());

  Future<void> tryLogin({required String phone, required String password}) async {
    if (state.eventState == AuthEventState.loading) return;
    emit(state.copyWith(eventState: AuthEventState.loading));

    try {
      var message = await GetIt.I.get<AuthRepository>().login(phone, password);
      Timer.periodic(
        const Duration(seconds: 3),
        (timer) {
          emit(state.copyWith(message: message));
        },
      );
    } catch (e) {
      logger.e(e);
    }

    emit(state.copyWith(eventState: AuthEventState.initial));
  }
}
