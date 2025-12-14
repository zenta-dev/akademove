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
            GoRoute(
              name: Routes.driverEarnings.name,
              path: 'earnings',
              builder: (context, state) => BlocProvider(
                create: (_) => sl<DriverWalletCubit>(),
                child: const DriverEarningsScreen(),
              ),
              routes: [
                GoRoute(
                  name: Routes.driverCommissionReport.name,
                  path: 'commission',
                  builder: (context, state) => BlocProvider(
                    create: (_) => sl<DriverWalletCubit>(),
                    child: const DriverCommissionReportScreen(),
                  ),
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
