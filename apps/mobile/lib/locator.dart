import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/core/interceptors/logger_interceptor.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart' as api;
import 'package:auth_client/auth_client.dart' as auth;
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {
  _setupService();
  _setupRepository();
  _setupCubit();
}

void _setupService() {
  final interceptors = [
    // auth.OAuthInterceptor(),
    // auth.BasicAuthInterceptor(),
    auth.BearerAuthInterceptor(),
    // auth.ApiKeyAuthInterceptor(),
    LoggerInterceptor(),
  ];
  sl
    ..registerSingleton(
      auth.AuthClient(interceptors: interceptors),
    )
    ..registerSingleton(
      api.ApiClient(interceptors: interceptors),
    )
    ..registerSingleton<KeyValueService>(SharedPrefKeyValueService());
}

void _setupRepository() {
  sl.registerLazySingleton(
    () => AuthRepository(
      authClient: sl<auth.AuthClient>(),
      apiClient: sl<api.ApiClient>(),
      localKV: sl<KeyValueService>(),
    ),
  );
}

void _setupCubit() {
  sl
    ..registerFactory(AppCubit.new)
    ..registerFactory(() => SplashCubit(sl<AuthRepository>()))
    ..registerFactory(() => SignInCubit(sl<AuthRepository>()));
}
