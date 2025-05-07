import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:moi_market/core/api/api_service_exception_handler.dart';
import 'package:moi_market/features/notification/data/models/app_notification.dart';
import 'package:moi_market/features/notification/domain/repositories/notification_repository.dart';
import 'package:moi_market/features/notification/presentation/widgets/notification_detailed.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({NotificationState? state}) : super(state ?? const NotificationState());

  int? extractPageNumber(String? url) {
    if (url == null) return null;

    final uri = Uri.parse(url);
    final page = uri.queryParameters['page'];
    return page != null ? int.tryParse(page) : null;
  }

  Future<void> loadNotifications({required BuildContext context, bool isLoadMore = false}) async {
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
        nextPage = extractPageNumber(state.commonResponse?.next);
        final newNotifications = await GetIt.I.get<NotificationRepository>().getNotifications(limit: 10, page: nextPage ?? 1);
        emit(state.copyWith(commonResponse: newNotifications));

        if (newNotifications.results != null) {
          var results = newNotifications.results!;
          if (isLoadMore && state.notifications != null) {
            final mergedResults = [...state.notifications!, ...results];
            final readResults = [...state.readNotifications!, ...results.where((e) => e.isRead == true)];
            final unreadResults = [...state.unreadNotifications!, ...results.where((e) => e.isRead != true)];
            emit(state.copyWith(
              notifications: mergedResults,
              readNotifications: readResults,
              unreadNotifications: unreadResults,
            ));
          } else {
            emit(
              state.copyWith(
                notifications: results,
                readNotifications: results.where((e) => e.isRead == true).toList(),
                unreadNotifications: results.where((e) => e.isRead != true).toList(),
              ),
            );
          }
        }
      },
    );

    emit(state.copyWith(
      eventState: NotificationEventState.initial,
      isLoadingMore: false,
    ));
  }

void flushAllNotificationState() {
    emit(state.copyWith(
        commonResponse: null,
        notification: null,
        notifications: null,
        readNotifications: null,
        unreadNotifications: null,
      ));
  }

Future<void> loadNotificationById({required int id, required BuildContext context}) async {
  if (state.eventState == NotificationEventState.loading || state.isLoadingMore) {
    return;
  }

  emit(state.copyWith(eventState: NotificationEventState.loading));

  await ApiServiceExceptionHandler().apiServiceExceptionHandler(
    context: context,
    code: () async {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NotificationDetailed(),
        ),
      );
      final rawNotification = await GetIt.I.get<NotificationRepository>().getNotificationById(id: id);

      // Принудительно выставляем флаг isRead = true
      final newNotification = rawNotification.copyWith(isRead: true);

      // Обновляем основной список уведомлений
      final updatedAll = state.notifications?.map((n) {
        return n.id == id ? newNotification : n;
      }).toList();

      // Обновляем прочитанные/непрочитанные
      List<AppNotification> updatedUnread = List.of(state.unreadNotifications ?? [])..removeWhere((n) => n.id == id);
      List<AppNotification> updatedRead = List.of(state.readNotifications ?? [])..add(newNotification);

      emit(state.copyWith(
        notification: newNotification,
        notifications: updatedAll,
        unreadNotifications: updatedUnread,
        readNotifications: updatedRead,
      ));


    },
  );

  emit(state.copyWith(eventState: NotificationEventState.initial));
}
  // void setNotification(AppNotification notification, BuildContext context) {
  //   emit(state.copyWith(notification: notification));
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const NotificationDetailed(),
  //     ),
  //   );
  // }

  void flushNotification() {
    emit(state.copyWith(notification: null));
  }

  Future<void> removeNotification() async {}
}
