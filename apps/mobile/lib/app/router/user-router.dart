part of 'router.dart';

final userRouter = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) => MultiBlocProvider(
    providers: [
      BlocProvider.value(
        value: BlocProvider.of<ConfigurationCubit>(context)..getBanner(),
      ),
      BlocProvider(
        create: (_) => sl<UserHomeCubit>()..getPopulars(),
      ),
      BlocProvider(
        create: (_) => sl<UserRideCubit>(),
      ),
      BlocProvider(
        create: (_) => sl<UserWalletCubit>(),
      ),
      BlocProvider(
        create: (_) => sl<UserWalletTopUpCubit>(),
      ),
      BlocProvider(
        create: (_) => sl<UserOrderCubit>(),
      ),
    ],
    child: BottomNavbar(
      shell: navigationShell,
      tabs: const [
        BottomNavBarItem(label: 'Home', icon: LucideIcons.house),
        BottomNavBarItem(label: 'History', icon: LucideIcons.history),
        BottomNavBarItem(label: 'Profile', icon: LucideIcons.user),
      ],
    ),
  ),
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.userHome.name,
          path: Routes.userHome.path,
          builder: (context, state) => const UserHomeScreen(),
        ),
        //
        ShellRoute(
          builder: (context, state, child) => BlocProvider.value(
            value: BlocProvider.of<UserRideCubit>(context)..getMyLocation(),
            child: RideMapShell(child: child),
          ),
          routes: [
            GoRoute(
              name: Routes.userRide.name,
              path: Routes.userRide.path,
              builder: (context, state) => const UserRideScreen(),
            ),
            GoRoute(
              name: Routes.userDriverNearMe.name,
              path: Routes.userDriverNearMe.path,
              builder: (context, state) => const UserNearbyDriverScreen(),
            ),
            GoRoute(
              name: Routes.userRidePickup.name,
              path: Routes.userRidePickup.path,
              builder: (context, state) => const UserRidePickupScreen(),
            ),
            GoRoute(
              name: Routes.userRideDropoff.name,
              path: Routes.userRideDropoff.path,
              builder: (context, state) => const UserRideDropoffScreen(),
            ),
            GoRoute(
              name: Routes.userRideSummary.name,
              path: Routes.userRideSummary.path,
              builder: (context, state) => const UserRideSummaryScreen(),
            ),
            GoRoute(
              name: Routes.userRidePayQRIS.name,
              path: Routes.userRidePayQRIS.path,
              builder: (context, state) => const UserRidePayQrisScreen(),
            ),
            GoRoute(
              name: Routes.userRidePayOnTrip.name,
              path: Routes.userRidePayOnTrip.path,
              builder: (context, state) => const UserRideOnTripScreen(),
            ),
          ],
        ),

        //
        GoRoute(
          name: Routes.userDelivery.name,
          path: Routes.userDelivery.path,
          builder: (context, state) => const UserDeliveryScreen(),
        ),
        GoRoute(
          name: Routes.userMart.name,
          path: Routes.userMart.path,
          builder: (context, state) => const UserMartScreen(),
        ),
        GoRoute(
          name: Routes.userWallet.name,
          path: Routes.userWallet.path,
          builder: (context, state) => BlocProvider.value(
            value: BlocProvider.of<UserWalletCubit>(context)..init(),
            child: const UserWalletScreen(),
          ),
        ),
        GoRoute(
          name: Routes.userWalletTopUp.name,
          path: Routes.userWalletTopUp.path,
          builder: (context, state) => const UserWalletTopUpScreen(),
        ),
        GoRoute(
          name: Routes.userWalletTopUpInsertAmount.name,
          path: Routes.userWalletTopUpInsertAmount.path,
          builder: (context, state) {
            var method = TopUpRequestMethodEnum.QRIS;

            switch (state.uri.queryParameters['method']) {
              case 'QRIS':
                method = TopUpRequestMethodEnum.QRIS;
              case 'VA':
                method = TopUpRequestMethodEnum.VA;
              case 'BANK_TRANSFER':
                method = TopUpRequestMethodEnum.BANK_TRANSFER;
            }

            return UserWalletTopUpInsertAmountScreen(method: method);
          },
        ),
        GoRoute(
          name: Routes.userWalletTopUpQRIS.name,
          path: Routes.userWalletTopUpQRIS.path,
          builder: (context, state) => const UserWalletTopUpQRISScreen(),
        ),
        GoRoute(
          name: Routes.userVoucher.name,
          path: Routes.userVoucher.path,
          builder: (context, state) => const UserVoucherScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.userHistory.name,
          path: Routes.userHistory.path,
          builder: (context, state) => BlocProvider.value(
            value: BlocProvider.of<UserOrderCubit>(context)..list(),
            child: const UserHistoryScreen(),
          ),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: Routes.userProfile.name,
          path: Routes.userProfile.path,
          builder: (context, state) => const UserProfileScreen(),
        ),
        GoRoute(
          name: Routes.userDetailProfile.name,
          path: Routes.userDetailProfile.path,
          builder: (context, state) => const UserDetailProfileScreen(),
        ),
        GoRoute(
          name: Routes.userEditProfile.name,
          path: Routes.userEditProfile.path,
          builder: (context, state) => BlocProvider(
            create: (context) => sl<UserProfileCubit>(),
            child: const UserEditProfileScreen(),
          ),
        ),
        GoRoute(
          name: Routes.userChangePassword.name,
          path: Routes.userChangePassword.path,
          builder: (context, state) => BlocProvider(
            create: (context) => sl<UserProfileCubit>(),
            child: const UserChangePasswordScreen(),
          ),
        ),
      ],
    ),
  ],
);
