import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDeliveryPaymentScreen extends StatefulWidget {
  const UserDeliveryPaymentScreen({super.key});

  @override
  State<UserDeliveryPaymentScreen> createState() =>
      _UserDeliveryPaymentScreenState();
}

class _UserDeliveryPaymentScreenState extends State<UserDeliveryPaymentScreen> {
  PaymentMethod method = PaymentMethod.QRIS;
  BankProvider? bankProvider;
  UserGender? gender;

  Future<void> _placeOrder() async {
    final orderCubit = context.read<UserOrderCubit>();
    final deliveryCubit = context.read<UserDeliveryCubit>();
    final orderState = orderCubit.state;

    final pickup = orderState.pickupLocation;
    final dropoff = orderState.dropoffLocation;

    if (pickup == null || dropoff == null) {
      context.showMyToast(
        context.l10n.toast_app_state_corrupted,
        type: ToastType.failed,
      );
      return;
    }

    await orderCubit.placeOrder(
      pickup,
      dropoff,
      OrderType.DELIVERY,
      method,
      gender: gender,
      bankProvider: bankProvider,
      couponCode: deliveryCubit.selectedCouponCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            context.l10n.title_payment_method,
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          leading: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
        ),
      ],
      body: BlocConsumer<UserOrderCubit, UserOrderState>(
        listener: (context, state) {
          // Handle order placement errors
          if (state.currentOrder.isFailure || state.currentPayment.isFailure) {
            final errorMsg =
                state.currentOrder.error?.message ??
                state.currentPayment.error?.message ??
                context.l10n.toast_failed_place_order;
            context.showMyToast(errorMsg, type: ToastType.failed);
          }

          // Handle successful order placement
          if (state.currentOrder.isSuccess &&
              state.currentPayment.isSuccess &&
              state.currentPayment.hasData) {
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
                  Routes.userDeliveryPaymentGateway.name,
                  queryParameters: {'paymentMethod': PaymentMethod.QRIS.name},
                );
              case PaymentMethod.BANK_TRANSFER:
                context.popUntilRoot();
                context.pushNamed(
                  Routes.userDeliveryPaymentGateway.name,
                  queryParameters: {
                    'paymentMethod': PaymentMethod.BANK_TRANSFER.name,
                    'bankProvider': payment.bankProvider?.name,
                  },
                );
              case PaymentMethod.wallet:
                // wallet payment is instant, navigate directly to trip screen
                context.popUntilRoot();
                if (payment.status == TransactionStatus.SUCCESS) {
                  context.pushReplacementNamed(Routes.userDeliveryOnTrip.name);
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
          final estimate = orderState.estimateOrder.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              // Order summary
              if (estimate != null) ...[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.h,
                    children: [
                      DefaultText(
                        context.l10n.label_delivery_details,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      _buildDetailRow(
                        context,
                        context.l10n.label_from,
                        estimate.pickup.vicinity,
                      ),
                      _buildDetailRow(
                        context,
                        context.l10n.label_to,
                        estimate.dropoff.vicinity,
                      ),
                      const Divider(),
                      _buildDetailRow(
                        context,
                        context.l10n.label_total,
                        context.formatCurrency(estimate.summary.totalCost),
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ],
              // Gender preference
              PickGenderWidget(
                value: gender,
                onChanged: (val) => setState(() {
                  gender = val;
                }),
              ),
              // Payment method
              DefaultText(
                context.l10n.title_payment_method,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              BlocBuilder<UserWalletCubit, UserWalletState>(
                builder: (context, walletState) {
                  return PaymentMethodPickerWidget(
                    value: method,
                    onChanged: (val, {BankProvider? bankProvider}) =>
                        setState(() {
                          method = val;
                          this.bankProvider = bankProvider;
                        }),
                    bankProvider: bankProvider,
                    walletBalance:
                        walletState.myWallet.value?.balance.toDouble() ?? 0,
                    totalCost: estimate?.summary.totalCost.toDouble() ?? 0,
                  );
                },
              ),
              const Spacer(),
              // Place order button
              SizedBox(
                width: double.infinity,
                child: Button.primary(
                  enabled: !orderState.currentOrder.isLoading,
                  onPressed: orderState.currentOrder.isLoading
                      ? null
                      : _placeOrder,
                  child: orderState.currentOrder.isLoading
                      ? const Submiting()
                      : Text(context.l10n.button_place_order),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DefaultText(
          label,
          fontSize: 14.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
        Flexible(
          child: Text(
            value,
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.end,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Payment gateway screen for QRIS/Bank Transfer payments
class UserDeliveryPaymentGatewayScreen extends StatelessWidget {
  const UserDeliveryPaymentGatewayScreen({
    required this.paymentMethod,
    this.bankProvider,
    super.key,
  });
  final PaymentMethod paymentMethod;
  final BankProvider? bankProvider;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [DefaultAppBar(title: context.l10n.title_payment_method)],
      body: Column(
        spacing: 8.h,
        children: [
          Text(context.l10n.label_total_fare),
          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              return Text(
                    context.formatCurrency(
                      state.currentPayment.value?.amount ?? dummyAmount,
                    ),
                  )
                  .large(color: context.colorScheme.primary)
                  .asSkeleton(enabled: state.currentOrder.isLoading);
            },
          ),
          BlocConsumer<UserOrderCubit, UserOrderState>(
            listener: (context, state) {
              final payment = state.currentPayment.value;
              if (payment == null) return;

              if (state.currentPayment.isSuccess &&
                  payment.status == TransactionStatus.SUCCESS) {
                context
                  ..showMyToast(
                    context.l10n.text_payment_successful,
                    type: ToastType.success,
                  )
                  ..pushReplacementNamed(Routes.userDeliveryOnTrip.name);
              } else if (state.currentOrder.isFailure ||
                  payment.status == TransactionStatus.FAILED) {
                context.showMyToast(
                  context.l10n.text_payment_failed,
                  type: ToastType.failed,
                );
              }
            },
            builder: (context, state) {
              if (paymentMethod == PaymentMethod.QRIS) {
                return QRISPaymentWidget(
                  payment: state.currentPayment.value ?? dummyPayment,
                  transactionType: TransactionType.PAYMENT,
                  onExpired: () {
                    context.pop();
                  },
                ).asSkeleton(enabled: state.currentOrder.isLoading);
              }
              if (paymentMethod == PaymentMethod.BANK_TRANSFER) {
                return BankTransferPaymentWidget(
                  payment: state.currentPayment.value ?? dummyPayment,
                  bankProvider: bankProvider,
                  onExpired: () {
                    context.pop();
                  },
                ).asSkeleton(enabled: state.currentOrder.isLoading);
              }
              return Alert.destructive(
                title: Text(context.l10n.text_unsupported_payment_method),
                content: Text(
                  context.l10n.text_unsupported_payment_method_description,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
