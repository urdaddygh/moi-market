import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_state.dart';
import 'package:moi_market/features/home/presentation/widgets/first_tab.dart';
import 'package:moi_market/core/widgets/triple_tab_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moi_market/features/home/presentation/widgets/second_tab.dart';
import 'package:moi_market/features/home/presentation/widgets/third_tab.dart';

class AllCardScreen extends StatefulWidget {
  const AllCardScreen({super.key});

  @override
  State<AllCardScreen> createState() => _AllCardScreenState();
}

class _AllCardScreenState extends State<AllCardScreen> {
  @override
  void initState() {
    super.initState();
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
                firstTitle: AppLocalizations.of(context)!.all,
                secondTitle: AppLocalizations.of(context)!.active,
                thirdTitle: AppLocalizations.of(context)!.unActive,
                firstTab: state.eventState == HomeEventState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : state.groups == null || state.groups!.isEmpty
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.empty,
                                  style: Style.mainText),
                              TextButton(
                                onPressed: () =>
                                    BlocProvider.of<HomeCubit>(context)
                                        .loadGroups(context: context),
                                child: Text(
                                  AppLocalizations.of(context)!.update,
                                  style: Style.buttonText
                                      .copyWith(color: Style.primaryColor),
                                ),
                              )
                            ],
                          ))
                        : FirstTab(),
                secondTab: state.eventState == HomeEventState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : state.activeGroups == null || state.activeGroups!.isEmpty
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.empty,
                                  style: Style.mainText),
                              TextButton(
                                onPressed: () =>
                                    BlocProvider.of<HomeCubit>(context)
                                        .loadGroups(
                                            context: context, status: true),
                                child: Text(
                                  AppLocalizations.of(context)!.update,
                                  style: Style.buttonText
                                      .copyWith(color: Style.primaryColor),
                                ),
                              )
                            ],
                          ))
                        : const SecondTab(),
                thirdTab: state.eventState == HomeEventState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : state.unActiveGroups == null ||
                            state.unActiveGroups!.isEmpty
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.empty,
                                  style: Style.mainText),
                              TextButton(
                                onPressed: () =>
                                    BlocProvider.of<HomeCubit>(context)
                                        .loadGroups(
                                            context: context, status: false),
                                child: Text(
                                  AppLocalizations.of(context)!.update,
                                  style: Style.buttonText
                                      .copyWith(color: Style.primaryColor),
                                ),
                              )
                            ],
                          ))
                        : const ThirdTab(),
              );
            },
          ),
        ),
      ],
    );
  }
}
