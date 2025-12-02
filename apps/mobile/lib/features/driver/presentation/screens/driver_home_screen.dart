import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/locator.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DriverCubit>()..init(),
      child: const _DriverHomeView(),
    );
  }
}

class _DriverHomeView extends StatelessWidget {
  const _DriverHomeView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverCubit, DriverState>(
      listener: (context, state) {
        // Show error messages
        if (state.isFailure && state.error != null) {
          showToast(
            context: context,
            builder: (context, overlay) => context.buildToast(
              title: 'Error',
              message: state.error?.message ?? 'An error occurred',
            ),
          );
        }

        // Show success messages
        final message = state.message;
        if (state.isSuccess && message != null && message.isNotEmpty) {
          showToast(
            context: context,
            builder: (context, overlay) =>
                context.buildToast(title: 'Success', message: message),
          );
        }
      },
      builder: (context, state) {
        return MyScaffold(
          headers: [
            DefaultAppBar(
              title: 'Driver Dashboard',
              trailing: [
                IconButton(
                  icon: const Icon(material.Icons.person),
                  variance: ButtonVariance.ghost,
                  onPressed: () => context.push(Routes.driverProfile.path),
                ),
              ],
            ),
          ],
          body: SafeArea(
            child: material.RefreshIndicator(
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
          ),
        );
      },
    );
  }

  Widget _buildWelcomeCard(BuildContext context, DriverState state) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Row(
              children: [
                Icon(
                  material.Icons.waving_hand,
                  size: 24.sp,
                  color: context.colorScheme.primary,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Welcome back!',
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
                        'License Plate: ${driver.licensePlate}',
                        style: context.typography.small.copyWith(
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            material.Icons.star,
                            size: 16.sp,
                            color: material.Colors.amber,
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
      ),
    );
  }

  Widget _buildOnlineToggle(BuildContext context, DriverState state) {
    final isOnline = state.isOnline ?? false;
    final isLoading = state.isLoading;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
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
                      'Driver Status',
                      style: context.typography.h4.copyWith(fontSize: 16.sp),
                    ),
                    Text(
                      isOnline ? 'You are accepting orders' : 'You are offline',
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
                    isOnline
                        ? material.Icons.check_circle
                        : material.Icons.offline_bolt,
                    color: isOnline
                        ? context.colorScheme.primary
                        : context.colorScheme.mutedForeground,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      isOnline
                          ? 'Ready to accept new orders'
                          : 'Toggle on to start receiving orders',
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
      ),
    );
  }

  Widget _buildTodayStats(BuildContext context, DriverState state) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
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
                    icon: material.Icons.attach_money,
                    label: 'Earnings',
                    value: 'Rp ${_formatMoney(state.todayEarnings ?? 0)}',
                    color: material.Colors.green,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildStatItem(
                    context,
                    icon: material.Icons.local_shipping,
                    label: 'Trips',
                    value: '${state.todayTrips ?? 0}',
                    color: material.Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required material.IconData icon,
    required String label,
    required String value,
    required material.Color color,
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
      child: Padding(
        padding: EdgeInsets.all(16.dg),
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
              icon: material.Icons.history,
              label: 'Order History',
              onTap: () => context.push(Routes.driverHistory.path),
            ),
            _buildActionButton(
              context,
              icon: material.Icons.calendar_today,
              label: 'Manage Schedule',
              onTap: () => context.push(Routes.driverKRS.path),
            ),
            // Note: Reviews feature - route and screen not yet implemented
            // Uncomment when driverReviews route is added to router
            // _buildActionButton(
            //   context,
            //   icon: material.Icons.star,
            //   label: 'My Reviews',
            //   onTap: () => context.push(Routes.driverReviews.path),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required material.IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return material.InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
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
              material.Icons.chevron_right,
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
