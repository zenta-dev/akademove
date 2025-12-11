import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/user/presentation/cubits/user_merchant_detail_cubit.dart';

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
    ..registerLazySingleton(NotificationService.new)
    ..registerLazySingleton(
      () => StateResetService(
        webSocketService: sl<WebSocketService>(),
        keyValueService: sl<KeyValueService>(),
      ),
    );
}

void _setupRepository() {
  sl
    ..registerLazySingleton(
      () => AuthRepository(
        apiClient: sl<ApiClient>(),
        localKV: sl<KeyValueService>(),
        ws: sl<WebSocketService>(),
        stateResetService: sl<StateResetService>(),
      ),
    )
    ..registerLazySingleton(
      () => MerchantRepository(apiClient: sl<ApiClient>()),
    )
    ..registerLazySingleton(
      () => MerchantOrderRepository(apiClient: sl<ApiClient>()),
    )
    ..registerLazySingleton(() => DriverRepository(apiClient: sl<ApiClient>()))
    ..registerLazySingleton(() => ReviewRepository(apiClient: sl<ApiClient>()))
    ..registerLazySingleton(
      () => UserReviewRepository(apiClient: sl<ApiClient>()),
    )
    ..registerLazySingleton(
      () => ConfigurationRepository(apiClient: sl<ApiClient>()),
    )
    ..registerLazySingleton(() => OrderRepository(apiClient: sl<ApiClient>()))
    ..registerLazySingleton(
      () => OrderChatRepository(apiClient: sl<ApiClient>()),
    )
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
    ..registerLazySingleton(() => UserRepository(apiClient: sl<ApiClient>()))
    ..registerLazySingleton(() => CouponRepository(apiClient: sl<ApiClient>()))
    ..registerLazySingleton(
      () => EmergencyRepository(apiClient: sl<ApiClient>()),
    )
    ..registerLazySingleton(
      () => LeaderboardRepository(apiClient: sl<ApiClient>()),
    )
    ..registerLazySingleton(() => BadgeRepository(apiClient: sl<ApiClient>()))
    ..registerLazySingleton(
      () => CartRepository(keyValueService: sl<KeyValueService>()),
    )
    ..registerLazySingleton(
      () => QuickMessageRepository(apiClient: sl<ApiClient>()),
    )
    ..registerLazySingleton(() => ReportRepository(apiClient: sl<ApiClient>()))
    ..registerLazySingleton(
      () => DriverQuizRepository(apiClient: sl<ApiClient>()),
    );
}

