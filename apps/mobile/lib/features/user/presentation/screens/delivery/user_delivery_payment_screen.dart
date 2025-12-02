import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
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
  PaymentMethod method = PaymentMethod.wallet;
  BankProvider? bankProvider;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            'Payment Method',
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
      body: BlocConsumer<UserDeliveryCubit, UserDeliveryState>(
        listener: (context, state) {
          if (state.isFailure && state.error != null) {
            context.showMyToast(
              state.error?.message ?? 'Failed to place order',
              type: ToastType.failed,
            );
          }
        },
        builder: (context, deliveryState) {
          final estimate = deliveryState.estimate;
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              spacing: 16.h,
              children: [
                DefaultText(
                  'Payment Method',
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
                          walletState.myWallet?.balance.toDouble() ?? 0,
                      totalCost: estimate?.summary.totalCost.toDouble() ?? 0,
                    );
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: Button.primary(
                    enabled: !deliveryState.isLoading,
                    onPressed: () async {
                      final cubit = context.read<UserDeliveryCubit>();
                      final result = await cubit.placeDeliveryOrder(
                        method,
                        bankProvider: bankProvider,
                        couponCode: cubit.selectedCouponCode,
                      );

                      if (result != null && context.mounted) {
                        // For wallet payment, navigate to trip tracking screen
                        if (method == PaymentMethod.wallet &&
                            result.payment.status ==
                                TransactionStatus.SUCCESS) {
                          context
                            ..showMyToast(
                              'Delivery order placed successfully',
                              type: ToastType.success,
                            )
                            ..pushReplacementNamed(Routes.userRideOnTrip.name);
                        } else {
                          // For other payment methods, navigate to home
                          // (payment flow will be handled by payment provider)
                          context
                            ..showMyToast(
                              'Delivery order placed successfully',
                              type: ToastType.success,
                            )
                            ..go(Routes.userHome.path);
                        }
                      }
                    },
                    child: deliveryState.isLoading
                        ? const Submiting()
                        : const Text('Place Order'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
