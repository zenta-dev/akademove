import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/core/interceptors/logger_interceptor.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {
  _setupService();
  _setupRepository();
  _setupCubit();
}

void _setupService() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.157.72.105:3000/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(minutes: 3),
    ),
  );
  final interceptors = [
    BearerAuthInterceptor(),
    LoggerInterceptor(),
  ];
  sl
    ..registerSingleton(
      ApiClient(dio: dio, interceptors: interceptors),
    )
    ..registerSingletonAsync<KeyValueService>(
      () async => SharedPrefKeyValueService().setup(),
    )
    ..registerSingleton<ImageService>(ImagePickerService());
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
    ..registerFactory(() => SignInCubit(sl<AuthRepository>()))
    ..registerFactory(() => SignUpCubit(sl<AuthRepository>()));
}
