import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
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

    if (!mounted || !context.mounted) return;
    context.popUntilRoot();
    context.pushNamed(Routes.userScheduledOrders.name);
  }

  void _selectScheduleDateTime() {
    final now = DateTime.now();
    final minDate = now.add(const Duration(minutes: 30));
    final maxDate = now.add(const Duration(days: 7));
    final currentScheduled = scheduledAt;

    var tempDate = currentScheduled ?? minDate;
    var tempTime = currentScheduled != null
        ? TimeOfDay.fromDateTime(currentScheduled)
        : TimeOfDay.fromDateTime(minDate);

    DateState dateStateBuilder(DateTime date) {
      final dateOnly = DateTime(date.year, date.month, date.day);
      final minDateOnly = DateTime(minDate.year, minDate.month, minDate.day);
      final maxDateOnly = DateTime(maxDate.year, maxDate.month, maxDate.day);

      if (dateOnly.isBefore(minDateOnly) || dateOnly.isAfter(maxDateOnly)) {
        return DateState.disabled;
      }
      return DateState.enabled;
    }

    openDrawer(
      context: context,
      position: OverlayPosition.bottom,
      builder: (drawerContext) => StatefulBuilder(
        builder: (context, setDrawerState) => Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              Text(
                this.context.l10n.schedule_for_later,
                style: this.context.typography.h3.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),

              // Date picker
              Row(
                children: [
                  Icon(LucideIcons.calendar, size: 20.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.context.l10n.schedule_date,
                          style: this.context.typography.small.copyWith(
                            fontSize: 12.sp,
                            color: this.context.colorScheme.mutedForeground,
                          ),
                        ),
                        DatePicker(
                          value: tempDate,
                          mode: PromptMode.dialog,
                          dialogTitle: Text(this.context.l10n.schedule_date),
                          stateBuilder: dateStateBuilder,
                          onChanged: (value) {
                            if (value != null) {
                              setDrawerState(() => tempDate = value);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Time picker
              Row(
                children: [
                  Icon(LucideIcons.clock, size: 20.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.context.l10n.schedule_time,
                          style: this.context.typography.small.copyWith(
                            fontSize: 12.sp,
                            color: this.context.colorScheme.mutedForeground,
                          ),
                        ),
                        TimePicker(
                          value: tempTime,
                          mode: PromptMode.dialog,
                          dialogTitle: Text(this.context.l10n.schedule_time),
                          onChanged: (value) {
                            setDrawerState(() {
                              tempTime = value ?? TimeOfDay.now();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Info text
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: this.context.colorScheme.muted.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.info,
                      size: 16.sp,
                      color: this.context.colorScheme.mutedForeground,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        this.context.l10n.min_schedule_time,
                        style: this.context.typography.small.copyWith(
                          fontSize: 12.sp,
                          color: this.context.colorScheme.mutedForeground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Action buttons
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    child: OutlineButton(
                      onPressed: () => closeDrawer(drawerContext),
                      child: Text(this.context.l10n.cancel),
                    ),
                  ),
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () {
                        final newDateTime = DateTime(
                          tempDate.year,
                          tempDate.month,
                          tempDate.day,
                          tempTime.hour,
                          tempTime.minute,
                        );

                        // Validate using local time
                        final validMinTime = DateTime.now().add(
                          const Duration(minutes: 30),
                        );
                        if (newDateTime.isBefore(validMinTime)) {
                          this.context.showMyToast(
                            this.context.l10n.schedule_time_too_soon,
                          );
                          return;
                        }

                        setState(() {
                          // Convert to UTC for server consistency
                          scheduledAt = newDateTime.toUtc();
                        });
                        closeDrawer(drawerContext);
                      },
                      child: Text(this.context.l10n.confirm_schedule),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatScheduledAt(DateTime dt) {
    // Convert UTC to local time for display
    final local = dt.toLocal();
    return '${local.day}/${local.month}/${local.year} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }

  void _showCouponSelector() {
    final couponCubit = context.read<CouponCubit>();
    openDrawer(
      context: context,
      position: OverlayPosition.bottom,
      expands: true,
      builder: (drawerContext) => BlocProvider.value(
        value: couponCubit,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: CouponSelectorWidget(
            onCouponSelected: (coupon) {
              setState(() {
                selectedCoupon = coupon;
                if (coupon != null) {
                  discountAmount =
                      couponCubit
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
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scrollable: true,
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
          BlocConsumer<UserOrderCubit, UserOrderState>(
            listener: (context, state) {
              if (state.currentOrder.isFailure ||
                  state.currentPayment.isFailure) {
                final errorMsg =
                    state.currentOrder.error?.message ??
                    state.currentPayment.error?.message ??
                    context.l10n.toast_failed_place_order;
                context.showMyToast(errorMsg, type: ToastType.failed);
              }

              if (state.currentOrder.isSuccess &&
                  state.currentPayment.isSuccess &&
                  state.currentPayment.hasData) {
                setState(() {
                  scheduledAt = null;
                });

                final payment = state.currentPayment.value;

                if (payment == null) {
                  context.showMyToast(
                    context.l10n.toast_payment_info_not_available,
                    type: ToastType.failed,
                  );
                  return;
                }

                switch (payment.method) {
                  case PaymentMethod.QRIS:
                    context.popUntilRoot();
                    context.pushNamed(
                      Routes.userRidePayment.name,
                      queryParameters: {
                        'paymentMethod': PaymentMethod.QRIS.name,
                      },
                    );
                  case PaymentMethod.BANK_TRANSFER:
                    context.popUntilRoot();
                    context.pushNamed(
                      Routes.userRidePayment.name,
                      queryParameters: {
                        'paymentMethod': PaymentMethod.BANK_TRANSFER.name,
                        'bankProvider': payment.bankProvider?.name,
                      },
                    );
                  case PaymentMethod.wallet:
                    // wallet payment is instant, navigate directly to trip screen
                    if (payment.status == TransactionStatus.SUCCESS) {
                      context.popUntilRoot();
                      context.pushNamed(Routes.userRideOnTrip.name);
                    } else {
                      context.showMyToast(
                        context.l10n.toast_wallet_payment_failed,
                        type: ToastType.failed,
                      );
                    }
                }
              }
            },
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
                onPressed: _showCouponSelector,
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
