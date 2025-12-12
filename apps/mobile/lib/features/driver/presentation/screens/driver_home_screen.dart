import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DriverCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverCubit, DriverState>(
      listener: (context, state) {
        if (state.initResult.isFailure) {
          context.showMyToast(
            state.initResult.error?.message ?? context.l10n.an_error_occurred,
            type: ToastType.failed,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          headers: [
            DefaultAppBar(
              padding: EdgeInsets.all(16.r),
              title: context.l10n.driver_dashboard,
            ),
          ],
          child: RefreshTrigger(
            onRefresh: () => context.read<DriverCubit>().init(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(16.dg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 20.h,
                  children: [
                    _buildWelcomeCard(context, state),
                    _buildOnlineToggle(context, state),
                    _buildTodayStats(context, state),
                    _buildQuickActions(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeCard(BuildContext context, DriverState state) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.hand,
                size: 24.sp,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  context.l10n.hello(state.driver?.user?.name ?? 'Folks'),
                  style: context.typography.h4.copyWith(fontSize: 18.sp),
                ),
              ),
            ],
          ),
          if (state.driver != null)
            Builder(
              builder: (context) {
                final driver = state.driver;
                if (driver == null) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: [
                    Text(
                      '${context.l10n.license_plate} ${driver.licensePlate}',
                      style: context.typography.small.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.star,
                          size: 16.sp,
                          color: const Color(0xFFFFC107),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${driver.rating.toStringAsFixed(1)} rating',
                          style: context.typography.small,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildOnlineToggle(BuildContext context, DriverState state) {
    final isOnline = state.driver?.isOnline ?? false;
    final isLoading = state.initResult.isLoading;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Text(
                    context.l10n.driver_status,
                    style: context.typography.h4.copyWith(fontSize: 16.sp),
                  ),
                  Text(
                    isOnline
                        ? context.l10n.accepting_orders
                        : context.l10n.offline,
                    style: context.typography.small.copyWith(
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
              Switch(
                value: isOnline,
                onChanged: isLoading
                    ? null
                    : (_) => context.read<DriverCubit>().toggleOnlineStatus(),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12.dg),
            decoration: BoxDecoration(
              color: isOnline
                  ? context.colorScheme.primary.withValues(alpha: 0.1)
                  : context.colorScheme.muted,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  isOnline ? LucideIcons.circleCheck : LucideIcons.wifiOff,
                  color: isOnline
                      ? context.colorScheme.primary
                      : context.colorScheme.mutedForeground,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    isOnline
                        ? context.l10n.ready_to_accept_new_orders
                        : context.l10n.toggle_on_to_start_receiving_orders,
                    style: context.typography.small.copyWith(
                      color: isOnline
                          ? context.colorScheme.primary
                          : context.colorScheme.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayStats(BuildContext context, DriverState state) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [
          Text(
            'Today\'s Performance',
            style: context.typography.h4.copyWith(fontSize: 16.sp),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  icon: LucideIcons.dollarSign,
                  label: context.l10n.earnings,
                  value: 'Rp ${_formatMoney(state.todayEarnings ?? 0)}',
                  color: const Color(0xFF4CAF50),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildStatItem(
                  context,
                  icon: LucideIcons.truck,
                  label: context.l10n.trips,
                  value: '${state.todayTrips ?? 0}',
                  color: const Color(0xFF2196F3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(12.dg),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Icon(icon, color: color, size: 24.sp),
          Text(
            label,
            style: context.typography.small.copyWith(
              color: context.colorScheme.mutedForeground,
            ),
          ),
          Text(
            value,
            style: context.typography.h4.copyWith(
              fontSize: 18.sp,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            'Quick Actions',
            style: context.typography.h4.copyWith(fontSize: 16.sp),
          ),
          _buildActionButton(
            context,
            icon: LucideIcons.trophy,
            label: context.l10n.leadeboard_and_badges,
            onTap: () => context.pushNamed(Routes.driverLeaderboard.name),
          ),
          _buildActionButton(
            context,
            icon: LucideIcons.star,
            label: context.l10n.my_reviews,
            onTap: () => context.pushNamed(Routes.driverReviews.name),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GhostButton(
      onPressed: onTap,
      child: Card(
        child: Row(
          children: [
            Icon(icon, size: 20.sp, color: context.colorScheme.primary),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: context.typography.small.copyWith(fontSize: 14.sp),
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 20.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }

  String _formatMoney(num amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount.toStringAsFixed(0);
  }
}
