import 'package:freezed_annotation/freezed_annotation.dart';

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
    String? message,
  }) = _Initial;
}