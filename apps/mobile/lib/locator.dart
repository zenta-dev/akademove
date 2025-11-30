import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
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
  sl
    ..registerSingleton<KeyValueService>(SharedPrefKeyValueService())
    ..registerSingleton(AcceptLanguageInterceptor(sl<KeyValueService>()))
    ..registerSingleton(
      ApiClient(
        dio: Dio(
          BaseOptions(
            baseUrl: UrlConstants.apiBaseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 30),
          ),
        ),
        interceptors: [
          BearerAuthInterceptor(),
          sl<AcceptLanguageInterceptor>(),
          LoggerInterceptor(),
        ],
      ),
    )
    ..registerSingleton<ImageService>(ImagePickerService()..setup())
    ..registerSingleton<LocationService>(LocationService())
    ..registerSingletonAsync<MapService>(
      IMapService().setup,
      dispose: (param) => param.teardown(),
    )
    ..registerLazySingleton(
      WebSocketService.new,
      dispose: (param) => param.dispose(),
    )
    ..registerLazySingleton(FirebaseService.new)
    ..registerLazySingleton(NotificationService.new);
}

void _setupRepository() {
  sl
    ..registerLazySingleton(
      () => AuthRepository(
        apiClient: sl<ApiClient>(),
        localKV: sl<KeyValueService>(),
        ws: sl<WebSocketService>(),
      ),
    )
    ..registerLazySingleton(
      () => MerchantRepository(apiClient: sl<ApiClient>()),
    )
    ..registerLazySingleton(() => DriverRepository(apiClient: sl<ApiClient>()))
    ..registerLazySingleton(
      () => ConfigurationRepository(apiClient: sl<ApiClient>()),
    )
    ..registerLazySingleton(() => OrderRepository(apiClient: sl<ApiClient>()))
    ..registerLazySingleton(
      () => TransactionRepository(apiClient: sl<ApiClient>()),
    )
    ..registerLazySingleton(() => WalletRepository(apiClient: sl<ApiClient>()))
    ..registerLazySingleton(
      () => NotificationRepository(
        apiClient: sl<ApiClient>(),
        firebaseService: sl<FirebaseService>(),
        keyValueService: sl<KeyValueService>(),
      ),
    )
    ..registerLazySingleton(() => UserRepository(apiClient: sl<ApiClient>()));
}

void _setupCubit() {
  sl
    ..registerFactory(BottomNavBarCubit.new)
    ..registerFactory(() => AppCubit(keyValueService: sl<KeyValueService>()))
    ..registerFactory(() => AuthCubit(authRepository: sl<AuthRepository>()))
    ..registerFactory(() => SignInCubit(authRepository: sl<AuthRepository>()))
    ..registerFactory(() => SignUpCubit(authRepository: sl<AuthRepository>()))
    ..registerFactory(
      () => MerchantCubit(merchantRepository: sl<MerchantRepository>()),
    )
    ..registerFactory(
      () => MerchantOrderCubit(orderRepository: sl<OrderRepository>()),
    )
    ..registerFactory(
      () => UserHomeCubit(merchantRepository: sl<MerchantRepository>()),
    )
    ..registerFactory(
      () => UserLocationCubit(locationService: sl<LocationService>()),
    )
    ..registerFactory(
      () => UserRideCubit(
        driverRepository: sl<DriverRepository>(),
        mapService: sl<MapService>(),
      ),
    )
    ..registerFactory(
      () => UserDeliveryCubit(
        orderRepository: sl<OrderRepository>(),
        mapService: sl<MapService>(),
      ),
    )
    ..registerFactory(
      () => UserWalletCubit(
        walletRepository: sl<WalletRepository>(),
        transactionRepository: sl<TransactionRepository>(),
      ),
    )
    ..registerFactory(
      () => UserWalletTopUpCubit(
        walletRepository: sl<WalletRepository>(),
        webSocketService: sl<WebSocketService>(),
      ),
    )
    ..registerFactory(
      () => UserOrderCubit(
        orderRepository: sl<OrderRepository>(),
        webSocketService: sl<WebSocketService>(),
      ),
    )
    ..registerFactory(
      () => UserProfileCubit(userRepository: sl<UserRepository>()),
    )
    ..registerFactory(
      () => ConfigurationCubit(
        configurationRepository: sl<ConfigurationRepository>(),
      ),
    );
}
