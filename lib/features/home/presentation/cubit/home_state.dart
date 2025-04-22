import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

enum HomeEventState {
  initial,
  loading,
  error,
  success,
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeEventState.initial) HomeEventState eventState,
    String? message,
  }) = _Initial;
}