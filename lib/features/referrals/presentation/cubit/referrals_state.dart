import 'package:freezed_annotation/freezed_annotation.dart';

part 'referrals_state.freezed.dart';

enum ReferralsEventState {
  initial,
  loading,
  error,
  success,
}

@freezed
class ReferralsState with _$ReferralsState {
  const factory ReferralsState({
    @Default(ReferralsEventState.initial) ReferralsEventState eventState,
    String? message,
  }) = _Initial;
}