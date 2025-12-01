import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/features/shared/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' show LucideIcons;

part 'user-router.dart';
part 'driver-router.dart';
part 'merchant-router.dart';
part 'auth-router.dart';

enum Routes {
  authSplash('/auth'),
  authSignIn('/auth/sign-in'),
  authSignUpChoice('/auth/sign-up'),
  authSignUpUser('/auth/sign-up/user'),
  authSignUpDriver('/auth/sign-up/driver'),
  authSignUpMerchant('/auth/sign-up/merchant'),
  authForgotPassword('/auth/forgot-password'),
  authResetPassword('/auth/reset-password'),

  ///
  /// User Routes
  ///
  userHome('/user/home'),
  userRide('/user/home/ride'),
  userRidePickup('/user/home/ride/pickup'),
  userRideDropoff('/user/home/ride/dropoff'),
  userRideSummary('/user/home/ride/summary'),
  userRidePayment('/user/home/ride/payment'),
  userRideOnTrip('/user/home/ride/on-trip'),
  userDriverNearMe('/user/home/driver/near-me'),
  userDelivery('/user/home/delivery'),
  userDeliveryPickup('/user/home/delivery/pickup'),
  userDeliveryDropoff('/user/home/delivery/dropoff'),
  userDeliveryDetails('/user/home/delivery/details'),
  userDeliverySummary('/user/home/delivery/summary'),
  userDeliveryPayment('/user/home/delivery/payment'),
  userMart('/user/home/mart'),
  userMartCategory('/user/home/mart/category'),
  userWallet('/user/home/wallet'),
  userWalletTopUp('/user/home/wallet/topup'),
  userWalletTopUpInsertAmount('/user/home/wallet/topup/insert-amount'),
  userWalletTopUpQRIS('/user/home/wallet/topup/qris'),
  userVoucher('/user/home/voucher'),

  userHistory('/user/history'),
  userHistoryDetail('/user/history/:orderId'),

  userProfile('/user/profile'),
  userDetailProfile('/user/profile/detail'),
  userEditProfile('/user/profile/edit'),
  userChangePassword('/user/profile/change-password'),

  ///
  /// Driver Routes
  ///
  driverHome('/driver/home'),
  driverOrderDetail('/driver/order/:orderId'),
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
  merchantCreateMenu('/merchant/create/menu'),
  merchantEditMenu('/merchant/edit/menu'),
  merchantMenu('/merchant/menu'),
  merchantMenuDetail('/merchant/menu/detail'),
  merchantProfile('/merchant/profile'),
  merchantSetUpOutlet('/merchant/set/up/outlet'),
  merchantEditProfile('/merchant/edit/profile'),
  merchantChangePassword('/merchant/change/password'),

  ///
  /// Shared Routes
  ///
  privacyPolicies('/privacy-policies');

  const Routes(this.path);
  final String path;
}

final router = GoRouter(
  initialLocation: Routes.authSplash.path,
  routes: [
    authRouter,
    userRouter,
    driverRouter,
    merchantRouter,
    GoRoute(
      name: Routes.privacyPolicies.name,
      path: Routes.privacyPolicies.path,
      builder: (context, state) => const PrivacyPoliciesScreen(),
    ),
  ],
);
