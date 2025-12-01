import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
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
    // Initialize driver home - loads profile and stats
    context.read<DriverHomeCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DriverHomeCubit, DriverHomeState>(
      listener: (context, state) {
        // Show incoming order notification
        if (state.incomingOrder != null && state.isOnline) {
          _showIncomingOrderDialog(context, state.incomingOrder!);
        }

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
        if (state.message != null && state.message!.isNotEmpty) {
          showToast(
            context: context,
            builder: (context, overlay) =>
                context.buildToast(title: 'Success', message: state.message!),
          );
        }
      },
      child: MyScaffold(
        body: SafeArea(
          child: material.RefreshIndicator(
            onRefresh: () => context.read<DriverHomeCubit>().init(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(16.dg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20.h,
                  children: [
                    _buildHeader(context),
                    _buildOnlineToggle(context),
                    _buildTodayStats(context),
                    _buildQuickActions(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  'Hello, Driver',
                  style: context.typography.h4.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                    return Text(
                      authState.data?.name ?? 'Loading...',
                      style: context.typography.h1.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ).asSkeleton(enabled: state.isLoading);
                  },
                ),
              ],
            ),
            Row(
              spacing: 8.w,
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: Navigate to notifications
                  },
                  icon: Icon(LucideIcons.bell, size: 24.sp),
                  variance: ButtonVariance.ghost,
                ),
                IconButton(
                  onPressed: () {
                    context.goNamed(Routes.driverProfile.name);
                  },
                  icon: Icon(LucideIcons.user, size: 24.sp),
                  variance: ButtonVariance.ghost,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildOnlineToggle(BuildContext context) {
    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      builder: (context, state) {
        final isOnline = state.isOnline;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.dg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isOnline
                  ? [const Color(0xFF4CAF50), const Color(0xFF66BB6A)]
                  : [const Color(0xFF9E9E9E), const Color(0xFFBDBDBD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color:
                    (isOnline
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFF9E9E9E))
                        .withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.h,
                children: [
                  Row(
                    spacing: 8.w,
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: material.Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: isOnline
                              ? [
                                  BoxShadow(
                                    color: material.Colors.white.withValues(
                                      alpha: 0.5,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      Text(
                        isOnline ? 'You are Online' : 'You are Offline',
                        style: context.typography.h3.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: material.Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    isOnline
                        ? 'Ready to accept orders'
                        : 'Toggle to start accepting orders',
                    style: context.typography.small.copyWith(
                      fontSize: 14.sp,
                      color: material.Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
              Switch(
                value: isOnline,
                onChanged: state.isLoading
                    ? null
                    : (value) {
                        context.read<DriverHomeCubit>().toggleOnlineStatus();
                      },
              ),
            ],
          ),
        ).asSkeleton(enabled: state.isLoading);
      },
    );
  }

  Widget _buildTodayStats(BuildContext context) {
    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              "Today's Performance",
              style: context.typography.h2.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: _StatCard(
                    icon: LucideIcons.dollarSign,
                    iconColor: const Color(0xFF4CAF50),
                    title: 'Earnings',
                    value: context.formatCurrency(state.todayEarnings),
                    isLoading: state.isLoading,
                  ),
                ),
                Expanded(
                  child: _StatCard(
                    icon: LucideIcons.package,
                    iconColor: const Color(0xFF2196F3),
                    title: 'Trips',
                    value: '${state.todayTrips}',
                    isLoading: state.isLoading,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Text(
          'Quick Actions',
          style: context.typography.h2.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          spacing: 12.w,
          children: [
            Expanded(
              child: _ActionCard(
                icon: LucideIcons.history,
                title: 'Order History',
                onTap: () {
                  context.goNamed(Routes.driverHistory.name);
                },
              ),
            ),
            Expanded(
              child: _ActionCard(
                icon: LucideIcons.calendar,
                title: 'My Schedule',
                onTap: () {
                  context.goNamed(Routes.driverKRS.name);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showIncomingOrderDialog(BuildContext context, Order order) {
    material.showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<DriverHomeCubit>(),
        child: material.AlertDialog(
          title: Row(
            spacing: 8.w,
            children: [
              Icon(
                LucideIcons.bellRing,
                size: 24.sp,
                color: context.colorScheme.primary,
              ),
              const Text('New Order Request'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              _OrderDetailRow(
                icon: LucideIcons.mapPin,
                label: 'Pickup',
                value: '${order.pickupLocation.x}, ${order.pickupLocation.y}',
              ),
              _OrderDetailRow(
                icon: LucideIcons.navigation,
                label: 'Destination',
                value: '${order.dropoffLocation.x}, ${order.dropoffLocation.y}',
              ),
              _OrderDetailRow(
                icon: LucideIcons.package,
                label: 'Order Type',
                value: order.type.name,
              ),
              _OrderDetailRow(
                icon: LucideIcons.dollarSign,
                label: 'Fare',
                value: context.formatCurrency(order.totalPrice),
              ),
              if (order.note?.instructions != null)
                _OrderDetailRow(
                  icon: LucideIcons.messageSquare,
                  label: 'Notes',
                  value: order.note!.instructions!,
                ),
            ],
          ),
          actions: [
            OutlineButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<DriverHomeCubit>().clearIncomingOrder();
              },
              child: const Text('Reject'),
            ),
            PrimaryButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // TODO: Navigate to order detail screen once created
                // For now just accept via cubit
                context.read<DriverHomeCubit>().clearIncomingOrder();
              },
              child: const Text('Accept Order'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    this.isLoading = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Container(
              padding: EdgeInsets.all(8.dg),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, size: 24.sp, color: iconColor),
            ),
            Text(
              title,
              style: context.typography.small.copyWith(
                fontSize: 14.sp,
                color: context.colorScheme.foreground.withValues(alpha: 0.6),
              ),
            ),
            Text(
              value,
              style: context.typography.h2.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ).asSkeleton(enabled: isLoading);
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: Column(
            spacing: 8.h,
            children: [
              Icon(icon, size: 32.sp, color: context.colorScheme.primary),
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.typography.h4.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderDetailRow extends StatelessWidget {
  const _OrderDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.w,
      children: [
        Icon(icon, size: 20.sp, color: context.colorScheme.mutedForeground),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2.h,
            children: [
              Text(
                label,
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
              Text(
                value,
                style: context.typography.p.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
