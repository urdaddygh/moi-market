import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moi_market/core/api/api_service_exception_handler.dart';
import 'package:moi_market/core/exceptions/status_code_exception.dart';
import 'package:moi_market/features/referrals/domain/repositories/referrals_repository.dart';
import 'package:moi_market/main.dart';
import 'referrals_state.dart';

class ReferralsCubit extends Cubit<ReferralsState> {
  ReferralsCubit({ReferralsState? state})
      : super(state ?? const ReferralsState());

  Future<void> loadReferrals({required BuildContext context}) async {
    if (state.eventState == ReferralsEventState.loading) {
      return;
    }
    emit(state.copyWith(eventState: ReferralsEventState.loading));

    await ApiServiceExceptionHandler().apiServiceExceptionHandler(
      context: context,
      code: () async {
        final data = await GetIt.I.get<ReferralsRepository>().getReferrals();

        emit(state.copyWith(referrals: data?.results));
      },
    );

    emit(state.copyWith(
      eventState: ReferralsEventState.initial,
    ));
  }

  Future<void> addReferral(
      {required BuildContext context,
      required String name,
      required String phone}) async {
    if (state.eventState == ReferralsEventState.loading) {
      return;
    }
    emit(state.copyWith(eventState: ReferralsEventState.loading));
    try {
      final data = await GetIt.I
          .get<ReferralsRepository>()
          .createReferral(name: name, phone: phone);

      if (data != null) {
        changeScreen(ReferralScreen.successScreen);
      }
    } on StatusCodeException catch (e) {
      changeScreen(ReferralScreen.errorScreen);
      logger.e('ReferralsCubit[StatusCodeException] - $e');
    } catch (e) {
      changeScreen(ReferralScreen.errorScreen);
      logger.e('ReferralsCubit[catch] - $e');
    }

    emit(state.copyWith(
      eventState: ReferralsEventState.initial,
    ));
  }

  void changeScreen(ReferralScreen screen) {
    emit(state.copyWith(referralScreen: screen));
  }

  void flushAllReferralsState () {
    emit(state.copyWith(referrals: null, referralScreen: ReferralScreen.listReferralsScreen));
  }
}
