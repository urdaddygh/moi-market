import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_market/features/auth/presentation/pages/auth_page.dart';
import 'package:moi_market/features/router_screen/router_screen.dart';

class Routes {
  static const auth = 'auth';
  static const main = 'main';
  // static const home = 'home';
  // static const referrals = 'referrals';
  // static const personalAccount = 'personalAccount';
  // static const notification = 'notification';

  static void initRouter({String initialRoute = Routes.auth}) {
    GetIt.I.registerSingleton<GoRouter>(
      GoRouter(
        initialLocation: initialRoute == Routes.main ? '/' : '/$initialRoute',
        routes: [
          GoRoute(path: '/$auth', name: auth, builder: (context, state) => const AuthPage()),
          GoRoute(path: '/', name: main, builder: (context, state) => const RouterScreen()),
          // StatefulShellRoute(
          //   builder: (context, state, navigationShell) {
          //     return DefaultCustomScaffold(navigationShell: navigationShell);
          //   },
          //   branches: [
          //     StatefulShellBranch(
          //       routes: [GoRoute(path: '/', name: home, builder: (context, state) => const HomePage())],
          //     ),
          //     StatefulShellBranch(
          //       routes: [GoRoute(path: '/$referrals', name: referrals, builder: (context, state) => const ReferralsPage())],
          //     ),
          //     StatefulShellBranch(
          //       routes: [
          //         GoRoute(path: '/$notification', name: notification, builder: (context, state) => const NotificationPage())
          //       ],
          //     ),
          //     StatefulShellBranch(
          //       routes: [
          //         GoRoute(
          //             path: '/$personalAccount', name: personalAccount, builder: (context, state) => const PersonalAccountPage())
          //       ],
          //     ),
          //   ],
          //   navigatorContainerBuilder: (BuildContext context, StatefulNavigationShell navigationShell, List<Widget> children) {
          //     return Stack(children: children);
          //   },
          // ),
        ],
      ),
    );
  }
}