void _setupCubit() {
  sl
    ..registerFactory(BottomNavBarCubit.new)
    ..registerFactory(() => AppCubit(keyValueService: sl<KeyValueService>()))
    ..registerFactory(
      () => AuthCubit(
        authRepository: sl<AuthRepository>(),
        driverRepository: sl<DriverRepository>(),
        merchantRepository: sl<MerchantRepository>(),
      ),
    )
    ..registerFactory(
      () => EmailVerificationCubit(authRepository: sl<AuthRepository>()),
    )
    ..registerFactory(
      () => MerchantCubit(
        merchantRepository: sl<MerchantRepository>(),
        userRepository: sl<UserRepository>(),
      ),
    )
    ..registerFactory(
      () => MerchantMenuCubit(merchantRepository: sl<MerchantRepository>()),
    )
    ..registerFactory(
      () => MerchantAvailabilityCubit(
        merchantRepository: sl<MerchantRepository>(),
      ),
    )
    ..registerFactory(
      () =>
          MerchantAnalyticsCubit(merchantRepository: sl<MerchantRepository>()),
    )
    ..registerFactory(
      () => MerchantOrderCubit(
        orderRepository: sl<OrderRepository>(),
        merchantOrderRepository: sl<MerchantOrderRepository>(),
        webSocketService: sl<WebSocketService>(),
        notificationService: sl<NotificationService>(),
      ),
    )
    ..registerFactory(
      () => UserHomeCubit(merchantRepository: sl<MerchantRepository>()),
    )
    ..registerFactory(
      () => UserLocationCubit(locationService: sl<LocationService>()),
    )
    ..registerFactory(
      () => UserMartCubit(merchantRepository: sl<MerchantRepository>()),
    )
    ..registerFactory(
      () => UserMerchantListCubit(merchantRepository: sl<MerchantRepository>()),
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
        driverRepository: sl<DriverRepository>(),
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
      () => UserWalletTransferCubit(
        walletRepository: sl<WalletRepository>(),
        userRepository: sl<UserRepository>(),
      ),
    )
    ..registerFactory(
      () => UserOrderCubit(
        orderRepository: sl<OrderRepository>(),
        webSocketService: sl<WebSocketService>(),
        keyValueService: sl<KeyValueService>(),
      ),
    )
    ..registerFactory(
      () => OrderChatCubit(orderChatRepository: sl<OrderChatRepository>()),
    )
    ..registerFactory(
      () => UserProfileCubit(userRepository: sl<UserRepository>()),
    )
    ..registerFactory(() => UserMapCubit(mapService: sl<MapService>()))
    ..registerFactory(
      () => ConfigurationCubit(
        configurationRepository: sl<ConfigurationRepository>(),
      ),
    )
    ..registerFactory(
      () => DriverCubit(
        driverRepository: sl<DriverRepository>(),
        orderRepository: sl<OrderRepository>(),
        webSocketService: sl<WebSocketService>(),
        configurationRepository: sl<ConfigurationRepository>(),
      ),
    )
    ..registerFactory(
      () => DriverHomeCubit(
        driverRepository: sl<DriverRepository>(),
        orderRepository: sl<OrderRepository>(),
        webSocketService: sl<WebSocketService>(),
        configurationRepository: sl<ConfigurationRepository>(),
      ),
    )
    ..registerFactory(
      () => DriverOrderCubit(
        orderRepository: sl<OrderRepository>(),
        webSocketService: sl<WebSocketService>(),
        driverRepository: sl<DriverRepository>(),
      ),
    )
    ..registerFactory(
      () => DriverScheduleCubit(driverRepository: sl<DriverRepository>()),
    )
    ..registerFactory(
      () => DriverListHistoryCubit(orderRepository: sl<OrderRepository>()),
    )
    ..registerFactory(
      () => DriverEarningsCubit(
        walletRepository: sl<WalletRepository>(),
        transactionRepository: sl<TransactionRepository>(),
      ),
    )
    ..registerFactory(
      () => DriverProfileCubit(driverRepository: sl<DriverRepository>()),
    )
    ..registerFactory(
      () => DriverReviewCubit(reviewRepository: sl<ReviewRepository>()),
    )
    ..registerFactory(
      () => UserReviewCubit(reviewRepository: sl<UserReviewRepository>()),
    )
    ..registerFactory(
      () => CouponCubit(couponRepository: sl<CouponRepository>()),
    )
    ..registerFactory(
      () => EmergencyCubit(repository: sl<EmergencyRepository>()),
    )
    ..registerFactory(
      () => LeaderboardCubit(
        leaderboardRepository: sl<LeaderboardRepository>(),
        badgeRepository: sl<BadgeRepository>(),
      ),
    )
    ..registerFactory(
      () => CartCubit(
        cartRepository: sl<CartRepository>(),
        orderRepository: sl<OrderRepository>(),
      ),
    )
    ..registerFactory(
      () => QuickMessageCubit(
        quickMessageRepository: sl<QuickMessageRepository>(),
      ),
    )
    ..registerFactory(
      () => NotificationCubit(
        notificationRepository: sl<NotificationRepository>(),
      ),
    )
    ..registerFactory(
      () =>
          UserMerchantDetailCubit(merchantRepository: sl<MerchantRepository>()),
    )
    ..registerFactory(() => ReportCubit(repository: sl<ReportRepository>()))
    ..registerFactory(
      () => DriverQuizCubit2(quizRepository: sl<DriverQuizRepository>()),
    )
    ..registerFactory(
      () => DriverApprovalCubit(driverRepository: sl<DriverRepository>()),
    );
}
