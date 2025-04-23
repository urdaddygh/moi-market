import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

enum AuthEventState {
  initial,
  loading,
  error
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthEventState.initial) AuthEventState eventState,
    String? message,
  }) = _Initial;
}