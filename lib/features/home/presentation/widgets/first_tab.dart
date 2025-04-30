import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';
import 'package:moi_market/features/home/presentation/widgets/item_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({super.key});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    if (homeCubit.state.groups == null) {
      homeCubit.loadGroups(context: context);
    }
    _scrollController.addListener(() {
      final state = homeCubit.state;
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        if (state.commonResponse?.next != null && !state.isLoadingMore) {
          homeCubit.loadGroups(context: context, isLoadMore: true);
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
        if (state.groups == null || state.groups!.isEmpty) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.empty, style: Style.mainText),
              TextButton(
                onPressed: () => BlocProvider.of<HomeCubit>(context).loadGroups(context: context),
                child: Text(
                  AppLocalizations.of(context)!.update,
                  style: Style.buttonText.copyWith(color: Style.primaryColor),
                ),
              )
            ],
          ));
        }
        return RefreshIndicator(
          onRefresh: () => BlocProvider.of<HomeCubit>(context).loadGroups(context: context),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: state.groups!.length + (state.isLoadingMore ? 1 : 0),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              if (index < state.groups!.length) {
                return ItemCard(
                  onTap: () => BlocProvider.of<HomeCubit>(context).setGroup(state.groups![index]),
                  group: state.groups![index],
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
