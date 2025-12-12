import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Widget to display active order card on the home screen
/// Shows order status, type, and allows navigation to the active trip screen
class ActiveOrderCardWidget extends StatelessWidget {
  const ActiveOrderCardWidget({super.key, required this.order, this.driver});

  final Order order;
  final Driver? driver;

  void _navigateToOnTrip(BuildContext context) {
    // First recover the active order in the cubit
    context.read<UserOrderCubit>().recoverActiveOrder();

    // Navigate to the appropriate on-trip screen based on order type
    switch (order.type) {
      case OrderType.RIDE:
        context.pushNamed(Routes.userRideOnTrip.name);
      case OrderType.DELIVERY:
        context.pushNamed(Routes.userDeliveryOnTrip.name);
      case OrderType.FOOD:
        context.pushNamed(Routes.userMartOnTrip.name);
    }
  }

  IconData _getOrderTypeIcon() {
    return switch (order.type) {
      OrderType.RIDE => LucideIcons.bike,
      OrderType.DELIVERY => LucideIcons.package,
      OrderType.FOOD => LucideIcons.utensils,
    };
  }

  Color _getOrderTypeColor(BuildContext context) {
    return switch (order.type) {
      OrderType.RIDE => Colors.blue,
      OrderType.DELIVERY => Colors.green,
      OrderType.FOOD => Colors.orange,
    };
  }

  String _getStatusMessage(BuildContext context) {
    return switch (order.status) {
      OrderStatus.REQUESTED => context.l10n.requested,
      OrderStatus.MATCHING => context.l10n.matching,
      OrderStatus.ACCEPTED => context.l10n.accepted,
      OrderStatus.PREPARING => context.l10n.preparing,
      OrderStatus.READY_FOR_PICKUP => context.l10n.ready_for_pickup,
      OrderStatus.ARRIVING => context.l10n.arriving,
      OrderStatus.IN_TRIP => context.l10n.in_trip,
      _ => order.status.localizedName(context),
    };
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getOrderTypeColor(context);

    return GestureDetector(
      onTap: () => _navigateToOnTrip(context),
      child: Container(
        padding: EdgeInsets.all(16.dg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              typeColor.withValues(alpha: 0.15),
              typeColor.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: typeColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            // Header row with icon and status
            Row(
              children: [
                // Order type icon
                Container(
                  padding: EdgeInsets.all(10.dg),
                  decoration: BoxDecoration(
                    color: typeColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    _getOrderTypeIcon(),
                    color: typeColor,
                    size: 24.sp,
                  ),
                ),
                Gap(12.w),
                // Order info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Text(
                        order.type.localizedName(context),
                        style: context.typography.h4.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            order.status.icon,
                            color: order.status.color,
                            size: 14.sp,
                          ),
                          Gap(6.w),
                          Flexible(
                            child: Text(
                              _getStatusMessage(context),
                              style: context.typography.small.copyWith(
                                fontSize: 13.sp,
                                color: order.status.color,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Animated indicator
                _PulsingIndicator(color: order.status.color),
              ],
            ),

            // Driver info (if assigned)
            if (driver != null) ...[
              Divider(
                color: context.colorScheme.border.withValues(alpha: 0.5),
                height: 1,
              ),
              Row(
                children: [
                  UserAvatarWidget(
                    name: driver?.user?.name ?? '',
                    image: driver?.user?.image,
                    size: 32,
                  ),
                  Gap(10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driver?.user?.name ?? '',
                          style: context.typography.small.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          driver?.licensePlate ?? '',
                          style: context.typography.textMuted.copyWith(
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],

            // View trip button
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onPressed: () => _navigateToOnTrip(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8.w,
                  children: [
                    Icon(LucideIcons.navigation, size: 16.sp),
                    Text(
                      context.l10n.view_active_order,
                      style: context.typography.small.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pulsing indicator to show the order is active
class _PulsingIndicator extends StatefulWidget {
  const _PulsingIndicator({required this.color});

  final Color color;

  @override
  State<_PulsingIndicator> createState() => _PulsingIndicatorState();
}

class _PulsingIndicatorState extends State<_PulsingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withValues(alpha: _animation.value),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: _animation.value * 0.5),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
