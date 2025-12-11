import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' show RefreshIndicator;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  /// Load all required data for the home screen
  void _loadData() {
    // Load merchant profile
    context.read<MerchantCubit>().getMine();
    // Load today's analytics
    context.read<MerchantAnalyticsCubit>().getAnalytics(period: 'today');
    // Load availability status
    context.read<MerchantAvailabilityCubit>().getAvailabilityStatus();
  }

  /// Handle online status toggle
  void _onOnlineStatusChanged(bool isOnline) {
    context.read<MerchantAvailabilityCubit>().setOnlineStatus(isOnline);
  }

  /// Handle operating status change
  void _onOperatingStatusChanged(
    MerchantSetOperatingStatusRequestOperatingStatusEnum operatingStatus,
  ) {
    context.read<MerchantAvailabilityCubit>().setOperatingStatus(
      operatingStatus,
    );
  }

  String _formatCurrency(num amount) {
    if (amount >= 1000000) {
      return 'Rp ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return 'Rp ${(amount / 1000).toStringAsFixed(0)}K';
    }
    return 'Rp ${amount.toStringAsFixed(0)}';
  }

  Color _getStatusColor(bool isOnline, String? operatingStatus) {
    if (!isOnline) return Colors.red;
    return switch (operatingStatus) {
      'OPEN' => Colors.green,
      'BREAK' => Colors.orange,
      'MAINTENANCE' => Colors.amber,
      'CLOSED' => Colors.red,
      _ => Colors.neutral,
    };
  }

  String _getStatusLabel(String? operatingStatus) {
    return switch (operatingStatus) {
      'OPEN' => 'Open',
      'BREAK' => 'On Break',
      'MAINTENANCE' => 'Maintenance',
      'CLOSED' => 'Closed',
      _ => 'Unknown',
    };
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => _loadData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section with greeting and availability controls
                _buildHeaderSection(context),
                Gap(16.h),
                // Availability Status Card
                _buildAvailabilityStatusCard(context),
                Gap(16.h),
                // Sales Recap Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    context.l10n.sales_recap,
                    style: context.typography.h2.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Gap(12.h),
                // Today's Stats Cards
                _buildStatsCards(context),
                Gap(16.h),
                // Report Cards
                _buildReportCards(context),
                Gap(16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the header section with greeting and availability toggle
  Widget _buildHeaderSection(BuildContext context) {
    return Container(
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
                    context.l10n.hello(state.mine.value?.name ?? "Folks"),
                    style: context.typography.h1.copyWith(fontSize: 20.sp),
                  ).asSkeleton(enabled: state.mine.isLoading);
                },
              ),
              Row(
                spacing: 4.w,
                children: [
                  // Online/Offline Toggle Button
                  BlocConsumer<
                    MerchantAvailabilityCubit,
                    MerchantAvailabilityState
                  >(
                    listener: (context, state) {
                      // Show toast on status change
                      if (state.setOnlineStatus.isSuccess) {
                        showToast(
                          context: context,
                          builder: (context, overlay) {
                            return SurfaceCard(
                              child: Basic(
                                title: Text(
                                  state.setOnlineStatus.message ??
                                      'Status updated',
                                ),
                                leading: Icon(
                                  state.isOnline
                                      ? LucideIcons.circleCheck
                                      : LucideIcons.circleX,
                                  color: state.isOnline
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      if (state.setOnlineStatus.isFailed) {
                        showToast(
                          context: context,
                          builder: (context, overlay) {
                            return SurfaceCard(
                              child: Basic(
                                title: Text(
                                  state.setOnlineStatus.error?.message ??
                                      'Failed to update status',
                                ),
                                leading: const Icon(
                                  LucideIcons.circleAlert,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      final isOnline = state.isOnline;
                      final isLoading =
                          state.setOnlineStatus.isLoading ||
                          state.availabilityStatus.isLoading;

                      return IconButton(
                        onPressed: isLoading
                            ? null
                            : () => _onOnlineStatusChanged(!isOnline),
                        icon: isLoading
                            ? SizedBox(
                                width: 20.sp,
                                height: 20.sp,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                LucideIcons.power,
                                size: 20.sp,
                                color: isOnline ? Colors.green : Colors.red,
                              ),
                        variance: ButtonStyle.ghostIcon(
                          density: ButtonDensity.compact,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Navigate to notifications screen
                    },
                    icon: Icon(LucideIcons.bell, size: 20.sp),
                    variance: const ButtonStyle.ghostIcon(),
                  ),
                ],
              ),
            ],
          ),
          // Operating Status Display
          BlocBuilder<MerchantAvailabilityCubit, MerchantAvailabilityState>(
            builder: (context, state) {
              final isOnline = state.isOnline;
              final operatingStatus = state.operatingStatus?.value;
              final statusColor = _getStatusColor(isOnline, operatingStatus);
              final activeOrderCount = state.activeOrderCount.toInt();
              final isLoading = state.availabilityStatus.isLoading;

              return Row(
                spacing: 4.w,
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: isLoading ? Colors.neutral : statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    isOnline
                        ? 'Online - ${_getStatusLabel(operatingStatus)}'
                        : 'Offline',
                    style: context.typography.h4.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isLoading ? Colors.neutral : statusColor,
                    ),
                  ).asSkeleton(enabled: isLoading),
                  if (isOnline && activeOrderCount > 0) ...[
                    Gap(8.w),
                    Chip(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LucideIcons.shoppingBag, size: 12.sp),
                          Gap(4.w),
                          Text(
                            '$activeOrderCount active',
                            style: context.typography.small.copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ).asSkeleton(enabled: isLoading);
            },
          ),
        ],
      ),
    );
  }

  /// Build availability status card with operating status selector
  Widget _buildAvailabilityStatusCard(BuildContext context) {
    return BlocBuilder<MerchantAvailabilityCubit, MerchantAvailabilityState>(
      builder: (context, state) {
        final isOnline = state.isOnline;
        final operatingStatus = state.operatingStatus?.value ?? 'CLOSED';
        final isLoading = state.setOperatingStatus.isLoading;

        // Only show operating status selector when online
        if (!isOnline) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Card(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Store Status',
                        style: context.typography.small.copyWith(
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                      Gap(4.h),
                      Select<String>(
                        itemBuilder: (context, item) =>
                            Text(_getStatusLabel(item)),
                        value: operatingStatus,
                        onChanged: isLoading
                            ? null
                            : (String? newValue) {
                                if (newValue != null) {
                                  final status =
                                      MerchantSetOperatingStatusRequestOperatingStatusEnum
                                          .values
                                          .firstWhere(
                                            (e) => e.value == newValue,
                                            orElse: () =>
                                                MerchantSetOperatingStatusRequestOperatingStatusEnum
                                                    .OPEN,
                                          );
                                  _onOperatingStatusChanged(status);
                                }
                              },
                        popup: SelectPopup(
                          autoClose: true,
                          items: SelectItemList(
                            children: [
                              _buildStatusItem(context, 'OPEN'),
                              _buildStatusItem(context, 'BREAK'),
                              _buildStatusItem(context, 'MAINTENANCE'),
                              _buildStatusItem(context, 'CLOSED'),
                            ],
                          ),
                        ).call,
                      ),
                    ],
                  ),
                ),
                if (isLoading)
                  SizedBox(
                    width: 20.sp,
                    height: 20.sp,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  SelectItemButton<String> _buildStatusItem(
    BuildContext context,
    String status,
  ) {
    return SelectItemButton<String>(
      value: status,
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: _getStatusColor(true, status),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(_getStatusLabel(status)),
        ],
      ),
    );
  }

  /// Build stats cards using analytics API data
  Widget _buildStatsCards(BuildContext context) {
    return BlocBuilder<MerchantAnalyticsCubit, MerchantAnalyticsState>(
      builder: (context, state) {
        final isLoading = state.analytics.isLoading;
        final isFailed = state.analytics.isFailed;
        final totalOrders = state.totalOrders;
        final totalRevenue = state.totalRevenue;

        if (isFailed) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Card(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Icon(LucideIcons.circleAlert, size: 32.sp, color: Colors.red),
                  Gap(8.h),
                  Text(
                    state.analytics.error?.message ?? 'Failed to load stats',
                    style: context.typography.p.copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  Gap(8.h),
                  OutlineButton(
                    onPressed: () => context
                        .read<MerchantAnalyticsCubit>()
                        .getAnalytics(period: 'today'),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            spacing: 12.w,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
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
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${totalOrders.toInt()}',
                        style: context.typography.p.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ).asSkeleton(enabled: isLoading),
                    ],
                  ),
                ),
              ),
              Expanded(
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
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        _formatCurrency(totalRevenue),
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
          ),
        );
      },
    );
  }

  /// Build report navigation cards
  Widget _buildReportCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        spacing: 12.w,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Button(
              style: ButtonVariance.ghost.copyWith(
                padding: (context, states, value) => EdgeInsetsGeometry.zero,
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
          Expanded(
            child: Button(
              style: ButtonVariance.ghost.copyWith(
                padding: (context, states, value) => EdgeInsetsGeometry.zero,
              ),
              onPressed: () {
                context.pushNamed(Routes.merchantCommissionReportDetail.name);
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
    );
  }
}
