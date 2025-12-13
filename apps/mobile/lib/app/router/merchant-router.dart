part of 'router.dart';

final merchantRouter = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) => MultiRepositoryProvider(
    providers: [
      RepositoryProvider<LocationService>.value(value: sl<LocationService>()),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<BottomNavBarCubit>()),
        BlocProvider(create: (_) => sl<MerchantCubit>()),
        BlocProvider(create: (_) => sl<MerchantMenuCubit>()),
        BlocProvider(create: (_) => sl<MerchantOrderCubit>()),
        BlocProvider(create: (_) => sl<MerchantAvailabilityCubit>()),
        BlocProvider(create: (_) => sl<MerchantAnalyticsCubit>()),
        BlocProvider(create: (_) => sl<UserProfileCubit>()),
        BlocProvider(create: (_) => sl<SharedOrderChatCubit>()),
        BlocProvider(create: (_) => sl<SharedQuickMessageCubit>()),
        BlocProvider.value(
          value: sl<SharedNotificationCubit>()
            ..getUnreadCount()
            ..subscribeToTopic('merchant-announcements'),
        ),
      ],
      child: MerchantIncomingOrderListener(
        child: BottomNavbar(
          shell: navigationShell,
          tabs: const [
            BottomNavBarItem(label: 'Home', icon: LucideIcons.house),
            BottomNavBarItem(label: 'Order', icon: LucideIcons.book),
            BottomNavBarItem(label: 'Menu', icon: LucideIcons.listOrdered),
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
          name: Routes.merchantHome.name,
          path: Routes.merchantHome.path,
          builder: (context, state) => const MerchantHomeScreen(),
        ),
        GoRoute(
          name: Routes.merchantSalesReportDetail.name,
          path: Routes.merchantSalesReportDetail.path,
          builder: (context, state) => const MerchantSalesReportDetailScreen(),
        ),
        GoRoute(
          name: Routes.merchantCommissionReportDetail.name,
          path: Routes.merchantCommissionReportDetail.path,
          builder: (context, state) =>
              const MerchantCommissionReportDetailScreen(),
        ),
        GoRoute(
          name: Routes.merchantNotifications.name,
          path: Routes.merchantNotifications.path,
          builder: (context, state) => BlocProvider.value(
            value: context.read<SharedNotificationCubit>()
              ..refreshNotifications(),
            child: const NotificationScreen(),
          ),
        ),
        // GoRoute(
        //   name: Routes.merchantWalletWithdraw.name,
        //   path: Routes.merchantWalletWithdraw.path,
        //   builder: (context, state) => BlocProvider(
        //     create: (_) => sl<MerchantWalletCubit>(),
        //     child: const MerchantWalletWithdrawScreen(),
        //   ),
        // ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.merchantOrder.name,
          path: Routes.merchantOrder.path,
          builder: (context, state) => BlocProvider.value(
            value: BlocProvider.of<MerchantOrderCubit>(context),
            child: const MerchantOrderScreen(),
          ),
        ),
        GoRoute(
          name: Routes.merchantOrderDetail.name,
          path: Routes.merchantOrderDetail.path,
          builder: (context, state) {
            final order = state.extra as Order?;
            if (order == null) {
              throw Exception('Order is required for merchant order detail');
            }
            return MerchantOrderDetailScreen(order: order);
          },
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.merchantMenu.name,
          path: Routes.merchantMenu.path,
          builder: (context, state) => const MerchantMenuScreen(),
        ),
        GoRoute(
          name: Routes.merchantMenuDetail.name,
          path: Routes.merchantMenuDetail.path,
          builder: (context, state) => const MerchantMenuDetailScreen(),
        ),
        GoRoute(
          name: Routes.merchantCreateMenu.name,
          path: Routes.merchantCreateMenu.path,
          builder: (context, state) => const MerchantCreateMenuScreen(),
        ),
        GoRoute(
          name: Routes.merchantEditMenu.name,
          path: Routes.merchantEditMenu.path,
          builder: (context, state) => const MerchantEditMenuScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.merchantProfile.name,
          path: Routes.merchantProfile.path,
          builder: (context, state) => const MerchantProfileScreen(),
        ),
        GoRoute(
          name: Routes.merchantSetUpOutlet.name,
          path: Routes.merchantSetUpOutlet.path,
          builder: (context, state) => const MerchantSetUpOutletScreen(),
        ),
        GoRoute(
          name: Routes.merchantEditProfile.name,
          path: Routes.merchantEditProfile.path,
          builder: (context, state) => const MerchantEditProfileScreen(),
        ),
        GoRoute(
          name: Routes.merchantChangePassword.name,
          path: Routes.merchantChangePassword.path,
          builder: (context, state) => BlocProvider.value(
            value: context.read<UserProfileCubit>(),
            child: const MerchantChangePasswordScreen(),
          ),
        ),
      ],
    ),
  ],
);
