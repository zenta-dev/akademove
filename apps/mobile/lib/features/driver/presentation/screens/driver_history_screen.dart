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
      await context.read<DriverListHistoryCubit>().getOrders(
        query: ListOrderQuery(
          statuses: selectedStatus != null ? [selectedStatus] : [],
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
      await context.read<DriverListHistoryCubit>().loadMoreOrders(
        statuses: selectedStatus != null ? [selectedStatus] : [],
      );
    } catch (e) {
      if (mounted) {}
    }
  }

  Future<void> _onRefresh() async {
    await _loadOrders();
  }

  void _onStatusFilterChanged(OrderStatus? status) {
    setState(() => _selectedStatus = status);
    _loadOrders();
  }

  void _onTypeFilterChanged(OrderType? type) {
    setState(() => _selectedType = type);
    _loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverListHistoryCubit, DriverListHistoryState>(
      builder: (context, state) {
        final filteredOrders = _selectedType == null
            ? state.orders
            : state.orders.where((o) => o.type == _selectedType).toList();
        return MyScaffold(
          headers: [
            DefaultAppBar(
              title: context.l10n.order_history,
              padding: EdgeInsets.all(16.r),
            ),
          ],
          scrollable: false,
          body: Column(
            spacing: 8.h,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8.w,
                  children: [
                    _buildStatusFilterChip(context.l10n.all, null),
                    _buildStatusFilterChip(
                      context.l10n.completed,
                      OrderStatus.COMPLETED,
                    ),
                    _buildStatusFilterChip(
                      context.l10n.in_progress,
                      OrderStatus.IN_TRIP,
                    ),
                    _buildStatusFilterChip(
                      context.l10n.cancelled,
                      OrderStatus.CANCELLED_BY_USER,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshTrigger(
                  onRefresh: _onRefresh,
                  child: Column(
                    spacing: 8.h,
                    children: [
                      // Filter chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 8.w,
                          children: [
                            _buildTypeFilterChip(context.l10n.all_types, null),
                            _buildTypeFilterChip(
                              context.l10n.ride,
                              OrderType.RIDE,
                            ),
                            _buildTypeFilterChip(
                              context.l10n.delivery,
                              OrderType.DELIVERY,
                            ),
                            _buildTypeFilterChip(
                              context.l10n.order_type_food,
                              OrderType.FOOD,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      // Order list
                      Expanded(
                        child: filteredOrders.isEmpty
                            ? _buildEmptyState()
                            : ListView.separated(
                                controller: _scrollController,
                                padding: EdgeInsets.all(16.dg),
                                itemCount: filteredOrders.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 12.h),
                                itemBuilder: (context, index) {
                                  if (index >= filteredOrders.length) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(16),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return _buildOrderCard(
                                    context,
                                    filteredOrders[index],
                                  );
                                },
                              ),
                      ),
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

  Widget _buildStatusFilterChip(String label, OrderStatus? status) {
    final isSelected = _selectedStatus == status;
    return Chip(
      style: isSelected ? ButtonStyle.primary() : ButtonStyle.outline(),
      child: ChipButton(
        child: Text(label),
        onPressed: () => _onStatusFilterChanged(status),
      ),
    );
  }

  Widget _buildTypeFilterChip(String label, OrderType? type) {
    final isSelected = _selectedType == type;
    return Chip(
      style: isSelected ? ButtonStyle.primary() : ButtonStyle.outline(),
      child: ChipButton(
        child: Text(label),
        onPressed: () => _onTypeFilterChanged(type),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16.h,
        children: [
          Icon(
            LucideIcons.inbox,
            size: 64.sp,
            color: context.colorScheme.mutedForeground,
          ),
          Text(
            context.l10n.no_orders_found,
            style: context.typography.h3.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            context.l10n.your_completed_and_cancelled_orders_will_appear_here,
            textAlign: TextAlign.center,
            style: context.typography.p.copyWith(
              fontSize: 14.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order) {
    final statusColor = _getStatusColor(order.status);
    final statusText = _getStatusText(context, order.status);

    return GhostButton(
      onPressed: () => context.goNamed(
        Routes.driverOrderDetail.name,
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
                  DateFormat('MMM dd, yyyy').format(order.createdAt),
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
                      Text(
                        '${order.pickupLocation.y.toStringAsFixed(4)}, ${order.pickupLocation.x.toStringAsFixed(4)}',
                        style: context.typography.p.copyWith(fontSize: 14.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        '${order.dropoffLocation.y.toStringAsFixed(4)}, ${order.dropoffLocation.x.toStringAsFixed(4)}',
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
          ],
        ),
      ),
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
