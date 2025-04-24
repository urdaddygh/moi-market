import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/features/home/presentation/pages/home_page.dart';
import 'package:moi_market/features/notification/presentation/pages/notification_page.dart';
import 'package:moi_market/features/personal_account/presentation/pages/personal_account_page.dart';
import 'package:moi_market/features/referrals/presentation/pages/referrals_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
    );
  }

  Widget _buildBottomNavigationBar() {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, currentIndex, _) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
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
                _buildNavItem(Icons.home, currentIndex == 0),
                _buildNavItem(Icons.search, currentIndex == 1),
                _buildNavItem(Icons.person, currentIndex == 2),
                _buildNavItemWithBadge(Icons.notifications, currentIndex == 3),
              ],
            ),
          ),
        );
      },
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
        child: Icon(
          icon,
          size: 24,
          color: isActive ? Style.primaryColor : Colors.black,
        ),
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