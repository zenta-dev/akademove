import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              return RideSummaryWidget(
                summary: state.estimateOrder?.summary,
              ).asSkeleton(enabled: state.isLoading);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PickPaymentMethodWidget(
                  value: method,
                  onChanged: (val) => setState(() {
                    method = val;
                  }),
                ),
              ),
            ],
          ),
          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: Button(
                  style: const ButtonStyle.primary(),
                  enabled: !state.isLoading,
                  onPressed: state.isSuccess
                      ? () async {
                          final pickup = state.estimateOrder?.pickup;
                          final dropoff = state.estimateOrder?.dropoff;
                          if (pickup == null || dropoff == null) {
                            context.showMyToast(
                              'App state corrupted, please restart',
                              type: ToastType.error,
                            );
                            return;
                          }

                          final orderCubit = context.read<UserOrderCubit>();
                          await orderCubit.placeOrder(
                            pickup,
                            dropoff,
                            OrderType.ride,
                            method,
                          );

                          if (mounted && context.mounted) {
                            final order = orderCubit.state.placeOrderResult;
                            if (order == null) {
                              context.showMyToast(
                                'Failed to place order',
                                type: ToastType.error,
                              );
                              return;
                            }
                            if (order.payment.method == PaymentMethod.QRIS) {
                              await context.pushNamed(
                                Routes.userRidePayQRIS.name,
                              );
                            }
                          }
                        }
                      : null,
                  child: state.isLoading
                      ? const Submiting()
                      : const Text('Procced'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
