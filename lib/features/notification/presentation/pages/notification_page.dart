import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/core/widgets/triple_tab_card.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_state.dart';
import 'package:moi_market/features/notification/presentation/widgets/notification_item_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotificationCubit>(context).loadNotifications(context: context);
    var state = BlocProvider.of<NotificationCubit>(context).state;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (state.commonResponse?.next != null && !state.isLoadingMore) {
          BlocProvider.of<NotificationCubit>(context)
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
    return DefaultCustomWrapper(
      body: Column(
        children: [
          const SizedBox(height: Style.defaultPaddingVertical),
          Expanded(
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                return TripleTabCard(
                  indicatorColor: Style.primarySecondColor,
                  firstTitle: 'Все',
                  secondTitle: 'Прочитанные',
                  thirdTitle: 'Непрочитанные',
                  firstTab: state.eventState == NotificationEventState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : state.notifications == null || state.notifications!.isEmpty
                      ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Пусто', style: Style.mainText),
                          TextButton(
                            onPressed: () =>
                                BlocProvider.of<NotificationCubit>(context)
                                    .loadNotifications(context: context),
                            child: Text(
                              'Обновить',
                              style: Style.buttonText
                                  .copyWith(color: Style.primaryColor),
                            ),
                          )
                        ],
                      ))
                      : RefreshIndicator(
                    onRefresh: () => BlocProvider.of<NotificationCubit>(context)
                        .loadNotifications(context: context),
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemCount: state.notifications!.length +
                          (state.isLoadingMore ? 1 : 0),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        if (index < state.notifications!.length) {
                          return NotificationItemCard(
                            onTap: () =>
                                BlocProvider.of<NotificationCubit>(context)
                                    .setGroup(state.notifications![index]),
                            notification: state.notifications![index],
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
                  secondTab: Container(color: Style.primaryColor),
                  thirdTab: Container(color: Style.primarySecondColor),
                );
              },
            ),
          )
        ],
      ),
      headerTitle: 'Уведомления',
    );
  }
}
