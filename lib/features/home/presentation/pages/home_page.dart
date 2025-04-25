import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';
import 'package:moi_market/features/home/presentation/widgets/item_card.dart';
import 'package:moi_market/features/home/presentation/widgets/requisites_wrapper.dart';
import 'package:moi_market/features/home/presentation/widgets/triple_tab_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).loadGroups(context: context);
    var state = BlocProvider.of<HomeCubit>(context).state;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        if (state.commonResponse?.next != null && !state.isLoadingMore) {
          BlocProvider.of<HomeCubit>(context).loadGroups(context: context);
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
        headerTitle: 'Мои группы',
        body: Column(
          children: [
            const SizedBox(height: Style.bigSpacing),
            const RequisitesWrapper(
              phone: '+996 500 500 500',
            ),
            const SizedBox(height: Style.bigSpacing),
            Expanded(
              /// 🔧 ОБЯЗАТЕЛЬНО! Даёт ограничение по высоте
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return RentTripleTab(
                    firstTitle: 'Все',
                    secondTitle: 'Активные',
                    thirdTitle: 'Неактивные',
                    firstTab: state.groups == null || state.groups!.isEmpty
                        ? const Center(child: Text('Пусто', style: Style.mainText))
                        : ListView.builder(
                      controller: _scrollController,
                      itemCount: state.groups!.length + (state.isLoadingMore ? 1 : 0),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        if (index < state.groups!.length) {
                          return ItemCard();
                        } else {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    ),
                    secondTab: Container(color: Style.primarySecondColor),
                    thirdTab: Container(color: Style.primarySecondColor),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
