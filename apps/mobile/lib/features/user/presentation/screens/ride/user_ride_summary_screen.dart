import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
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
  DateTime? scheduledAt;

  @override
  void initState() {
    super.initState();
    // Load eligible coupons when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderState = context.read<UserOrderCubit>().state;
      final totalAmount =
          orderState.estimateOrder.value?.summary.totalCost ?? 0;
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
    final pickup = state.estimateOrder.value?.pickup;
    final dropoff = state.estimateOrder.value?.dropoff;
    if (pickup == null || dropoff == null) {
      context.showMyToast(
        context.l10n.toast_app_state_corrupted,
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

    final order = orderCubit.state.currentOrder.value;
    final payment = orderCubit.state.currentPayment.value;

    if (order == null) {
      context.showMyToast(
        context.l10n.toast_failed_place_order,
        type: ToastType.failed,
      );
      return;
    }

    // Pop the summary screen
    context.pop();

    if (!mounted || !context.mounted) return;

    // Navigate based on payment method
    if (payment == null) {
      context.showMyToast(
        context.l10n.toast_payment_info_not_available,
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
      case PaymentMethod.wallet:
        // wallet payment is instant, navigate directly to trip screen
        if (payment.status == TransactionStatus.SUCCESS) {
          context.pushReplacementNamed(Routes.userRideOnTrip.name);
        } else {
          context.showMyToast(
            context.l10n.toast_wallet_payment_failed,
            type: ToastType.failed,
          );
        }
    }
  }

  Future<void> placeScheduledOrder(UserOrderState state) async {
    final pickup = state.estimateOrder.value?.pickup;
    final dropoff = state.estimateOrder.value?.dropoff;
    if (pickup == null || dropoff == null) {
      context.showMyToast(
        context.l10n.toast_app_state_corrupted,
        type: ToastType.failed,
      );
      return;
    }

    final scheduledTime = scheduledAt;
    if (scheduledTime == null) {
      context.showMyToast(
        context.l10n.please_select_schedule_time,
        type: ToastType.failed,
      );
      return;
    }

    final orderCubit = context.read<UserOrderCubit>();
    final result = await orderCubit.placeScheduledOrder(
      pickup,
      dropoff,
      OrderType.RIDE,
      method,
      scheduledTime,
      gender: gender,
      bankProvider: bankProvider,
      couponCode: selectedCoupon?.code,
    );

    if (!mounted || !context.mounted) return;

    if (result == null) {
      context.showMyToast(
        context.l10n.toast_failed_place_order,
        type: ToastType.failed,
      );
      return;
    }

    context.showMyToast(
      context.l10n.scheduled_order_created,
      type: ToastType.success,
    );

    // Pop back and navigate to scheduled orders
    context.pop();
    if (!mounted || !context.mounted) return;
    context.pushNamed(Routes.userScheduledOrders.name);
  }

  Future<void> _selectScheduleDateTime() async {
    final now = DateTime.now();
    final minDate = now.add(const Duration(minutes: 30));
    final maxDate = now.add(const Duration(days: 7));
    final currentScheduled = scheduledAt;

    final pickedDate = await material.showDatePicker(
      context: context,
      initialDate: currentScheduled ?? minDate,
      firstDate: minDate,
      lastDate: maxDate,
    );

    if (pickedDate == null || !mounted) return;

    final pickedTime = await material.showTimePicker(
      context: context,
      initialTime: currentScheduled != null
          ? material.TimeOfDay.fromDateTime(currentScheduled)
          : material.TimeOfDay.fromDateTime(minDate),
    );

    if (pickedTime == null || !mounted) return;

    final newDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Validate
    final validMinTime = DateTime.now().add(const Duration(minutes: 30));
    if (newDateTime.isBefore(validMinTime)) {
      if (mounted) {
        context.showMyToast(context.l10n.schedule_time_too_soon);
      }
      return;
    }

    setState(() {
      scheduledAt = newDateTime;
    });
  }

  String _formatScheduledAt(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [DefaultAppBar(title: context.l10n.title_trip_details)],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [
          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              return PickLocationCardWidget(
                pickup: PickLocationParameters(
                  enabled: false,
                  text: state.estimateOrder.value?.pickup.vicinity,
                ),
                dropoff: PickLocationParameters(
                  enabled: false,
                  text: state.estimateOrder.value?.dropoff.vicinity,
                ),
              ).asSkeleton(enabled: state.currentOrder.isLoading);
            },
          ),
          PickGenderWidget(
            value: gender,
            onChanged: (val) => setState(() {
              gender = val;
            }),
          ),
          DefaultText(
            context.l10n.label_payment_method,
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
                              walletState.myWallet.value?.balance.toDouble() ??
                              0,
                          totalCost:
                              orderState.estimateOrder.value?.summary.totalCost
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
                  material.showModalBottomSheet(
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
                                    cubit
                                        .state
                                        .eligibleCoupons
                                        .value
                                        ?.bestDiscountAmount ??
                                    0;
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
                            ? context.l10n.text_apply_coupon
                            : context.l10n.text_coupon_applied(
                                selectedCoupon?.code ?? "",
                              ),
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
          // Schedule for later option
          OutlineButton(
            onPressed: _selectScheduleDateTime,
            child: Row(
              children: [
                Icon(LucideIcons.calendarClock, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(
                        builder: (context) {
                          final scheduled = scheduledAt;
                          return Text(
                            scheduled != null
                                ? context.l10n.scheduled_for(
                                    _formatScheduledAt(scheduled),
                                  )
                                : context.l10n.schedule_for_later,
                            style: context.typography.p.copyWith(
                              fontSize: 14.sp,
                            ),
                          );
                        },
                      ),
                      if (scheduledAt != null)
                        Text(
                          context.l10n.tap_to_change_schedule,
                          style: context.typography.small.copyWith(
                            fontSize: 12.sp,
                            color: context.colorScheme.mutedForeground,
                          ),
                        ),
                    ],
                  ),
                ),
                if (scheduledAt != null)
                  IconButton(
                    icon: Icon(LucideIcons.x, size: 16.sp),
                    onPressed: () => setState(() => scheduledAt = null),
                    variance: ButtonVariance.ghost,
                  )
                else
                  Icon(LucideIcons.chevronRight, size: 20.sp),
              ],
            ),
          ),
          DefaultText(
            context.l10n.label_payment_summary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              return RideSummaryWidget(
                summary: state.estimateOrder.value?.summary,
                discountAmount: discountAmount,
              ).asSkeleton(enabled: state.currentOrder.isLoading);
            },
          ),

          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              final hasEstimate = state.estimateOrder.value != null;
              final canProceed =
                  state.estimateOrder.isSuccess &&
                  hasEstimate &&
                  !state.currentOrder.isLoading;

              // If scheduled, show schedule button, otherwise show proceed button
              if (scheduledAt != null) {
                return SizedBox(
                  width: double.infinity,
                  child: Button(
                    style: const ButtonStyle.primary(),
                    enabled: canProceed,
                    onPressed: canProceed
                        ? () => placeScheduledOrder(state)
                        : null,
                    child: state.currentOrder.isLoading
                        ? const Submiting()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 8.w,
                            children: [
                              const Icon(LucideIcons.calendarCheck),
                              Text(context.l10n.schedule_now),
                            ],
                          ),
                  ),
                );
              }

              return SizedBox(
                width: double.infinity,
                child: Button(
                  style: const ButtonStyle.primary(),
                  enabled: canProceed,
                  onPressed: canProceed ? () => placeOrder(state) : null,
                  child: state.currentOrder.isLoading
                      ? const Submiting()
                      : Text(context.l10n.button_proceed),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
