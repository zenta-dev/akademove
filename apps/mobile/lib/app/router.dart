import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart' show TopUpRequestMethodEnum;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' show LucideIcons;

enum Routes {
  authSplash('/auth'),
  authSignIn('/auth/sign-in'),
  authSignUpChoice('/auth/sign-up'),
  authSignUpUser('/auth/sign-up/user'),
  authSignUpDriver('/auth/sign-up/driver'),
  authSignUpMerchant('/auth/sign-up/merchant'),
  authForgotPassword('/auth/forgot-password'),

  ///
  /// User Routes
  ///
  userHome('/user/home'),
  userRide('/user/home/ride'),
  userRidePickup('/user/home/ride/pickup'),
  userRideDropoff('/user/home/ride/dropoff'),
  userRideSummary('/user/home/ride/summary'),
  userDriverNearMe('/user/home/driver/near-me'),
  userDelivery('/user/home/delivery'),
  userMart('/user/home/mart'),
  userWallet('/user/home/wallet'),
  userWalletTopUp('/user/home/wallet/topup'),
  userWalletTopUpInsertAmount('/user/home/wallet/topup/insert-amount'),
  userWalletTopUpQRIS('/user/home/wallet/topup/qris'),
  userVoucher('/user/home/voucher'),

  userHistory('/user/history'),
  userProfile('/user/profile'),

  ///
  /// Driver Routes
  ///
  driverHome('/driver/home'),
  driverKRS('/driver/krs'),
  driverHistory('/driver/history'),
  driverProfile('/driver/profile'),

  ///
  /// Merchant Routes
  ///
  merchantHome('/merchant/home'),
  merchantSalesReportDetail('/merchant/sales/report/detail'),
  merchantCommissionReportDetail('/merchant/commission/report/detail'),
  merchantOrder('/merchant/order'),
  merchantOrderDetail('/merchant/order/detail'),
  merchantEditMenu('/merchant/edit/menu'),
  merchantMenu('/merchant/menu'),
  merchantMenuDetail('/merchant/menu/detail'),
  merchantProfile('/merchant/profile'),
  merchantSetUpOutlet('/merchant/set/up/outlet'),
  merchantEditProfile('/merchant/edit/profile'),
  merchantChangePassword('/merchant/change/password'),
  merchantPrivacyPolicies('/merchant/privacy/policies');

  const Routes(this.path);
  final String path;
}

final router = GoRouter(
  initialLocation: Routes.authSplash.path,
  routes: [
    ShellRoute(
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: Routes.authSplash.name,
          path: Routes.authSplash.path,
          builder: (context, state) => BlocProvider.value(
            value: sl<AuthCubit>()..init(),
            child: const SplashScreen(),
          ),
        ),
        GoRoute(
          name: Routes.authSignIn.name,
          path: Routes.authSignIn.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<SignInCubit>()..init(),
            child: const SignInScreen(),
          ),
        ),
        GoRoute(
          name: Routes.authSignUpChoice.name,
          path: Routes.authSignUpChoice.path,
          builder: (context, state) => const SignUpChoiceScreen(),
        ),
        GoRoute(
          name: Routes.authSignUpUser.name,
          path: Routes.authSignUpUser.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<SignUpCubit>()..init(),
            child: const SignUpUserScreen(),
          ),
        ),
        GoRoute(
          name: Routes.authSignUpDriver.name,
          path: Routes.authSignUpDriver.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<SignUpCubit>()..init(),
            child: const SignUpDriverScreen(),
          ),
        ),
        GoRoute(
          name: Routes.authSignUpMerchant.name,
          path: Routes.authSignUpMerchant.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<SignUpCubit>()..init(),
            child: const SignUpMerchantScreen(),
          ),
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
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
            GoRoute(
              name: Routes.userRide.name,
              path: Routes.userRide.path,
              builder: (context, state) => BlocProvider.value(
                value: BlocProvider.of<UserRideCubit>(context)..getMyLocation(),
                child: const UserRideScreen(),
              ),
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
              builder: (context, state) => const UserHistoryScreen(),
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
          ],
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
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
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<MerchantCubit>()..init()),
          BlocProvider(create: (_) => sl<MerchantOrderCubit>()),
        ],
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
              builder: (context, state) =>
                  const MerchantSalesReportDetailScreen(),
            ),
            GoRoute(
              name: Routes.merchantCommissionReportDetail.name,
              path: Routes.merchantCommissionReportDetail.path,
              builder: (context, state) =>
                  const MerchantCommissionReportDetailScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.merchantOrder.name,
              path: Routes.merchantOrder.path,
              builder: (context, state) => BlocProvider.value(
                value: BlocProvider.of<MerchantOrderCubit>(context)..init(),
                child: const MerchantOrderScreen(),
              ),
            ),
            GoRoute(
              name: Routes.merchantOrderDetail.name,
              path: Routes.merchantOrderDetail.path,
              builder: (context, state) => const MerchantOrderDetailScreen(),
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
              builder: (context, state) => const MerchantChangePasswordScreen(),
            ),
            GoRoute(
              name: Routes.merchantPrivacyPolicies.name,
              path: Routes.merchantPrivacyPolicies.path,
              builder: (context, state) => MerchantPrivacyPoliciesScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
