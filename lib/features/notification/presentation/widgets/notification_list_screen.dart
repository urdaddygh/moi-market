import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/triple_tab_card.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_state.dart';
import 'package:moi_market/features/notification/presentation/widgets/notification_item_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    var notificationCubit = BlocProvider.of<NotificationCubit>(context);
    notificationCubit
        .loadNotifications(context: context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (notificationCubit.state.commonResponse?.next != null && !notificationCubit.state.isLoadingMore) {
          notificationCubit
              .loadNotifications(context: context, isLoadMore: true);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Style.defaultPaddingVertical),
        Expanded(
          child: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              return TripleTabCard(
                indicatorColor: Style.primarySecondColor,
                firstTitle: AppLocalizations.of(context)!.all,
                secondTitle: AppLocalizations.of(context)!.read,
                thirdTitle: AppLocalizations.of(context)!.unread,
                firstTab: state.eventState == NotificationEventState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : state.notifications == null ||
                            state.notifications!.isEmpty
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.empty, style: Style.mainText),
                              TextButton(
                                onPressed: () =>
                                    BlocProvider.of<NotificationCubit>(context)
                                        .loadNotifications(context: context),
                                child: Text(
                                  AppLocalizations.of(context)!.update,
                                  style: Style.buttonText
                                      .copyWith(color: Style.primaryColor),
                                ),
                              )
                            ],
                          ))
                        : RefreshIndicator(
                            onRefresh: () async {
                              BlocProvider.of<NotificationCubit>(context)
                                  .flushAllNotificationState();
                              await BlocProvider.of<NotificationCubit>(context)
                                  .loadNotifications(context: context);
                            },
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _scrollController,
                              itemCount: state.notifications!.length +
                                  (state.isLoadingMore ? 1 : 0),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                if (index < state.notifications!.length) {
                                  return NotificationItemCard(
                                    notification: state.notifications![index],
                                    onTap: () =>
                                        BlocProvider.of<NotificationCubit>(
                                                context)
                                            .loadNotificationById(id: state.notifications![index].id ?? 0, context: context),
                                  );
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }
                              },
                            ),
                          ),
                secondTab: state.eventState == NotificationEventState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : state.readNotifications == null ||
                    state.readNotifications!.isEmpty
                    ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.empty, style: Style.mainText),
                        TextButton(
                          onPressed: () =>
                              BlocProvider.of<NotificationCubit>(context)
                                  .loadNotifications(context: context),
                          child: Text(
                            AppLocalizations.of(context)!.update,
                            style: Style.buttonText
                                .copyWith(color: Style.primaryColor),
                          ),
                        )
                      ],
                    ))
                    : RefreshIndicator(
                  onRefresh: () =>
                      BlocProvider.of<NotificationCubit>(context)
                          .loadNotifications(context: context),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount: state.readNotifications!.length +
                        (state.isLoadingMore ? 1 : 0),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (index < state.readNotifications!.length) {
                        return NotificationItemCard(
                                    notification: state.readNotifications![index],
                          onTap: () =>
                              BlocProvider.of<NotificationCubit>(
                                  context)
                                  .loadNotificationById(id: state.readNotifications![index].id ?? 0, context: context),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                              child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                ),
                thirdTab: state.eventState == NotificationEventState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : state.unreadNotifications == null ||
                    state.unreadNotifications!.isEmpty
                    ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.empty, style: Style.mainText),
                        TextButton(
                          onPressed: () =>
                              BlocProvider.of<NotificationCubit>(context)
                                  .loadNotifications(context: context),
                          child: Text(
                            AppLocalizations.of(context)!.update,
                            style: Style.buttonText
                                .copyWith(color: Style.primaryColor),
                          ),
                        )
                      ],
                    ))
                    : RefreshIndicator(
                  onRefresh: () =>
                      BlocProvider.of<NotificationCubit>(context)
                          .loadNotifications(context: context),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount: state.unreadNotifications!.length +
                        (state.isLoadingMore ? 1 : 0),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (index < state.unreadNotifications!.length) {
                        return NotificationItemCard(
                                    notification: state.unreadNotifications![index],
                          onTap: () =>
                              BlocProvider.of<NotificationCubit>(
                                  context)
                                  .loadNotificationById(id: state.unreadNotifications![index].id ?? 0, context: context)
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                              child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
