import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserHistoryScreen extends StatelessWidget {
  const UserHistoryScreen({super.key});

  Widget _buildFail(
    BuildContext context, {
    required String message,
  }) => Container(
    width: double.infinity,
    padding: EdgeInsets.only(top: 16.dg),
    child: OopsAlertWidget(
      message: message,
      onRefresh: () => context.read<UserOrderCubit>().list(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        DefaultAppBar(
          title: 'History',
          padding: EdgeInsets.all(16.r),
        ),
      ],
      scrollable: false,
      body: BlocBuilder<UserOrderCubit, UserOrderState>(
        builder: (context, state) {
          return state.whenOr(
            success: (message) {
              final orders = state.orderHistories;

              if (orders == null || orders.isEmpty) {
                return _buildFail(context, message: 'No order history found');
              }

              return ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => Gap(16.h),
                itemCount: orders.length,
                itemBuilder: (context, index) => UserOrderCardWidget(
                  order: orders[index],
                ).sized(width: 1.sw),
              );
            },
            failure: (error) => _buildFail(
              context,
              message: error.message ?? 'An unexpected error occurred',
            ),
            orElse: () => ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => Gap(16.h),
              itemCount: 10,
              itemBuilder: (context, index) => const UserOrderCardWidget(
                order: dummyOrder,
              ).sized(width: double.infinity).asSkeleton(),
            ),
          );
        },
      ),
    );
  }
}

class UserOrderCardWidget extends StatelessWidget {
  const UserOrderCardWidget({required this.order, super.key});
  final Order order;

  Widget _buildDestAddres() {
    if (order.type == OrderType.delivery && order.merchant?.name != null) {
      return DefaultText(
        order.merchant?.name ?? '',
        fontSize: 14.sp,
      );
    }
    return FutureBuilder(
      future: sl<LocationService>().getPlacemark(
        order.pickupLocation.y.toDouble(),
        order.pickupLocation.x.toDouble(),
      ),
      builder: (context, snapshot) {
        final data = snapshot.data;
        return DefaultText(
          '${data?.name ?? ''}, ${data?.street ?? ''}',
          fontSize: 14.sp,
        ).asSkeleton(
          enabled: snapshot.connectionState != ConnectionState.done,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          DefaultText(
            order.createdAt.format('dd MMMM yyyy - HH:mm:ss'),
            // order.requestedAt.format('dd MMMM yyyy'),
            fontSize: 14.sp,
          ),

          Row(
            spacing: 8.w,
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                padding: EdgeInsets.all(4.dg),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (order.type == OrderType.ride) ...[
                      Assets.images.hero.orderRide.image(height: 24.h),
                    ] else if (order.type == OrderType.delivery &&
                        order.merchant != null &&
                        order.merchant?.image != null) ...[
                      CachedNetworkImage(
                        imageUrl:
                            order.merchant?.image ??
                            UrlConstants.placeholderImageUrl,
                        height: 24.h,
                      ),
                    ] else ...[
                      Assets.icons.brand.svg(
                        height: 24.h,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.mutedForeground.withValues(
                            alpha: 0.5,
                          ),
                          BlendMode.dstIn,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 6.w,
                      children: [
                        Flexible(
                          flex: 2,
                          child: _buildDestAddres(),
                        ),
                        DefaultText(
                          context.formatCurrency(order.totalPrice),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),

                    Row(
                      spacing: 6.w,
                      children: [
                        Icon(
                          order.status.icon,
                          color: order.status.color,
                          size: 14.sp,
                        ),
                        DefaultText(
                          order.status.localizedName(context),
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
