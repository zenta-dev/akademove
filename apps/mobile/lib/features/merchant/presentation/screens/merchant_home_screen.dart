import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantHomeScreen extends StatefulWidget {
  const MerchantHomeScreen({super.key});

  @override
  State<MerchantHomeScreen> createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends State<MerchantHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load today's completed orders for sales data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MerchantOrderCubit>().getMine(
        statuses: [OrderStatus.COMPLETED],
      );
    });
  }

  /// Calculate today's transactions and gross sales from completed orders
  ({int transactions, num grossSales}) _calculateTodayStats(
    List<Order> orders,
  ) {
    final now = DateTime.now();
    final todayOrders = orders.where((order) {
      final orderDate = order.updatedAt;
      return orderDate.year == now.year &&
          orderDate.month == now.month &&
          orderDate.day == now.day;
    }).toList();

    final grossSales = todayOrders.fold<num>(
      0,
      (sum, order) => sum + order.totalPrice,
    );

    return (transactions: todayOrders.length, grossSales: grossSales);
  }

  String _formatCurrency(num amount) {
    if (amount >= 1000000) {
      return 'Rp ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return 'Rp ${(amount / 1000).toStringAsFixed(0)}K';
    }
    return 'Rp ${amount.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.dg),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                spacing: 8.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<MerchantCubit, MerchantState>(
                        builder: (context, state) {
                          return Text(
                            context.l10n.hello(
                              state.mine.value?.name ?? "Folks",
                            ),
                            style: context.typography.h1.copyWith(
                              fontSize: 20.sp,
                            ),
                          ).asSkeleton(enabled: state.mine.isLoading);
                        },
                      ),
                      Row(
                        spacing: 4.w,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(LucideIcons.power, size: 20.sp),
                            variance: const ButtonStyle.ghostIcon(),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(LucideIcons.bell, size: 20.sp),
                            variance: const ButtonStyle.ghostIcon(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    spacing: 4.w,
                    children: [
                      Icon(LucideIcons.alarmClock, size: 20.sp),
                      Text(
                        context.l10n.open_today,
                        style: context.typography.h4.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(4.w),
                      // TODO: Replace with merchant operating hours from API
                      // when Merchant model includes openTime/closeTime fields
                      Chip(
                        child: Text(
                          '10.00 - 22.00 ${context.l10n.label_wib}',
                          style: context.typography.h4.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              context.l10n.sales_recap,
              style: context.typography.h2.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            BlocBuilder<MerchantOrderCubit, MerchantOrderState>(
              builder: (context, state) {
                final stats = _calculateTodayStats(state.orders.value ?? []);
                final isLoading = state.orders.isLoading;

                return Row(
                  spacing: 12.w,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (context.mediaQuerySize.width / 2) - 32,
                      child: Card(
                        child: Column(
                          spacing: 4.h,
                          children: [
                            Icon(LucideIcons.shoppingCart, size: 32.sp),
                            Text(
                              context.l10n.today_transaction,
                              style: context.typography.p.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${stats.transactions}',
                              style: context.typography.p.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ).asSkeleton(enabled: isLoading),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (context.mediaQuerySize.width / 2) - 32,
                      child: Card(
                        child: Column(
                          spacing: 4.h,
                          children: [
                            Icon(LucideIcons.circleDollarSign, size: 32.sp),
                            Text(
                              context.l10n.today_gross_sales,
                              style: context.typography.p.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              _formatCurrency(stats.grossSales),
                              style: context.typography.p.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ).asSkeleton(enabled: isLoading),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Row(
              spacing: 12.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (context.mediaQuerySize.width / 2) - 32,
                  child: Button(
                    style: ButtonVariance.ghost.copyWith(
                      padding: (context, states, value) =>
                          EdgeInsetsGeometry.zero,
                    ),
                    onPressed: () {
                      context.pushNamed(Routes.merchantSalesReportDetail.name);
                    },
                    child: Card(
                      child: Column(
                        spacing: 4.h,
                        children: [
                          Icon(LucideIcons.chartArea, size: 32.sp),
                          Text(
                            context.l10n.sales_report,
                            style: context.typography.p.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlineButton(
                              onPressed: () {},
                              density: ButtonDensity.iconDense,
                              child: Row(
                                spacing: 4.w,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(context.l10n.see_detail).xSmall,
                                  Icon(LucideIcons.chevronRight, size: 16.sp),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: (context.mediaQuerySize.width / 2) - 32,
                  child: Button(
                    style: ButtonVariance.ghost.copyWith(
                      padding: (context, states, value) =>
                          EdgeInsetsGeometry.zero,
                    ),
                    onPressed: () {
                      context.pushNamed(
                        Routes.merchantCommissionReportDetail.name,
                      );
                    },
                    child: Card(
                      child: Column(
                        spacing: 4.h,
                        children: [
                          Icon(LucideIcons.badgeDollarSign, size: 32.sp),
                          Text(
                            context.l10n.commission_report,
                            style: context.typography.p.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlineButton(
                              onPressed: () {},
                              density: ButtonDensity.iconDense,
                              child: Row(
                                spacing: 4.w,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(context.l10n.see_detail).xSmall,
                                  Icon(LucideIcons.chevronRight, size: 16.sp),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
