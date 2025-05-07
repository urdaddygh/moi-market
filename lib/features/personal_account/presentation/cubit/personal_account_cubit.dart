import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_market/core/api/api_service_exception_handler.dart';
import 'package:moi_market/core/local_storage/local_storage.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:moi_market/features/personal_account/domain/repositories/personal_account_repository.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_cubit.dart';
import 'package:moi_market/routes/app_router.dart';
import 'personal_account_state.dart';

class PersonalAccountCubit extends Cubit<PersonalAccountState> {
  PersonalAccountCubit({PersonalAccountState? state}) : super(state ?? const PersonalAccountState());


    Future<void> loadUserInfo({required BuildContext context}) async {
    if (state.eventState == PersonalAccountEventState.loading) {
      return;
    }
    emit(state.copyWith(eventState: PersonalAccountEventState.loading));

    await ApiServiceExceptionHandler().apiServiceExceptionHandler(
      context: context,
      code: () async {
        final data = await GetIt.I.get<PersonalAccountRepository>().getUserInfo();

        emit(state.copyWith(userInfo: data));
      },
    );

    emit(state.copyWith(
      eventState: PersonalAccountEventState.initial,
    ));
  }

  void flushAllPersonalState () {
    emit(state.copyWith(userInfo: null));
  }

  Future<void> logout(BuildContext context) async {
    await GetIt.I.get<LocalStorage>().flushAccount();
    if(!context.mounted) return;
    BlocProvider.of<HomeCubit>(context).flushAllGroupState();
    BlocProvider.of<ReferralsCubit>(context).flushAllReferralsState();
    BlocProvider.of<NotificationCubit>(context).flushAllNotificationState();
    flushAllPersonalState();
    context.goNamed(Routes.auth);
  }
  
}