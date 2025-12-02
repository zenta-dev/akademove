part of 'router.dart';

final driverRouter = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) => MultiBlocProvider(
    providers: [BlocProvider(create: (_) => sl<BottomNavBarCubit>())],
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
                return DriverOrderDetailScreen(orderId: orderId);
              },
            ),
            GoRoute(
              name: Routes.driverEarnings.name,
              path: 'earnings',
              builder: (context, state) => const DriverEarningsScreen(),
            ),
            GoRoute(
              name: Routes.driverLeaderboard.name,
              path: 'leaderboard',
              builder: (context, state) => const LeaderboardScreen(),
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
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.driverHistory.name,
          path: Routes.driverHistory.path,
          builder: (context, state) => const DriverHistoryScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.driverProfile.name,
          path: Routes.driverProfile.path,
          builder: (context, state) => const DriverProfileScreen(),
        ),
      ],
    ),
  ],
);
