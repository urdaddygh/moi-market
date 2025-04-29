import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_alert_dialog.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/features/home/presentation/pages/home_page.dart';
import 'package:moi_market/features/notification/presentation/pages/notification_page.dart';
import 'package:moi_market/features/personal_account/presentation/pages/personal_account_page.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_cubit.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_state.dart';
import 'package:moi_market/features/referrals/presentation/pages/referrals_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class RouterScreen extends StatefulWidget {
  const RouterScreen({super.key});

  @override
  State<RouterScreen> createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = const [
      HomePage(),
      ReferralsPage(),
      PersonalAccountPage(),
      NotificationPage(),
    ];
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }

          var state = BlocProvider.of<ReferralsCubit>(context).state;
          if (state.referralScreen == ReferralScreen.addReferralScreen ||
              state.referralScreen == ReferralScreen.successScreen ||
              state.referralScreen == ReferralScreen.errorScreen) {
            return;
          }

          showDialog(
            context: context,
            builder: (context) => DefaultAlertDialog(
                title:  Text(AppLocalizations.of(context)!.areYouSure, textAlign: TextAlign.center, maxLines: 1, style: Style.titleText,),
                content:  Text(AppLocalizations.of(context)!.messageYouWantToCloseApp, textAlign: TextAlign.center,style: Style.bigText,),
                actions: [
                  Expanded(
                    child: DefaultElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.maybePop(context);
                      },
                      text: AppLocalizations.of(context)!.yes,
                      color: Style.primarySecondColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: DefaultElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: AppLocalizations.of(context)!.no,
                      color: Style.primaryWhiteColor,
                      textColor: Style.primaryColor,
                      side: const BorderSide(width: 1.5, color: Style.primaryColor),
                    ),
                  )
                ]
            ),
          );
        },
        child: Scaffold(
          backgroundColor: Style.primaryWhiteColor,
          extendBody: true,
          body: SafeArea(
            top: false,
            bottom: false,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentIndex,
              builder: (context, index, _) {
                return IndexedStack(
                  index: index,
                  children: _screens,
                );
              },
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, currentIndex, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Style.defaultSpacing),
          child: Container(
            margin: const EdgeInsets.only(bottom: Style.bigSpacing),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x24B4B4B4),
                  offset: Offset(0, 0),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) => _currentIndex.value = index,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Style.primaryColor,
                unselectedItemColor: Colors.black,
                selectedLabelStyle: const TextStyle(fontSize: 0),
                unselectedLabelStyle: const TextStyle(fontSize: 0),
                items: [
                  _buildNavItem(
                    svgPath: currentIndex == 0 ? 'assets/svgs/active_home_icon.svg' : 'assets/svgs/home_icon.svg',
                    isActive: currentIndex == 0,
                  ),
                  _buildNavItem(
                    svgPath: currentIndex == 1 ? 'assets/svgs/active_referral_icon.svg' : 'assets/svgs/referral_icon.svg',
                    isActive: currentIndex == 1,
                  ),
                  _buildNavItem(
                    svgPath: currentIndex == 2
                        ? 'assets/svgs/active_personal_account_icon.svg'
                        : 'assets/svgs/personal_account_icon.svg',
                    isActive: currentIndex == 2,
                  ),
                  _buildNavItemWithBadge(
                    isActive: currentIndex == 3,
                    notifications: '25',
                    icon: Icons.notifications_none,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildNavItem({IconData? icon, String? svgPath, required bool isActive}) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 48,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Style.primaryColor.withValues(alpha: 0.08) : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: svgPath != null
            ? SvgPicture.asset(svgPath)
            : Icon(
                icon,
                size: 24,
                color: isActive ? Style.primaryColor : Style.hintTextColor,
              ),
      ),
      label: '',
    );
  }

  BottomNavigationBarItem _buildNavItemWithBadge(
      {IconData? icon, String? svgPath, required bool isActive, String? notifications}) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Container(
              padding: EdgeInsets.zero,
              width: 48,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isActive ? Style.primarySecondColor.withValues(alpha: 0.08) : const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: svgPath != null
                        ? SvgPicture.asset(svgPath)
                        : Icon(
                            icon,
                            size: 24,
                            color: isActive ? Style.primarySecondColor : Style.hintTextColor,
                          ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isActive ? Style.primarySecondColor : Style.hintTextColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: Text(
                      '$notifications увед.',
                      style: Style.iconText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ))
        ],
      ),
      label: '',
    );
  }
}
