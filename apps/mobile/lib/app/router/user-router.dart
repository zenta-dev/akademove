part of 'router.dart';

final userRouter = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<BottomNavBarCubit>()),
      BlocProvider(create: (_) => sl<UserHomeCubit>()),
      BlocProvider(create: (_) => sl<UserLocationCubit>()),
      BlocProvider(create: (_) => sl<UserRideCubit>()),
      BlocProvider(create: (_) => sl<UserDeliveryCubit>()),
      BlocProvider(create: (_) => sl<UserMartCubit>()),
      BlocProvider(create: (_) => sl<CartCubit>()..loadCart()),
      BlocProvider(create: (_) => sl<UserWalletCubit>()),
      BlocProvider(create: (_) => sl<UserWalletTopUpCubit>()),
      BlocProvider(create: (_) => sl<UserOrderCubit>()),
      BlocProvider(create: (_) => sl<UserMapCubit>()),
    ],
    child: BottomNavbar(
      shell: navigationShell,
      tabs: [
        BottomNavBarItem(label: context.l10n.home, icon: LucideIcons.house),
        BottomNavBarItem(
          label: context.l10n.history,
          icon: LucideIcons.history,
        ),
        BottomNavBarItem(label: context.l10n.profile, icon: LucideIcons.user),
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
          builder: (context, state, child) => child,
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
              builder: (context, state) => BlocProvider(
                create: (_) => sl<CouponCubit>(),
                child: const UserRideSummaryScreen(),
              ),
            ),
            GoRoute(
              name: Routes.userRidePayment.name,
              path: Routes.userRidePayment.path,
              builder: (context, state) {
                final paymentMethod =
                    state.uri.queryParameters['paymentMethod'];
                final bankProvider = state.uri.queryParameters['bankProvider'];
                return UserRidePaymentScreen(
                  paymentMethod: PaymentMethod.values.firstWhere(
                    (e) => e.name.toLowerCase() == paymentMethod?.toLowerCase(),
                    orElse: () => PaymentMethod.QRIS,
                  ),
                  bankProvider: bankProvider != null
                      ? BankProvider.values.firstWhere(
                          (e) =>
                              e.name.toLowerCase() ==
                              bankProvider.toLowerCase(),
                        )
                      : null,
                );
              },
            ),
            GoRoute(
              name: Routes.userRideOnTrip.name,
              path: Routes.userRideOnTrip.path,
              builder: (context, state) => const UserRideOnTripScreen(),
            ),
            GoRoute(
              name: Routes.userRating.name,
              path: Routes.userRating.path,
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;
                final orderId = extra?['orderId'] as String? ?? '';
                final driverId = extra?['driverId'] as String? ?? '';
                final driverName = extra?['driverName'] as String? ?? 'Driver';

                return BlocProvider(
                  create: (context) => sl<UserReviewCubit>(),
                  child: UserRatingScreen(
                    orderId: orderId,
                    driverId: driverId,
                    driverName: driverName,
                  ),
                );
              },
            ),
          ],
        ),

        //
        ShellRoute(
          builder: (context, state, child) => child,
          routes: [
            GoRoute(
              name: Routes.userDelivery.name,
              path: Routes.userDelivery.path,
              builder: (context, state) => const UserDeliveryScreen(),
            ),
            GoRoute(
              name: Routes.userDeliveryPickup.name,
              path: Routes.userDeliveryPickup.path,
              builder: (context, state) => const UserDeliveryPickupScreen(),
            ),
            GoRoute(
              name: Routes.userDeliveryDropoff.name,
              path: Routes.userDeliveryDropoff.path,
              builder: (context, state) => const UserDeliveryDropoffScreen(),
            ),
            GoRoute(
              name: Routes.userDeliveryDetails.name,
              path: Routes.userDeliveryDetails.path,
              builder: (context, state) => const UserDeliveryDetailsScreen(),
            ),
            GoRoute(
              name: Routes.userDeliverySummary.name,
              path: Routes.userDeliverySummary.path,
              builder: (context, state) => BlocProvider(
                create: (_) => sl<CouponCubit>(),
                child: const UserDeliverySummaryScreen(),
              ),
            ),
            GoRoute(
              name: Routes.userDeliveryDetailsEditDetail.name,
              path: Routes.userDeliveryDetailsEditDetail.path,
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;
                final initialNote = extra?['initialNote'] as OrderNote;
                final place = extra?['place'] as Place;
                final isPickup = extra?['isPickup'] as bool;

                return UserDeliveryEditDetailScreen(
                  initialNote: initialNote,
                  place: place,
                  isPickup: isPickup,
                );
              },
            ),
            GoRoute(
              name: Routes.userDeliveryPayment.name,
              path: Routes.userDeliveryPayment.path,
              builder: (context, state) => const UserDeliveryPaymentScreen(),
            ),
            GoRoute(
              name: Routes.userDeliveryPaymentGateway.name,
              path: Routes.userDeliveryPaymentGateway.path,
              builder: (context, state) {
                final paymentMethod =
                    state.uri.queryParameters['paymentMethod'];
                final bankProvider = state.uri.queryParameters['bankProvider'];
                return UserDeliveryPaymentGatewayScreen(
                  paymentMethod: PaymentMethod.values.firstWhere(
                    (e) => e.name.toLowerCase() == paymentMethod?.toLowerCase(),
                    orElse: () => PaymentMethod.QRIS,
                  ),
                  bankProvider: bankProvider != null
                      ? BankProvider.values.firstWhere(
                          (e) =>
                              e.name.toLowerCase() ==
                              bankProvider.toLowerCase(),
                        )
                      : null,
                );
              },
            ),
            GoRoute(
              name: Routes.userDeliveryOnTrip.name,
              path: Routes.userDeliveryOnTrip.path,
              builder: (context, state) => const UserDeliveryOnTripScreen(),
            ),
          ],
        ),
        GoRoute(
          name: Routes.userMart.name,
          path: Routes.userMart.path,
          builder: (context, state) => const UserMartScreen(),
        ),
        GoRoute(
          name: Routes.userMartCategory.name,
          path: Routes.userMartCategory.path,
          builder: (context, state) => const UserMartCategoryScreen(),
        ),
        GoRoute(
          name: Routes.userListMerchant.name,
          path: Routes.userListMerchant.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<UserMerchantListCubit>(),
            child: const UserMerchantListScreen(),
          ),
        ),
        GoRoute(
          name: Routes.userMerchantDetail.name,
          path: Routes.userMerchantDetail.path,
          builder: (context, state) {
            final merchantId = state.pathParameters['merchantId'] ?? '';
            final extra = state.extra as Map<String, dynamic>?;
            final merchant = extra?['merchant'] as Merchant?;
            final isSummary = extra?['isSummary'] as bool? ?? false;
            if (merchant == null) {
              // Fallback if merchant data not passed
              return const UserMartScreen();
            }

            return BlocProvider(
              create: (_) => sl<UserMerchantDetailCubit>(),
              child: UserMerchantDetailScreen(
                merchantId: merchantId,
                merchant: merchant,
                isSummary: isSummary,
              ),
            );
          },
        ),
        GoRoute(
          name: Routes.userMenuDetail.name,
          path: Routes.userMenuDetail.path,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final menu = extra?['menu'] as MerchantMenu?;
            final merchantName = extra?['merchantName'] as String?;

            if (menu == null || merchantName == null) {
              // Fallback if data not passed correctly
              return const UserMartScreen();
            }

            return UserMenuDetailScreen(menu: menu, merchantName: merchantName);
          },
        ),
        GoRoute(
          name: Routes.userCart.name,
          path: Routes.userCart.path,
          builder: (context, state) => BlocProvider.value(
            value: BlocProvider.of<CartCubit>(context),
            child: const CartScreen(),
          ),
        ),
        GoRoute(
          name: Routes.userOrderConfirm.name,
          path: Routes.userOrderConfirm.path,
          builder: (context, state) => BlocProvider.value(
            value: BlocProvider.of<CartCubit>(context),
            child: OrderConfirmationScreen(
              orderRepository: sl<OrderRepository>(),
            ),
          ),
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
          name: Routes.userWalletTopUpBankTransfer.name,
          path: Routes.userWalletTopUpBankTransfer.path,
          builder: (context, state) =>
              const UserWalletTopUpBankTransferScreen(),
        ),
        GoRoute(
          name: Routes.userWalletTransfer.name,
          path: Routes.userWalletTransfer.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<UserWalletTransferCubit>(),
            child: const UserWalletTransferScreen(),
          ),
        ),
        GoRoute(
          name: Routes.userWalletTransferScan.name,
          path: Routes.userWalletTransferScan.path,
          builder: (context, state) => const UserWalletTransferScanScreen(),
        ),
        GoRoute(
          name: Routes.userWalletMyQr.name,
          path: Routes.userWalletMyQr.path,
          builder: (context, state) => const UserWalletMyQrScreen(),
        ),
        GoRoute(
          name: Routes.userVoucher.name,
          path: Routes.userVoucher.path,
          builder: (context, state) => BlocProvider(
            create: (_) => sl<CouponCubit>(),
            child: const UserVoucherScreen(),
          ),
        ),
        GoRoute(
          name: Routes.userNotifications.name,
          path: Routes.userNotifications.path,
          builder: (context, state) => const NotificationScreen(),
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
        GoRoute(
          name: Routes.userHistoryDetail.name,
          path: Routes.userHistoryDetail.path,
          builder: (context, state) {
            final orderId = state.pathParameters['orderId'];

            return BlocProvider.value(
              value: BlocProvider.of<UserOrderCubit>(context)
                ..maybeGet(orderId),
              child: const UserDetailHistoryScreen(),
            );
          },
        ),
        GoRoute(
          name: Routes.userScheduledOrders.name,
          path: Routes.userScheduledOrders.path,
          builder: (context, state) => BlocProvider.value(
            value: BlocProvider.of<UserOrderCubit>(context),
            child: const ScheduledOrderListScreen(),
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
