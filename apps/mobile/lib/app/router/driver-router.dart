part of 'router.dart';

final driverRouter = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) => MultiRepositoryProvider(
    providers: [
      RepositoryProvider<LocationService>.value(value: sl<LocationService>()),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<BottomNavBarCubit>()),
        BlocProvider(create: (_) => sl<DriverProfileCubit>()),
        BlocProvider(create: (_) => sl<DriverHomeCubit>()),
        BlocProvider(create: (_) => sl<DriverOrderCubit>()),
        BlocProvider(create: (_) => sl<DriverScheduleCubit>()),
        BlocProvider(create: (_) => sl<DriverListHistoryCubit>()),
        BlocProvider(create: (_) => sl<DriverLeaderboardCubit>()),
        BlocProvider(create: (_) => sl<DriverReviewCubit>()),
        BlocProvider(create: (_) => sl<SharedEmergencyCubit>()),
        BlocProvider(create: (_) => sl<SharedOrderChatCubit>()),
        BlocProvider(create: (_) => sl<SharedQuickMessageCubit>()),
        BlocProvider.value(
          value: sl<SharedNotificationCubit>()
            ..getUnreadCount()
            ..subscribeToTopic('driver-announcements'),
        ),
      ],
      child: DriverIncomingOrderListener(
        child: BottomNavbar(
          shell: navigationShell,
          tabs: const [
            BottomNavBarItem(label: 'Home', icon: LucideIcons.house),
            BottomNavBarItem(label: 'KRS', icon: LucideIcons.book),
            BottomNavBarItem(label: 'History', icon: LucideIcons.history),
            BottomNavBarItem(label: 'Profile', icon: LucideIcons.user),
          ],
        ),
      ),
    ),
  ),
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.driverHome.name,
          path: Routes.driverHome.path,
          builder: (context, state) => const DriverHomeScreen(),
          routes: [
            GoRoute(
              name: Routes.driverOrderDetail.name,
              path: 'order/:orderId',
              builder: (context, state) {
                final orderId = state.pathParameters['orderId']!;
                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.read<DriverOrderCubit>()),
                    BlocProvider.value(
                      value: context.read<SharedEmergencyCubit>(),
                    ),
                  ],
                  child: DriverOrderDetailScreen(orderId: orderId),
                );
              },
            ),
            ShellRoute(
              builder: (context, state, child) => BlocProvider(
                create: (_) => sl<DriverWalletCubit>(),
                child: child,
              ),
              routes: [
                GoRoute(
                  name: Routes.driverEarnings.name,
                  path: 'earnings',
                  builder: (context, state) => const DriverEarningsScreen(),
                  routes: [
                    GoRoute(
                      name: Routes.driverCommissionReport.name,
                      path: 'commission',
                      builder: (context, state) =>
                          const DriverCommissionReportScreen(),
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              name: Routes.driverLeaderboard.name,
              path: 'leaderboard',
              builder: (context, state) => BlocProvider.value(
                value: context.read<DriverLeaderboardCubit>()..init(),
                child: const LeaderboardScreen(),
              ),
              routes: [
                GoRoute(
                  name: Routes.driverLeaderboardDetail.name,
                  path: 'detail',
                  builder: (context, state) => BlocProvider.value(
                    value: context.read<DriverLeaderboardCubit>(),
                    child: const DriverLeaderboardDetailScreen(),
                  ),
                ),
              ],
            ),
            GoRoute(
              name: Routes.driverReviews.name,
              path: 'reviews',
              builder: (context, state) => BlocProvider.value(
                value: context.read<DriverReviewCubit>()
                  ..loadMyReviews(refresh: true),
                child: const DriverReviewsScreen(),
              ),
              routes: [
                GoRoute(
                  name: Routes.driverReviewsDetail.name,
                  path: 'detail',
                  builder: (context, state) => BlocProvider.value(
                    value: context.read<DriverReviewCubit>(),
                    child: const DriverReviewsDetailScreen(),
                  ),
                ),
              ],
            ),
            GoRoute(
              name: Routes.driverNotifications.name,
              path: 'notifications',
              builder: (context, state) => BlocProvider.value(
                value: context.read<SharedNotificationCubit>()
                  ..refreshNotifications(),
                child: const NotificationScreen(),
              ),
            ),
            GoRoute(
              name: Routes.driverOrderCompletion.name,
              path: 'order-completion',
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;

                // Handle missing route parameters gracefully
                if (extra == null) {
                  logger.w(
                    '[DriverRouter] Order completion route missing extra data',
                  );
                  // Navigate back to home if route data is missing
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (context.mounted) {
                      context.goNamed(Routes.driverHome.name);
                    }
                  });
                  return const Scaffold(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final orderId = extra['orderId'] as String?;
                final orderType = extra['orderType'] as OrderType?;
                final order = extra['order'] as Order?;

                // Validate required parameters
                if (orderId == null || orderType == null || order == null) {
                  logger.w(
                    '[DriverRouter] Order completion route missing required data: '
                    'orderId=${orderId != null}, orderType=${orderType != null}, '
                    'order=${order != null}',
                  );
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (context.mounted) {
                      context.goNamed(Routes.driverHome.name);
                    }
                  });
                  return const Scaffold(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final driverUser = extra['user'] as DriverUser?;
                final orderMerchant = extra['merchant'] as OrderMerchant?;
                final payment = extra['payment'] as Payment?;

                // Convert OrderMerchant to MerchantInfo if present
                final merchantInfo = orderMerchant != null
                    ? MerchantInfo.fromOrderMerchant(orderMerchant)
                    : null;

                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<DriverReviewCubit>(),
                    ),
                    BlocProvider.value(value: context.read<DriverOrderCubit>()),
                  ],
                  child: OrderCompletionScreen(
                    orderId: orderId,
                    orderType: orderType,
                    order: order,
                    viewerRole: OrderCompletionViewerRole.driver,
                    driverUser: driverUser,
                    merchantInfo: merchantInfo,
                    payment: payment,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.driverKRS.name,
          path: Routes.driverKRS.path,
          builder: (context, state) => const DriverKrsScreen(),
          routes: [
            GoRoute(
              name: Routes.driverKrsUpsert.name,
              path: 'upsert',
              builder: (context, state) {
                final schedule = state.extra as DriverSchedule?;
                return DriverKrsUpsertScreen(schedule: schedule);
              },
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.driverHistory.name,
          path: Routes.driverHistory.path,
          builder: (context, state) => const DriverHistoryScreen(),
          routes: [
            GoRoute(
              name: Routes.driverHistoryDetail.name,
              path: ':orderId',
              builder: (context, state) {
                final orderId = state.pathParameters['orderId']!;
                return DriverHistoryDetailScreen(orderId: orderId);
              },
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.driverProfile.name,
          path: Routes.driverProfile.path,
          builder: (context, state) => const DriverProfileScreen(),
          routes: [
            GoRoute(
              name: Routes.driverEditProfile.name,
              path: 'edit',
              builder: (context, state) => const DriverEditProfileScreen(),
            ),
            GoRoute(
              name: Routes.driverChangePassword.name,
              path: 'change-password',
              builder: (context, state) => const DriverChangePasswordScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
