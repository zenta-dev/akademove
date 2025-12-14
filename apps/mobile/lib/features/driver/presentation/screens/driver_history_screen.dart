import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverHistoryScreen extends StatefulWidget {
  const DriverHistoryScreen({super.key});

  @override
  State<DriverHistoryScreen> createState() => _DriverHistoryScreenState();
}

class _DriverHistoryScreenState extends State<DriverHistoryScreen> {
  final _scrollController = ScrollController();
  OrderStatus? _selectedStatus;
  OrderType? _selectedType;

  @override
  void initState() {
    super.initState();
    _loadOrders();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      _loadMore();
    }
  }

  Future<void> _loadOrders() async {
    try {
      final selectedStatus = _selectedStatus;
      final selectedType = _selectedType;
      await context.read<DriverListHistoryCubit>().getOrders(
        query: ListOrderQuery(
          statuses: selectedStatus != null ? [selectedStatus] : [],
          type: selectedType,
          limit: 20,
          cursor: null,
        ),
      );
    } on BaseError catch (e) {
      if (mounted) {
        context.showMyToast(e.message);
      }
    } catch (e) {
      if (mounted) {
        context.showMyToast(context.l10n.failed_to_load_orders);
      }
    }
  }

  Future<void> _loadMore() async {
    try {
      final selectedStatus = _selectedStatus;
      final selectedType = _selectedType;
      await context.read<DriverListHistoryCubit>().loadMoreOrders(
        statuses: selectedStatus != null ? [selectedStatus] : [],
        type: selectedType,
      );
    } catch (e) {
      if (mounted) {}
    }
  }

  Future<void> _onRefresh() async {
    await _loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        DefaultAppBar(
          title: context.l10n.order_history,
          padding: EdgeInsets.all(16.r),
        ),
      ],
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: SafeRefreshTrigger(
          onRefresh: _onRefresh,
          child: BlocBuilder<DriverListHistoryCubit, DriverListHistoryState>(
            builder: (context, state) {
              if (state.fetchHistoryResult.isLoading) {
                return ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) =>
                      _buildOrderCard(context, dummyOrder),
                ).asSkeleton();
              }

              final orders = state.fetchHistoryResult.value ?? [];
              if (orders.isEmpty) {
                return _buildEmptyState();
              }

              return ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: orders.length,
                controller: _scrollController,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  if (index >= orders.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return _buildOrderCard(context, orders[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.dg),
              child: Column(
                mainAxisSize: MainAxisSize.min, // KUNCI UTAMA
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16.h,
                children: [
                  Icon(
                    LucideIcons.inbox,
                    size: 64.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                  Text(
                    context.l10n.no_orders_found,
                    textAlign: TextAlign.center,
                    style: context.typography.h3.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    context
                        .l10n
                        .your_completed_and_cancelled_orders_will_appear_here,
                    textAlign: TextAlign.center,
                    style: context.typography.p.copyWith(
                      fontSize: 14.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order) {
    final statusColor = _getStatusColor(order.status);
    final statusText = _getStatusText(context, order.status);
    final isActive = order.status.isActive;

    return GhostButton(
      density: ButtonDensity.compact,
      onPressed: () => context.pushNamed(
        Routes.driverHistoryDetail.name,
        pathParameters: {'orderId': order.id},
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            // Header: Type badge + Status badge
            Row(
              children: [
                _buildTypeBadge(order.type),
                SizedBox(width: 8.w),
                _buildStatusBadge(statusText, statusColor),
                const Spacer(),
                Text(
                  DateFormat('MMM dd, yyyy').format(order.createdAt.toLocal()),
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            const Divider(),
            // Pickup and Dropoff
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.w,
              children: [
                Column(
                  spacing: 8.h,
                  children: [
                    Icon(
                      LucideIcons.mapPin,
                      size: 16.sp,
                      color: const Color(0xFF4CAF50),
                    ),
                    Container(
                      width: 2.w,
                      height: 20.h,
                      color: context.colorScheme.mutedForeground,
                    ),
                    Icon(
                      LucideIcons.navigation,
                      size: 16.sp,
                      color: const Color(0xFFF44336),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.h,
                    children: [
                      AddressText(
                        address: order.pickupAddress,
                        coordinate: order.pickupLocation,
                        style: context.typography.p.copyWith(fontSize: 14.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12.h),
                      AddressText(
                        address: order.dropoffAddress,
                        coordinate: order.dropoffLocation,
                        style: context.typography.p.copyWith(fontSize: 14.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            // Footer: Distance + Fare
            Row(
              children: [
                Icon(LucideIcons.ruler, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  '${order.distanceKm.toStringAsFixed(2)} km',
                  style: context.typography.small.copyWith(fontSize: 12.sp),
                ),
                const Spacer(),
                Text(
                  context.formatCurrency(order.totalPrice),
                  style: context.typography.h4.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            // View Active Order button for active orders
            if (isActive) ...[
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  onPressed: () => _navigateToActiveOrder(context, order),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _navigateToActiveOrder(BuildContext context, Order order) {
    // Initialize the driver order cubit with this order and navigate
    context.read<DriverOrderCubit>().init(order);
    context.pushNamed(
      Routes.driverOrderDetail.name,
      pathParameters: {'orderId': order.id},
    );
  }

  Widget _buildTypeBadge(OrderType type) {
    Color color;
    IconData icon;

    switch (type) {
      case OrderType.RIDE:
        color = const Color(0xFF2196F3);
        icon = LucideIcons.car;
      case OrderType.DELIVERY:
        color = const Color(0xFFFF9800);
        icon = LucideIcons.package;
      case OrderType.FOOD:
        color = const Color(0xFF4CAF50);
        icon = LucideIcons.utensils;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.w,
        children: [
          Icon(icon, size: 14.sp, color: color),
          Text(
            type.name,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: context.typography.small.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.REQUESTED:
      case OrderStatus.MATCHING:
        return const Color(0xFFFF9800);
      case OrderStatus.PREPARING:
      case OrderStatus.READY_FOR_PICKUP:
        return const Color(0xFFFF9800);
      case OrderStatus.ACCEPTED:
      case OrderStatus.ARRIVING:
        return const Color(0xFF2196F3);
      case OrderStatus.IN_TRIP:
        return const Color(0xFF9C27B0);
      case OrderStatus.COMPLETED:
        return const Color(0xFF4CAF50);
      case OrderStatus.CANCELLED_BY_USER:
      case OrderStatus.CANCELLED_BY_DRIVER:
      case OrderStatus.CANCELLED_BY_MERCHANT:
      case OrderStatus.CANCELLED_BY_SYSTEM:
        return const Color(0xFFF44336);
      case OrderStatus.NO_SHOW:
        return const Color(0xFFFF5722);
      case OrderStatus.SCHEDULED:
        return const Color(0xFF00BCD4);
    }
  }

  String _getStatusText(BuildContext context, OrderStatus status) {
    switch (status) {
      case OrderStatus.REQUESTED:
        return context.l10n.requested;
      case OrderStatus.MATCHING:
        return context.l10n.matching;
      case OrderStatus.PREPARING:
        return context.l10n.preparing;
      case OrderStatus.READY_FOR_PICKUP:
        return context.l10n.ready_for_pickup;
      case OrderStatus.ACCEPTED:
        return context.l10n.accepted;
      case OrderStatus.ARRIVING:
        return context.l10n.arriving;
      case OrderStatus.IN_TRIP:
        return context.l10n.in_trip;
      case OrderStatus.COMPLETED:
        return context.l10n.completed;
      case OrderStatus.CANCELLED_BY_USER:
      case OrderStatus.CANCELLED_BY_DRIVER:
      case OrderStatus.CANCELLED_BY_MERCHANT:
      case OrderStatus.CANCELLED_BY_SYSTEM:
        return context.l10n.cancelled;
      case OrderStatus.NO_SHOW:
        return 'No Show';
      case OrderStatus.SCHEDULED:
        return context.l10n.scheduled;
    }
  }
}
