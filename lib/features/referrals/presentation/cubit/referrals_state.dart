import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moi_market/features/referrals/data/models/referral.dart';

part 'referrals_state.freezed.dart';

enum ReferralsEventState {
  initial,
  loading,
  error,
}

enum ReferralScreen {
  listReferralsScreen,
  addReferralScreen,
  errorScreen,
  successScreen,
}

@freezed
class ReferralsState with _$ReferralsState {
  const factory ReferralsState({
    @Default(ReferralsEventState.initial) ReferralsEventState eventState,
    @Default(ReferralScreen.listReferralsScreen) ReferralScreen referralScreen,
    @Default(null) List<Referral>? referrals,
    String? message,
  }) = _Initial;
}