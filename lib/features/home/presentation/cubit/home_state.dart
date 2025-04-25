import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moi_market/features/home/data/models/group.dart';
import 'package:moi_market/features/home/data/models/groups_common_response.dart';

part 'home_state.freezed.dart';

enum HomeEventState {
  initial,
  loading,
  error,
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeEventState.initial) HomeEventState eventState,
    @Default(null) List<Group>? groups,
    @Default(null) GroupsCommonResponse? commonResponse,
    @Default(false) bool isLoadingMore,
    String? message,
  }) = _Initial;
}