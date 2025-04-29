import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moi_market/core/api/api_service_exception_handler.dart';
import 'package:moi_market/core/utils/ui_tools.dart';
import 'package:moi_market/features/home/data/models/group.dart';
import 'package:moi_market/features/home/domain/repositories/home_repository.dart';
import 'package:moi_market/main.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({HomeState? state}) : super(state ?? const HomeState());

  int? extractPageNumber(String? url) {
    if (url == null) return null;

    final uri = Uri.parse(url);
    final page = uri.queryParameters['page'];
    return page != null ? int.tryParse(page) : null;
  }

  Future<void> choosePhoto(BuildContext context, ImageSource source) async {
    ImagePicker picker = ImagePicker();
    try {
        final attachment = await picker.pickImage(
          source: source,
          preferredCameraDevice: CameraDevice.rear,
        );
        if (attachment == null) return;
        emit(state.copyWith(attachment: attachment));

    } catch (e) {
      if (!context.mounted) return;
      UiTools.showSnackBar(context: context, message: 'Произошла непредвиденная ошибка');
      logger.e('Error choosing file: $e');
    }
  }

  Future<void> loadGroups(
      {required BuildContext context, bool isLoadMore = false, bool? status}) async {
    if (state.eventState == HomeEventState.loading || state.isLoadingMore) {
      return;
    }
    if (isLoadMore) {
      emit(state.copyWith(isLoadingMore: true));
    } else {
      emit(state.copyWith(eventState: HomeEventState.loading));
    }

    await ApiServiceExceptionHandler().apiServiceExceptionHandler(
      context: context,
      code: () async {
        if (status == null) {
          int? nextPage;
          final newGroups = await GetIt.I.get<HomeRepository>().getGroups(
                limit: 10,
                page: nextPage ?? 1,
              );
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
        }

        if (status!) {
          int? nextPage;
          final newGroups = await GetIt.I.get<HomeRepository>().getGroups(
                limit: 10,
                page: nextPage ?? 1,
                status: 'active'
              );
          emit(state.copyWith(activeStatusCommonResponse: newGroups));

          nextPage = extractPageNumber(newGroups.next);
          if (newGroups.results != null) {
            var reversed = newGroups.results!.reversed.toList();
            if (isLoadMore && state.activeGroups != null) {
              final mergedResults = [...state.activeGroups!, ...reversed];
              emit(state.copyWith(
                activeGroups: mergedResults,
              ));
            } else {
              emit(state.copyWith(activeGroups: reversed));
            }
          }
        } else {
           int? nextPage;
          final newGroups = await GetIt.I.get<HomeRepository>().getGroups(
                limit: 10,
                page: nextPage ?? 1,
                status: 'pending'
              );
          emit(state.copyWith(unActiveStatusCommonResponse: newGroups));

          nextPage = extractPageNumber(newGroups.next);
          if (newGroups.results != null) {
            var reversed = newGroups.results!.reversed.toList();
            if (isLoadMore && state.unActiveGroups != null) {
              final mergedResults = [...state.unActiveGroups!, ...reversed];
              emit(state.copyWith(
                unActiveGroups: mergedResults,
              ));
            } else {
              emit(state.copyWith(unActiveGroups: reversed));
            }
          }
        }
      },
    );

    emit(state.copyWith(
      eventState: HomeEventState.initial,
      isLoadingMore: false,
    ));
  }

  Future<void> addReceipt(
      {required BuildContext context, required int ticket, required int schedule}) async {
    if (state.eventState == HomeEventState.loading) {
      return;
    }
    emit(state.copyWith(eventState: HomeEventState.loading));

    await ApiServiceExceptionHandler().apiServiceExceptionHandler(
      context: context,
      code: () async {
        if (state.attachment != null) {
          UiTools.showSnackBar(context: context, message: AppLocalizations.of(context)!.messagePhotoEmpty);
        }
        final data = await GetIt.I
            .get<HomeRepository>()
            .addReceipt(ticket: ticket, schedule: schedule, cheque: File(state.attachment!.path));

        if (data != null) {
          UiTools.showSnackBar(context: context, message: 'ДА');
        }
      },
    );

    emit(state.copyWith(
      eventState: HomeEventState.initial,
    ));
  }


  void setGroup(Group group) {
    emit(state.copyWith(group: group));
  }
  
  void flushGroup() {
    emit(state.copyWith(group: null));
  }
  void flushAttachment() {
    emit(state.copyWith(attachment: null));
  }
}
