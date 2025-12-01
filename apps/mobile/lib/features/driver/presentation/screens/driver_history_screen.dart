import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
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
  List<Order> _orders = [];
  bool _isLoading = false;
  bool _hasMore = true;
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
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _orders = [];
      _hasMore = true;
    });

    try {
      final response = await context.read<OrderRepository>().list(
        ListOrderQuery(
          statuses: _selectedStatus != null ? [_selectedStatus!] : [],
          limit: 20,
          cursor: null,
        ),
      );

      if (mounted) {
        setState(() {
          _orders = response.data;
          _isLoading = false;
          _hasMore = response.data.length >= 20;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Error',
            message: 'Failed to load orders: ${e.toString()}',
          ),
        );
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    try {
      final lastOrder = _orders.lastOrNull;
      if (lastOrder == null) {
        setState(() => _isLoading = false);
        return;
      }

      final response = await context.read<OrderRepository>().list(
        ListOrderQuery(
          statuses: _selectedStatus != null ? [_selectedStatus!] : [],
          limit: 20,
          cursor: lastOrder.id,
        ),
      );

      if (mounted) {
        setState(() {
          _orders.addAll(response.data);
          _isLoading = false;
          _hasMore = response.data.length >= 20;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
    final filteredOrders = _selectedType == null
        ? _orders
        : _orders.where((o) => o.type == _selectedType).toList();

    return MyScaffold(
      headers: [
        AppBar(
          title: const Text('Order History'),
          trailing: [
            IconButton(
              icon: const Icon(LucideIcons.filterX),
              onPressed: () {
                setState(() {
                  _selectedStatus = null;
                  _selectedType = null;
                });
                _loadOrders();
              },
              variance: ButtonVariance.ghost,
            ),
          ],
        ),
      ],
      body: material.RefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
          children: [
            // Filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                spacing: 8.w,
                children: [
                  _buildStatusFilterChip('All', null),
                  _buildStatusFilterChip('Completed', OrderStatus.COMPLETED),
                  _buildStatusFilterChip('In Progress', OrderStatus.IN_TRIP),
                  _buildStatusFilterChip(
                    'Cancelled',
                    OrderStatus.CANCELLED_BY_USER,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                spacing: 8.w,
                children: [
                  _buildTypeFilterChip('All Types', null),
                  _buildTypeFilterChip('Ride', OrderType.RIDE),
                  _buildTypeFilterChip('Delivery', OrderType.DELIVERY),
                  _buildTypeFilterChip('Food', OrderType.FOOD),
                ],
              ),
            ),
            const Divider(),
            // Order list
            Expanded(
              child: _isLoading && _orders.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : filteredOrders.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      controller: _scrollController,
                      padding: EdgeInsets.all(16.dg),
                      itemCount: filteredOrders.length + (_hasMore ? 1 : 0),
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        if (index >= filteredOrders.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return _buildOrderCard(filteredOrders[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusFilterChip(String label, OrderStatus? status) {
    final isSelected = _selectedStatus == status;
    return material.FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => _onStatusFilterChanged(status),
    );
  }

  Widget _buildTypeFilterChip(String label, OrderType? type) {
    final isSelected = _selectedType == type;
    return material.FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => _onTypeFilterChanged(type),
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
            'No orders found',
            style: context.typography.h3.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Your completed and cancelled orders\nwill appear here',
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

  Widget _buildOrderCard(Order order) {
    final statusColor = _getStatusColor(order.status);
    final statusText = _getStatusText(order.status);

    return Card(
      child: material.InkWell(
        onTap: () => context.goNamed(
          Routes.driverOrderDetail.name,
          pathParameters: {'orderId': order.id},
        ),
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.all(16.dg),
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
                        color: material.Colors.green,
                      ),
                      Container(
                        width: 2.w,
                        height: 20.h,
                        color: context.colorScheme.mutedForeground,
                      ),
                      Icon(
                        LucideIcons.navigation,
                        size: 16.sp,
                        color: material.Colors.red,
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
      ),
    );
  }

  Widget _buildTypeBadge(OrderType type) {
    material.Color color;
    IconData icon;

    switch (type) {
      case OrderType.RIDE:
        color = material.Colors.blue;
        icon = LucideIcons.car;
      case OrderType.DELIVERY:
        color = material.Colors.orange;
        icon = LucideIcons.package;
      case OrderType.FOOD:
        color = material.Colors.green;
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

  Widget _buildStatusBadge(String text, material.Color color) {
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

  material.Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.REQUESTED:
      case OrderStatus.MATCHING:
        return material.Colors.orange;
      case OrderStatus.PREPARING:
      case OrderStatus.READY_FOR_PICKUP:
        return material.Colors.orange;
      case OrderStatus.ACCEPTED:
      case OrderStatus.ARRIVING:
        return material.Colors.blue;
      case OrderStatus.IN_TRIP:
        return material.Colors.purple;
      case OrderStatus.COMPLETED:
        return material.Colors.green;
      case OrderStatus.CANCELLED_BY_USER:
      case OrderStatus.CANCELLED_BY_DRIVER:
      case OrderStatus.CANCELLED_BY_MERCHANT:
      case OrderStatus.CANCELLED_BY_SYSTEM:
        return material.Colors.red;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.REQUESTED:
        return 'Requested';
      case OrderStatus.MATCHING:
        return 'Matching';
      case OrderStatus.PREPARING:
        return 'Preparing';
      case OrderStatus.READY_FOR_PICKUP:
        return 'Ready for Pickup';
      case OrderStatus.ACCEPTED:
        return 'Accepted';
      case OrderStatus.ARRIVING:
        return 'Arriving';
      case OrderStatus.IN_TRIP:
        return 'In Trip';
      case OrderStatus.COMPLETED:
        return 'Completed';
      case OrderStatus.CANCELLED_BY_USER:
      case OrderStatus.CANCELLED_BY_DRIVER:
      case OrderStatus.CANCELLED_BY_MERCHANT:
      case OrderStatus.CANCELLED_BY_SYSTEM:
        return 'Cancelled';
    }
  }
}
