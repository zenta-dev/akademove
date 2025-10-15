import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/core/interceptors/logger_interceptor.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {
  _setupService();
  _setupRepository();
  _setupCubit();
}

void _setupService() {
  final interceptors = [
    BearerAuthInterceptor(),
    LoggerInterceptor(),
  ];
  sl
    ..registerSingleton(
      ApiClient(
        interceptors: interceptors,
        basePathOverride: 'http://10.183.54.105:3000/api',
      ),
    )
    ..registerSingleton<KeyValueService>(SharedPrefKeyValueService());
}

void _setupRepository() {
  sl.registerLazySingleton(
    () => AuthRepository(
      apiClient: sl<ApiClient>(),
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
