
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moi_market/core/local_storage/local_storage.dart';
import 'package:moi_market/core/local_storage/secured_local_storage.dart';
import 'package:moi_market/di/register_api_service.dart';
import 'package:moi_market/features/auth/data/api/auth_api.dart';
import 'package:moi_market/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:moi_market/features/auth/domain/repositories/auth_repository.dart';
import 'package:moi_market/features/home/data/api/home_api.dart';
import 'package:moi_market/features/home/data/repositories/home_repository_impl.dart';
import 'package:moi_market/features/home/domain/repositories/home_repository.dart';
import 'package:moi_market/features/notification/data/api/notification_api.dart';
import 'package:moi_market/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:moi_market/features/notification/domain/repositories/notification_repository.dart';
import 'package:moi_market/features/personal_account/data/api/personal_account_api.dart';
import 'package:moi_market/features/personal_account/data/repositories/personal_account_repository_impl.dart';
import 'package:moi_market/features/personal_account/domain/repositories/personal_account_repository.dart';
import 'package:moi_market/features/referrals/data/api/referrals_api.dart';
import 'package:moi_market/features/referrals/data/repositories/referrals_repository_impl.dart';
import 'package:moi_market/features/referrals/domain/repositories/referrals_repository.dart';
import 'package:moi_market/routes/app_router.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  Future<void> initModules() async {
    _initLocalStorage();

    final token = await getIt<LocalStorage>().fetchToken();

    await _initDio(token);
    await _initRouter(token);
    initAuthModule();
    initHomeModule();
    initNotificationModule();
    initPersonalAccountModule();
    initReferralsModule();
  }

  void _initLocalStorage() {
    getIt.registerLazySingleton<LocalStorage>(() => SecuredLocalStorage());
  }

  Future<void> _initDio(String? token) async {
    registerApiServiceDi(token: token);
  }

  Future<void> _initRouter(String? token) async {
    Routes.initRouter(
        initialRoute: token == null ? Routes.auth : Routes.home);
  }

  void initAuthModule() {
    if (!getIt.isRegistered<AuthApi>()) {
      getIt.registerLazySingleton(() => AuthApi(getIt<Dio>()));
    }

    if (!getIt.isRegistered<AuthRepository>()) {
      getIt.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(api: getIt<AuthApi>()));
    }
  }

  void initHomeModule() {
    if (!getIt.isRegistered<HomeApi>()) {
      getIt.registerLazySingleton(() => HomeApi(getIt<Dio>()));
    }

    if (!getIt.isRegistered<HomeRepository>()) {
      getIt.registerLazySingleton<HomeRepository>(
              () => HomeRepositoryImpl(api: getIt<HomeApi>()));
    }
  }

  void initReferralsModule() {
    if (!getIt.isRegistered<ReferralsApi>()) {
      getIt.registerLazySingleton(() => ReferralsApi(getIt<Dio>()));
    }

    if (!getIt.isRegistered<ReferralsRepository>()) {
      getIt.registerLazySingleton<ReferralsRepository>(
              () => ReferralsRepositoryImpl(api: getIt<ReferralsApi>()));
    }
  }

  void initPersonalAccountModule() {
    if (!getIt.isRegistered<PersonalAccountApi>()) {
      getIt.registerLazySingleton(() => PersonalAccountApi(getIt<Dio>()));
    }

    if (!getIt.isRegistered<PersonalAccountRepository>()) {
      getIt.registerLazySingleton<PersonalAccountRepository>(
              () => PersonalAccountRepositoryImpl(api: getIt<PersonalAccountApi>()));
    }
  }

  void initNotificationModule() {
    if (!getIt.isRegistered<NotificationApi>()) {
      getIt.registerLazySingleton(() => NotificationApi(getIt<Dio>()));
    }

    if (!getIt.isRegistered<NotificationRepository>()) {
      getIt.registerLazySingleton<NotificationRepository>(
              () => NotificationRepositoryImpl(api: getIt<NotificationApi>()));
    }
  }
}
