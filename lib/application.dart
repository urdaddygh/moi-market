 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moi_market/core/theme/app_theme.dart';
import 'package:moi_market/features/auth/domain/repositories/auth_repository.dart';
import 'package:moi_market/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:moi_market/features/personal_account/presentation/cubit/personal_account_cubit.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_cubit.dart';

class Application extends StatelessWidget {
  const Application({super.key});
  // final Stream<LocationMarkerPosition?>? locationMarkerStream;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(GetIt.I<AuthRepository>())),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ReferralsCubit()),
        BlocProvider(create: (context) => PersonalAccountCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
      ],
      child: MaterialApp.router(
        theme: lightTheme,
        // navigatorKey: _navigatorKey,
        routerConfig: GetIt.I.get<GoRouter>(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru'),
          Locale('ky'),
        ],
        locale: const Locale('ru'),
      ),
    );
  }
}
