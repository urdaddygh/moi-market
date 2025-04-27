import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:moi_market/core/api/api_service_exception_handler.dart';
import 'package:moi_market/features/home/data/models/group.dart';
import 'package:moi_market/features/home/domain/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({HomeState? state}) : super(state ?? const HomeState());

  int? extractPageNumber(String? url) {
    if (url == null) return null;

    final uri = Uri.parse(url);
    final page = uri.queryParameters['page'];
    return page != null ? int.tryParse(page) : null;
  }

  Future<void> loadGroups(
      {required BuildContext context, bool isLoadMore = false}) async {
    if (state.eventState == HomeEventState.loading || state.isLoadingMore) {
      return;
    }
    int? nextPage;
    if (isLoadMore) {
      emit(state.copyWith(isLoadingMore: true));
    } else {
      emit(state.copyWith(eventState: HomeEventState.loading));
    }

    await ApiServiceExceptionHandler().apiServiceExceptionHandler(
      context: context,
      code: () async {
        final newGroups = await GetIt.I
            .get<HomeRepository>()
            .getGroups(limit: 10, page: nextPage ?? 1);
        emit(state.copyWith(commonResponse: newGroups));

        nextPage = extractPageNumber(newGroups.next);
        if (newGroups.results != null) {
          var reversed = newGroups.results!.reversed.toList();
          if (isLoadMore && state.groups != null) {
            final mergedResults = [...state.groups!, ...reversed];
            emit(state.copyWith(
              groups: mergedResults,
            ));
          } else {
            emit(state.copyWith(groups: reversed));
          }
        }
      },
    );

    emit(state.copyWith(
      eventState: HomeEventState.initial,
      isLoadingMore: false,
    ));
  }

  void setGroup(Group group) {
    emit(state.copyWith(group: group));
  }
  
  void flushGroup() {
    emit(state.copyWith(group: null));
  }
}
