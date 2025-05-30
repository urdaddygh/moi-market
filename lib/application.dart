import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moi_market/core/cubit/language/language_cubit.dart';
import 'package:moi_market/core/cubit/language/language_state.dart';
import 'package:moi_market/core/theme/app_theme.dart';
import 'package:moi_market/features/auth/domain/repositories/auth_repository.dart';
import 'package:moi_market/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:moi_market/features/home/domain/repositories/home_repository.dart';
import 'package:moi_market/features/home/presentation/cubit/home_cubit.dart';
import 'package:moi_market/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:moi_market/features/personal_account/presentation/cubit/personal_account_cubit.dart';
import 'package:moi_market/features/referrals/presentation/cubit/referrals_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moi_market/global_repository/notification_repository/firebase_notification_repository.dart';
import 'package:moi_market/main.dart';

class Application extends StatefulWidget {
  const Application({super.key, this.lang});

  // final Stream<LocationMarkerPosition?>? locationMarkerStream;
  final Language? lang;

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseNotificationRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => LanguageCubit(initialLanguage: widget.lang)),
          BlocProvider(create: (context) => AuthCubit(GetIt.I<AuthRepository>())),
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => ReferralsCubit()),
          BlocProvider(create: (context) => PersonalAccountCubit()),
          BlocProvider(create: (context) => NotificationCubit()),
        ],
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, languageState) {
            return MaterialApp.router(
              theme: lightTheme,
              // navigatorKey: _navigatorKey,
              routerConfig: GetIt.I.get<GoRouter>(),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ru'),
                Locale('ky'),
              ],
              locale: Locale(languageState.language.name),
            );
          },
        ),
      ),
    );
  }
}
