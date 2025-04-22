
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moi_market/core/local_storage/local_storage.dart';
import 'package:moi_market/core/local_storage/secured_local_storage.dart';
import 'package:moi_market/di/register_api_service.dart';
import 'package:moi_market/features/auth/data/api/auth_api.dart';
import 'package:moi_market/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:moi_market/features/auth/domain/repositories/auth_repository.dart';
import 'package:moi_market/routes/app_router.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  Future<void> initModules() async {
    _initLocalStorage();

    final token = await getIt<LocalStorage>().fetchToken();

    await _initDio('token');
    await _initRouter(token);

    initAuthModule();
  }

  void _initLocalStorage() {
    getIt.registerLazySingleton<LocalStorage>(() => SecuredLocalStorage());
  }

  Future<void> _initDio(String? token) async {
    if (token != null) {
      registerApiServiceDi(token: token);
    }
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
}
