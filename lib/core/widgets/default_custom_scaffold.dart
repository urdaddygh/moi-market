import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/routes/app_router.dart';

class DefaultCustomScaffold extends StatelessWidget {
  const DefaultCustomScaffold({
    super.key,
    required this.navigationShell,
    this.backgroundColor,
  });

  final StatefulNavigationShell navigationShell;
  final Color? backgroundColor;

  static final List<String> _tabs = [
    Routes.home,
    Routes.referrals,
    Routes.personalAccount,
    Routes.notification,
  ];

  int _calculateCurrentIndex(String location) {
    final index = _tabs.indexWhere((path) => location.startsWith('/$path'));
    return index >= 0 ? index : 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _calculateCurrentIndex(location);

    return Scaffold(
      backgroundColor: backgroundColor ?? Style.primaryWhiteColor,
      body: navigationShell,
      bottomNavigationBar: SizedBox(
        height: 69,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _onItemTapped(index, context),
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Style.primaryColor,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(fontSize: 0),
          unselectedLabelStyle: const TextStyle(fontSize: 0),
          items: [
            _buildNavItem(Icons.home, currentIndex == 0),
            _buildNavItem(Icons.search, currentIndex == 1),
            _buildNavItem(Icons.person, currentIndex == 2),
            _buildNavItemWithBadge(Icons.notifications, currentIndex == 3),
          ],
        ),
      ),
    );
  }

  // Widget _buildCurrentBranch() {
  //   return IndexedStack(
  //     index: navigationShell.currentIndex,
  //     children: navigationShell.branches.map((branch) {
  //       return Navigator(
  //         key: branch.navigatorKey,
  //         onGenerateRoute: (settings) => MaterialPageRoute(
  //           builder: (context) => Container(), // Заглушка
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  void _onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, bool isActive) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 48,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? const Color(0x22165414) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 24, color: isActive ? Style.primaryColor : Colors.black),
      ),
      label: '',
    );
  }

  BottomNavigationBarItem _buildNavItemWithBadge(IconData icon, bool isActive) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildNavItem(icon, isActive).icon!,
          Positioned(
            top: -4,
            right: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}