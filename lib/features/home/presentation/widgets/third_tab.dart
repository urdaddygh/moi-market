import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';
import 'package:moi_market/features/home/presentation/widgets/item_card.dart';

class ThirdTab extends StatefulWidget {
  const ThirdTab({super.key});

  @override
  State<ThirdTab> createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
      final homeCubit = BlocProvider.of<HomeCubit>(context);
  if (homeCubit.state.unActiveGroups == null || homeCubit.state.unActiveGroups!.isEmpty) {
    homeCubit.loadGroups(context: context, status: false);
  }
    _scrollController.addListener(() {
    final state = homeCubit.state;
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (state.unActiveStatusCommonResponse?.next != null && !state.isLoadingMore) {
          homeCubit
              .loadGroups(context: context, isLoadMore: true, status: false);
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () =>
              BlocProvider.of<HomeCubit>(context).loadGroups(context: context, status: false),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: state.unActiveGroups!.length + (state.isLoadingMore ? 1 : 0),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              if (index < state.unActiveGroups!.length) {
                return ItemCard(
                  onTap: () => BlocProvider.of<HomeCubit>(context)
                      .setGroup(state.unActiveGroups![index]),
                  group: state.unActiveGroups![index],
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        );
      },
    );
  }
}
