import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moi_market/features/personal_account/data/models/client.dart';

part 'personal_account_state.freezed.dart';

enum PersonalAccountEventState {
  initial,
  loading,
  error,
}

@freezed
class PersonalAccountState with _$PersonalAccountState {
  const factory PersonalAccountState({
    @Default(PersonalAccountEventState.initial) PersonalAccountEventState eventState,
    @Default(null) Client? userInfo,
    String? message,
  }) = _Initial;
}