import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' show showModalBottomSheet;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserRideSummaryScreen extends StatefulWidget {
  const UserRideSummaryScreen({super.key});

  @override
  State<UserRideSummaryScreen> createState() => _UserRideSummaryScreenState();
}

class _UserRideSummaryScreenState extends State<UserRideSummaryScreen> {
  PaymentMethod method = PaymentMethod.QRIS;
  UserGender? gender;
  BankProvider? bankProvider;
  Coupon? selectedCoupon;
  num discountAmount = 0;

  @override
  void initState() {
    super.initState();
    // Load eligible coupons when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderState = context.read<UserOrderCubit>().state;
      final totalAmount = orderState.estimateOrder?.summary.totalCost ?? 0;
      if (totalAmount > 0) {
        context.read<CouponCubit>().loadEligibleCoupons(
          serviceType: OrderType.RIDE,
          totalAmount: totalAmount,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> placeOrder(UserOrderState state) async {
    final pickup = state.estimateOrder?.pickup;
    final dropoff = state.estimateOrder?.dropoff;
    if (pickup == null || dropoff == null) {
      context.showMyToast(
        'App state corrupted, please restart',
        type: ToastType.failed,
      );
      return;
    }

    final orderCubit = context.read<UserOrderCubit>();
    await orderCubit.placeOrder(
      pickup,
      dropoff,
      OrderType.RIDE,
      method,
      gender: gender,
      bankProvider: bankProvider,
      couponCode: selectedCoupon?.code,
    );

    if (!mounted || !context.mounted) return;

    final order = orderCubit.state.currentOrder;
    final payment = orderCubit.state.currentPayment;

    if (order == null) {
      context.showMyToast('Failed to place order', type: ToastType.failed);
      return;
    }

    // Pop the summary screen
    context.pop();

    if (!mounted || !context.mounted) return;

    // Navigate based on payment method
    if (payment == null) {
      context.showMyToast(
        'Payment information not available',
        type: ToastType.failed,
      );
      return;
    }

    switch (payment.method) {
      case PaymentMethod.QRIS:
        await context.pushNamed(
          Routes.userRidePayment.name,
          queryParameters: {'paymentMethod': PaymentMethod.QRIS.name},
        );
      case PaymentMethod.BANK_TRANSFER:
        await context.pushNamed(
          Routes.userRidePayment.name,
          queryParameters: {
            'paymentMethod': PaymentMethod.BANK_TRANSFER.name,
            'bankProvider': payment.bankProvider?.name,
          },
        );
      case PaymentMethod.WALLET:
        // Wallet payment is instant, navigate directly to trip screen
        if (payment.status == TransactionStatus.SUCCESS) {
          context.pushReplacementNamed(Routes.userRideOnTrip.name);
        } else {
          context.showMyToast('Wallet payment failed', type: ToastType.failed);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: const [DefaultAppBar(title: 'Trip Details')],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [
          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              return PickLocationCardWidget(
                pickup: PickLocationParameters(
                  enabled: false,
                  text: state.estimateOrder?.pickup.vicinity,
                ),
                dropoff: PickLocationParameters(
                  enabled: false,
                  text: state.estimateOrder?.dropoff.vicinity,
                ),
              ).asSkeleton(enabled: state.isLoading);
            },
          ),
          PickGenderWidget(
            value: gender,
            onChanged: (val) => setState(() {
              gender = val;
            }),
          ),
          DefaultText(
            'Payment Method',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, orderState) {
              return BlocBuilder<UserWalletCubit, UserWalletState>(
                builder: (context, walletState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: PaymentMethodPickerWidget(
                          value: method,
                          onChanged: (val, {BankProvider? bankProvider}) =>
                              setState(() {
                                method = val;
                                this.bankProvider = bankProvider;
                              }),
                          bankProvider: bankProvider,
                          walletBalance:
                              walletState.myWallet?.balance.toDouble() ?? 0,
                          totalCost:
                              orderState.estimateOrder?.summary.totalCost
                                  .toDouble() ??
                              0,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          // Coupon selector
          BlocBuilder<CouponCubit, CouponState>(
            builder: (context, couponState) {
              return OutlineButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => BlocProvider.value(
                      value: context.read<CouponCubit>(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: CouponSelectorWidget(
                          onCouponSelected: (coupon) {
                            setState(() {
                              selectedCoupon = coupon;
                              if (coupon != null) {
                                final cubit = context.read<CouponCubit>();
                                discountAmount =
                                    cubit.state.data?.bestDiscountAmount ?? 0;
                              } else {
                                discountAmount = 0;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        selectedCoupon == null
                            ? 'Apply Coupon'
                            : 'Coupon: ${selectedCoupon!.code}',
                      ),
                    ),
                    Icon(
                      selectedCoupon == null
                          ? LucideIcons.chevronRight
                          : LucideIcons.check,
                      size: 16,
                    ),
                  ],
                ),
              );
            },
          ),
          DefaultText(
            'Payment Summary',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              return RideSummaryWidget(
                summary: state.estimateOrder?.summary,
                discountAmount: discountAmount,
              ).asSkeleton(enabled: state.isLoading);
            },
          ),

          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              final hasEstimate = state.estimateOrder != null;
              final canProceed =
                  state.isSuccess && hasEstimate && !state.isLoading;

              return SizedBox(
                width: double.infinity,
                child: Button(
                  style: const ButtonStyle.primary(),
                  enabled: canProceed,
                  onPressed: canProceed ? () => placeOrder(state) : null,
                  child: state.isLoading
                      ? const Submiting()
                      : const Text('Proceed'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
