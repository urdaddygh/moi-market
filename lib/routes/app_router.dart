

import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_market/features/auth/presentation/pages/auth_page.dart';
import 'package:moi_market/features/home/presentation/pages/home_page.dart';

class Routes {
  static const auth = 'auth';
  static const home = 'home';
  

  static void initRouter({String initialRoute = Routes.auth}) {
    GetIt.I.registerSingleton<GoRouter>(
      GoRouter(
        initialLocation: initialRoute == Routes.home ? '/' : '/$initialRoute',
        routes: [
          GoRoute(
            path: '/',
            name: home,
            builder: (context, state) => const HomePage(),
            routes: const [

            ],
          ),
          GoRoute(
            path: '/$auth',
            name: auth,
            builder: (context, state) => const AuthPage(),
          ),
        ],
      ),
    );
  }
}