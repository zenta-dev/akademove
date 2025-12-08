import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/features/shared/_export.dart';
import 'package:akademove/features/user/presentation/cubits/user_merchant_detail_cubit.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' show LucideIcons;

part 'auth-router.dart';
part 'driver-router.dart';
part 'merchant-router.dart';
part 'user-router.dart';

enum Routes {
  authSplash('/auth'),
  authSignIn('/auth/sign-in'),
  authSignUpChoice('/auth/sign-up'),
  authSignUpUser('/auth/sign-up/user'),
  authSignUpDriver('/auth/sign-up/driver'),
  authSignUpMerchant('/auth/sign-up/merchant'),
  authForgotPassword('/auth/forgot-password'),
  authResetPassword('/auth/reset-password'),
  authEmailVerificationPending('/auth/email-verification-pending'),
  authVerifyEmail('/auth/verify-email'),
  driverQuiz('/auth/driver-quiz'),
  driverApproval('/auth/driver-approval'),

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
  userRating('/user/home/ride/rating'),
  userDriverNearMe('/user/home/driver/near-me'),
  userDelivery('/user/home/delivery'),
  userDeliveryPickup('/user/home/delivery/pickup'),
  userDeliveryDropoff('/user/home/delivery/dropoff'),
  userDeliveryDetails('/user/home/delivery/details'),
  userDeliverySummary('/user/home/delivery/summary'),
  userDeliveryPayment('/user/home/delivery/payment'),
  userMart('/user/home/mart'),
  userMerchantDetail('/user/home/merchant/:merchantId'),
  userMartCategory('/user/home/mart/category'),
  userMenuDetail('/user/home/mart/menu/:menuId'),
  userCart('/user/home/cart'),
  userOrderConfirm('/user/home/cart/confirm'),
  userListMerchant('/user/home/mart/list-merchant'),
  userWallet('/user/home/wallet'),
  userWalletTopUp('/user/home/wallet/topup'),
  userWalletTopUpInsertAmount('/user/home/wallet/topup/insert-amount'),
  userWalletTopUpQRIS('/user/home/wallet/topup/qris'),
  userWalletTopUpBankTransfer('/user/home/wallet/topup/bank-transfer'),
  userVoucher('/user/home/voucher'),
  userNotifications('/user/home/notifications'),

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
  driverEarnings('/driver/earnings'),
  driverLeaderboard('/driver/leaderboard'),
  driverReviews('/driver/reviews'),
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
  privacyPolicies('/privacy-policies'),
  termsOfService('/terms-of-service'),
  faq('/faq');

  const Routes(this.path);
  final String path;
}

final router = GoRouter(
  initialLocation: Routes.authSplash.path,
  debugLogDiagnostics: true,
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
    GoRoute(
      name: Routes.termsOfService.name,
      path: Routes.termsOfService.path,
      builder: (context, state) => const TermsOfServiceScreen(),
    ),
    GoRoute(
      name: Routes.faq.name,
      path: Routes.faq.path,
      builder: (context, state) => const FaqScreen(),
    ),
  ],
);
