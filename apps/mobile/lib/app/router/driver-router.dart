part of 'router.dart';

final driverRouter = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) => BottomNavbar(
    shell: navigationShell,
    tabs: const [
      BottomNavBarItem(label: 'Home', icon: LucideIcons.house),
      BottomNavBarItem(label: 'KRS', icon: LucideIcons.book),
      BottomNavBarItem(label: 'History', icon: LucideIcons.history),
      BottomNavBarItem(label: 'Profile', icon: LucideIcons.user),
    ],
  ),
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.driverHome.name,
          path: Routes.driverHome.path,
          builder: (context, state) => const DriverHomeScreen(),
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
