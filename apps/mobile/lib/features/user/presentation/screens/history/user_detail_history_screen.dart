import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDetailHistoryScreen extends StatelessWidget {
  const UserDetailHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        BlocBuilder<UserOrderCubit, UserOrderState>(
          builder: (context, state) {
            final order = state.selectedOrder.value ?? dummyOrder;
            return DefaultAppBar(
              title: order.status.localizedName(context),
              subtitle: order.requestedAt.format('dd MMM yyy - HH:mm'),
              trailing: [
                DefaultText(
                  '#${generateOrderCode(order.id)}',
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ],
            ).asSkeleton(enabled: state.selectedOrder.isLoading);
          },
        ),
      ],
      body: BlocBuilder<UserOrderCubit, UserOrderState>(
        builder: (context, state) {
          final order = state.selectedOrder.value;

          return Column(
            children: [
              FutureBuilder(
                future: Future.wait([
                  // sl<LocationService>().getPlacemark(lat, lng)
                ]),
                builder: (context, snapshot) {
                  return PickLocationCardWidget(
                    borderColor: context.colorScheme.card,
                    pickup: const PickLocationParameters(enabled: false),
                    dropoff: const PickLocationParameters(enabled: false),
                  );
                },
              ),
              // Show rating button for completed orders with assigned driver
              if (order != null &&
                  order.status == OrderStatus.COMPLETED &&
                  order.driverId != null)
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: Button.primary(
                      onPressed: () async {
                        final result = await context.pushNamed(
                          Routes.userRating.name,
                          extra: {
                            'orderId': order.id,
                            'driverId': order.driverId!,
                            'driverName': context.l10n.text_driver,
                          },
                        );

                        // Refresh order details if rating was submitted
                        if (result == true && context.mounted) {
                          context.showMyToast(
                            context.l10n.text_thank_you_rating,
                            type: ToastType.success,
                          );
                        }
                      },
                      child: Text(context.l10n.text_rate_this_order),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
