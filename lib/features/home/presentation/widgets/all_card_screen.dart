import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';
import 'package:moi_market/features/home/presentation/widgets/item_card.dart';
import 'package:moi_market/core/widgets/triple_tab_card.dart';

class AllCardScreen extends StatefulWidget {
  const AllCardScreen({super.key});

  @override
  State<AllCardScreen> createState() => _AllCardScreenState();
}

class _AllCardScreenState extends State<AllCardScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).loadGroups(context: context);
    var state = BlocProvider.of<HomeCubit>(context).state;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (state.commonResponse?.next != null && !state.isLoadingMore) {
          BlocProvider.of<HomeCubit>(context)
              .loadGroups(context: context, isLoadMore: true);
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
        const SizedBox(height: Style.bigSpacing),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return TripleTabCard(
                indicatorColor: Style.primaryColor,
                firstTitle: 'Все',
                secondTitle: 'Активные',
                thirdTitle: 'Неактивные',
                firstTab: state.eventState == HomeEventState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : state.groups == null || state.groups!.isEmpty
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Пусто', style: Style.mainText),
                              TextButton(
                                onPressed: () =>
                                    BlocProvider.of<HomeCubit>(context)
                                        .loadGroups(context: context),
                                child: Text(
                                  'Обновить',
                                  style: Style.buttonText
                                      .copyWith(color: Style.primaryColor),
                                ),
                              )
                            ],
                          ))
                        : RefreshIndicator(
                            onRefresh: () => BlocProvider.of<HomeCubit>(context)
                                .loadGroups(context: context),
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _scrollController,
                              itemCount: state.groups!.length +
                                  (state.isLoadingMore ? 1 : 0),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                if (index < state.groups!.length) {
                                  return ItemCard(
                                    onTap: () =>
                                        BlocProvider.of<HomeCubit>(context)
                                            .setGroup(state.groups![index]),
                                    group: state.groups![index],
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
                secondTab: Container(color: Style.primarySecondColor),
                thirdTab: Container(color: Style.primarySecondColor),
              );
            },
          ),
        ),
      ],
    );
  }
}
