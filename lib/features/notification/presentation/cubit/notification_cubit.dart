import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:moi_market/core/api/api_service_exception_handler.dart';
import 'package:moi_market/features/notification/data/models/app_notification.dart';
import 'package:moi_market/features/notification/domain/repositories/notification_repository.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({NotificationState? state}) : super(state ?? const NotificationState());

  int? extractPageNumber(String? url) {
    if (url == null) return null;

    final uri = Uri.parse(url);
    final page = uri.queryParameters['page'];
    return page != null ? int.tryParse(page) : null;
  }


  Future<void> loadNotifications(
      {required BuildContext context, bool isLoadMore = false}) async {
    if (state.eventState == NotificationEventState.loading || state.isLoadingMore) {
      return;
    }
    int? nextPage;
    if (isLoadMore) {
      emit(state.copyWith(isLoadingMore: true));
    } else {
      emit(state.copyWith(eventState: NotificationEventState.loading));
    }

    await ApiServiceExceptionHandler().apiServiceExceptionHandler(
      context: context,
      code: () async {
        final newNotifications = await GetIt.I
            .get<NotificationRepository>()
            .getNotifications(limit: 10, page: nextPage ?? 1);
        emit(state.copyWith(commonResponse: newNotifications));

        nextPage = extractPageNumber(newNotifications.next);
        if (newNotifications.results != null) {
          var reversed = newNotifications.results!.reversed.toList();
          if (isLoadMore && state.notifications != null) {
            final mergedResults = [...state.notifications!, ...reversed];
            emit(state.copyWith(
              notifications: mergedResults,
            ));
          } else {
            emit(state.copyWith(notifications: reversed));
          }
        }
      },
    );

    emit(state.copyWith(
      eventState: NotificationEventState.initial,
      isLoadingMore: false,
    ));
  }

  void setGroup(AppNotification notification) {
    emit(state.copyWith(notification: notification));
  }

  void flushGroup() {
    emit(state.copyWith(notification: null));
  }
}