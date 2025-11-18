import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDetailHistoryScreen extends StatelessWidget {
  const UserDetailHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        BlocBuilder<UserOrderCubit, UserOrderState>(
          builder: (context, state) {
            final order = state.selectedOrder ?? dummyOrder;
            return DefaultAppBar(
              title: order.status.localizedName(context),
              subtitle: order.requestedAt.format('dd MMM yyy - HH:mm'),
              trailing: [
                DefaultText(
                  generateInvoiceCode(order.id),
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ],
            ).asSkeleton(enabled: state.isLoading);
          },
        ),
      ],
      body: Column(
        children: [
          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              return FutureBuilder(
                future: Future.wait([
                  // sl<LocationService>().getPlacemark(lat, lng)
                ]),
                builder: (context, snapshot) {
                  return PickLocationCardWidget(
                    borderColor: context.colorScheme.card,
                    pickup: const PickLocationParameters(
                      enabled: false,
                    ),
                    dropoff: const PickLocationParameters(
                      enabled: false,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
