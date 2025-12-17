import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Read-only screen for viewing merchant order history details.
/// Unlike [MerchantActiveOrderScreen], this screen does not have:
/// - Auto-navigation on terminal status
/// - Real-time updates via WebSocket
/// - Order action buttons (accept, reject, preparing, ready)
/// - Chat functionality
class MerchantHistoryDetailScreen extends StatefulWidget {
  const MerchantHistoryDetailScreen({required this.orderId, super.key});

  final String orderId;

  @override
  State<MerchantHistoryDetailScreen> createState() =>
      _MerchantHistoryDetailScreenState();
}

class _MerchantHistoryDetailScreenState
    extends State<MerchantHistoryDetailScreen> {
  Order? _order;
  bool _isLoading = true;
  String? _errorMessage;
  Set<Marker> _markers = {};
  GoogleMapController? _mapController;
  late final MerchantReviewCubit _reviewCubit;

  @override
  void initState() {
    super.initState();
    _reviewCubit = sl<MerchantReviewCubit>();
    _loadOrder();
  }

  Future<void> _loadOrder() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await sl<OrderRepository>().get(widget.orderId);
      if (mounted) {
        setState(() {
          _order = response.data;
          _isLoading = false;
        });
        _setupMap();
        // Check review status for completed orders
        if (response.data.status == OrderStatus.COMPLETED) {
          _reviewCubit.checkCustomerReviewStatus(widget.orderId);
          // Also check driver review status if driver is assigned
          if (response.data.driverId != null) {
            _reviewCubit.checkDriverReviewStatus(widget.orderId);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e is BaseError ? e.message : 'Failed to load order';
        });
      }
    }
  }

  Future<void> _setupMap() async {
    final order = _order;
    if (order == null || !mounted) return;

    // For food orders, show merchant location (pickup) and dropoff location
    final pickupLat = order.pickupLocation.y.toDouble();
    final pickupLng = order.pickupLocation.x.toDouble();
    final dropoffLat = order.dropoffLocation.y.toDouble();
    final dropoffLng = order.dropoffLocation.x.toDouble();

    final newMarkers = <Marker>{
      Marker(
        markerId: const MarkerId('merchant'),
        position: LatLng(pickupLat, pickupLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: context.l10n.pickup_location),
      ),
      Marker(
        markerId: const MarkerId('dropoff'),
        position: LatLng(dropoffLat, dropoffLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: context.l10n.dropoff_location),
      ),
    };

    if (!mounted) return;

    setState(() {
      _markers = newMarkers;
    });

    // Fit bounds after map is ready
    _fitMapBounds();
  }

  void _fitMapBounds() {
    final order = _order;
    final controller = _mapController;
    if (order == null || controller == null) return;

    final pickupLat = order.pickupLocation.y.toDouble();
    final pickupLng = order.pickupLocation.x.toDouble();
    final dropoffLat = order.dropoffLocation.y.toDouble();
    final dropoffLng = order.dropoffLocation.x.toDouble();

    final bounds = LatLngBounds(
      southwest: LatLng(
        pickupLat < dropoffLat ? pickupLat : dropoffLat,
        pickupLng < dropoffLng ? pickupLng : dropoffLng,
      ),
      northeast: LatLng(
        pickupLat > dropoffLat ? pickupLat : dropoffLat,
        pickupLng > dropoffLng ? pickupLng : dropoffLng,
      ),
    );

    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _reviewCubit.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _reviewCubit,
      child: Scaffold(
        headers: [
          AppBar(
            leading: [
              IconButton(
                icon: const Icon(LucideIcons.arrowLeft),
                onPressed: () => context.pop(),
                variance: ButtonVariance.ghost,
              ),
            ],
            title: Text(
              _order != null
                  ? context.l10n.text_order_id_short(_order?.id.prefix(8) ?? '')
                  : context.l10n.order_history,
            ),
          ),
        ],
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: OopsAlertWidget(message: _errorMessage!, onRefresh: _loadOrder),
      );
    }

    final order = _order;
    if (order == null) {
      return Center(child: Text(context.l10n.order_unavailable));
    }

    return SafeRefreshTrigger(
      onRefresh: _loadOrder,
      child: Column(
        children: [
          // Map view
          Expanded(flex: 2, child: _buildMap(order)),
          // Order details
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.dg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16.h,
                children: [
                  _buildStatusCard(order),
                  // Show scheduled indicator if this is a scheduled order
                  if (order.scheduledAt != null)
                    _buildScheduledIndicator(order),
                  _buildOrderItemsCard(order),
                  _buildOrderSummaryCard(order),
                  // Order Timeline - shows progression of order events
                  OrderTimelineWidget(order: order),
                  // Show notes if available
                  if (_hasNotes(order)) _buildNotesCard(order),
                  // Show cancel reason for cancelled orders
                  if (_isCancelledStatus(order.status) &&
                      order.cancelReason != null &&
                      order.cancelReason!.isNotEmpty)
                    _buildCancelReasonCard(order),
                  // Merchant Earnings Card - shows commission breakdown
                  if (order.status == OrderStatus.COMPLETED)
                    _buildMerchantEarningsCard(order),
                  _buildCustomerInfo(order),
                  if (order.driver != null) _buildDriverInfo(order),
                  // Review sections for completed orders
                  if (order.status == OrderStatus.COMPLETED) ...[
                    _buildCustomerReviewSection(order),
                    if (order.driver != null) _buildDriverReviewSection(order),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap(Order order) {
    return MapWrapperWidget(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          order.pickupLocation.y.toDouble(),
          order.pickupLocation.x.toDouble(),
        ),
        zoom: 14,
      ),
      markers: _markers,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        _mapController = controller;
        _fitMapBounds();
      },
    );
  }

  Widget _buildStatusCard(Order order) {
    final statusColor = _getStatusColor(order.status);
    final statusText = _getStatusText(context, order.status);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: statusColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8.w,
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            statusText,
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemsCard(Order order) {
    final items = order.items ?? [];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              context.l10n.order_items,
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            if (items.isEmpty)
              Text(
                context.l10n.no_menu_items_yet,
                style: context.typography.p.copyWith(
                  fontSize: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              )
            else
              ...items.map(_buildOrderItem),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(OrderItem orderItem) {
    final item = orderItem.item;
    final itemPrice = item.price?.toDouble() ?? 0;
    final totalPrice = itemPrice * orderItem.quantity;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              width: 60.r,
              height: 60.r,
              color: context.colorScheme.muted,
              child: item.image != null
                  ? Image.network(
                      item.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Icon(
                          LucideIcons.utensils,
                          size: 24.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        LucideIcons.utensils,
                        size: 24.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 12.w),
          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  item.name ?? context.l10n.unknown_item,
                  style: context.typography.p.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${orderItem.quantity}x @ ${context.formatCurrency(itemPrice)}',
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          // Item total
          Text(
            context.formatCurrency(totalPrice),
            style: context.typography.p.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard(Order order) {
    // Calculate subtotal from items
    final items = order.items ?? [];
    final subtotal = items.fold<double>(
      0,
      (sum, item) => sum + (item.item.price?.toDouble() ?? 0) * item.quantity,
    );

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              context.l10n.order_detail_summary,
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            _buildSummaryRow(
              context.l10n.label_subtotal,
              context.formatCurrency(subtotal),
            ),
            const Divider(),
            _buildSummaryRow(
              context.l10n.total,
              context.formatCurrency(order.totalPrice),
              isBold: true,
              valueColor: context.colorScheme.primary,
            ),
            const Divider(),
            _buildInfoRow(
              LucideIcons.calendar,
              context.l10n.order_time,
              order.createdAt.format('dd MMM yyyy - HH:mm'),
            ),
            _buildInfoRow(
              LucideIcons.hash,
              context.l10n.order_id,
              order.id.prefix(8),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMerchantEarningsCard(Order order) {
    final totalOrderValue = order.totalPrice;
    final platformCommission = order.platformCommission ?? 0;
    // Use server-provided merchantCommission; fallback to calculation only if unavailable
    final merchantEarnings =
        order.merchantCommission ?? (totalOrderValue - platformCommission);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.coins,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Text(
                  context.l10n.earnings,
                  style: context.typography.h3.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            _buildEarningsRow(
              context.l10n.label_total_price,
              context.formatCurrency(totalOrderValue),
            ),
            _buildEarningsRow(
              context.l10n.label_platform_commission,
              '- ${context.formatCurrency(platformCommission)}',
              valueColor: context.colorScheme.destructive,
            ),
            const Divider(),
            _buildEarningsRow(
              context.l10n.net_earnings,
              context.formatCurrency(merchantEarnings),
              isBold: true,
              valueColor: const Color(0xFF4CAF50),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.typography.p.copyWith(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: context.typography.p.copyWith(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.typography.p.copyWith(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: context.typography.p.copyWith(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerInfo(Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              context.l10n.customer_info,
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Row(
              spacing: 12.w,
              children: [
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    border: Border.all(
                      color: context.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      order.user?.name?.firstChar.toUpperCase() ?? 'U',
                      style: context.typography.h3.copyWith(
                        fontSize: 20.sp,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              order.user?.name ??
                                  context.l10n.text_unknown_user,
                              style: context.typography.h4.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (order.user?.rating case final rating?
                              when rating > 0) ...[
                            SizedBox(width: 8.w),
                            Icon(
                              LucideIcons.star,
                              size: 14.sp,
                              color: const Color(0xFFFFC107),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              rating.toStringAsFixed(1),
                              style: context.typography.small.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (order.user?.gender case final gender?)
                        Text(
                          _formatGender(gender),
                          style: context.typography.small.copyWith(
                            fontSize: 14.sp,
                            color: context.colorScheme.mutedForeground,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            _buildLocationInfoRow(
              LucideIcons.navigation,
              context.l10n.dropoff_location,
              order.dropoffAddress,
              order.dropoffLocation,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverInfo(Order order) {
    final driver = order.driver;
    if (driver == null) return const SizedBox.shrink();

    final driverName = driver.user?.name;
    final licensePlate = driver.licensePlate;
    final driverRating = driver.rating;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              context.l10n.text_driver,
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Row(
              spacing: 12.w,
              children: [
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.secondary.withValues(alpha: 0.1),
                    border: Border.all(
                      color: context.colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      driverName?.firstChar.toUpperCase() ?? 'D',
                      style: context.typography.h3.copyWith(
                        fontSize: 20.sp,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Text(
                        driverName ?? context.l10n.unknown,
                        style: context.typography.h4.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          // License plate
                          if (licensePlate != null)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: context.colorScheme.muted,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                licensePlate,
                                style: context.typography.small.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          // Driver rating
                          if (driverRating != null && driverRating > 0) ...[
                            if (licensePlate != null) SizedBox(width: 12.w),
                            Icon(
                              LucideIcons.star,
                              size: 14.sp,
                              color: const Color(0xFFFFC107),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              driverRating.toStringAsFixed(1),
                              style: context.typography.small.copyWith(
                                fontSize: 12.sp,
                                color: context.colorScheme.mutedForeground,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Check if order status is cancelled
  bool _isCancelledStatus(OrderStatus status) {
    return status == OrderStatus.CANCELLED_BY_USER ||
        status == OrderStatus.CANCELLED_BY_DRIVER ||
        status == OrderStatus.CANCELLED_BY_MERCHANT ||
        status == OrderStatus.CANCELLED_BY_SYSTEM;
  }

  /// Check if order has any notes
  bool _hasNotes(Order order) {
    final note = order.note;
    if (note == null) return false;
    return (note.pickup != null && note.pickup!.isNotEmpty) ||
        (note.dropoff != null && note.dropoff!.isNotEmpty) ||
        (note.senderName != null && note.senderName!.isNotEmpty) ||
        (note.recevierName != null && note.recevierName!.isNotEmpty);
  }

  /// Build scheduled order indicator
  Widget _buildScheduledIndicator(Order order) {
    final scheduledAt = order.scheduledAt;
    if (scheduledAt == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF00BCD4).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFF00BCD4)),
      ),
      child: Row(
        spacing: 8.w,
        children: [
          Icon(
            LucideIcons.calendarClock,
            size: 20.sp,
            color: const Color(0xFF00BCD4),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  context.l10n.scheduled,
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xFF00BCD4),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  scheduledAt.format('dd MMM yyyy - HH:mm'),
                  style: context.typography.p.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF00BCD4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build notes card for order notes
  Widget _buildNotesCard(Order order) {
    final note = order.note;
    if (note == null) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.stickyNote,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Text(
                  'Notes',
                  style: context.typography.h3.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            // Sender name (for delivery)
            if (note.senderName != null && note.senderName!.isNotEmpty)
              _buildNoteItem('Sender', note.senderName!, LucideIcons.userCheck),
            // Receiver name (for delivery)
            if (note.recevierName != null && note.recevierName!.isNotEmpty)
              _buildNoteItem('Receiver', note.recevierName!, LucideIcons.user),
            // Pickup note
            if (note.pickup != null && note.pickup!.isNotEmpty)
              _buildNoteItem('Pickup Note', note.pickup!, LucideIcons.mapPin),
            // Dropoff note
            if (note.dropoff != null && note.dropoff!.isNotEmpty)
              _buildNoteItem(
                'Dropoff Note',
                note.dropoff!,
                LucideIcons.navigation,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteItem(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.w,
        children: [
          Icon(icon, size: 16.sp, color: context.colorScheme.mutedForeground),
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
      ),
    );
  }

  /// Build cancel reason card for cancelled orders
  Widget _buildCancelReasonCard(Order order) {
    final cancelReason = order.cancelReason;
    if (cancelReason == null || cancelReason.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: const Color(0xFFF44336).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFF44336)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Row(
            spacing: 8.w,
            children: [
              Icon(
                LucideIcons.circleX,
                size: 20.sp,
                color: const Color(0xFFF44336),
              ),
              Text(
                'Cancellation Reason',
                style: context.typography.h4.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFF44336),
                ),
              ),
            ],
          ),
          Text(
            cancelReason,
            style: context.typography.p.copyWith(
              fontSize: 14.sp,
              color: context.colorScheme.foreground,
            ),
          ),
        ],
      ),
    );
  }

  String _formatGender(UserGender gender) {
    final genderStr = gender.name;
    return genderStr[0].toUpperCase() + genderStr.substring(1).toLowerCase();
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
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

  Widget _buildLocationInfoRow(
    IconData icon,
    String label,
    String? address,
    Coordinate coordinate,
  ) {
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
              AddressText(
                address: address,
                coordinate: coordinate,
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

  // ============================================
  // REVIEW SECTION METHODS
  // ============================================

  /// Build the customer review section
  Widget _buildCustomerReviewSection(Order order) {
    return BlocBuilder<MerchantReviewCubit, MerchantReviewState>(
      buildWhen: (previous, current) =>
          previous.customerReviewStatus != current.customerReviewStatus,
      builder: (context, state) {
        // Show loading state
        if (state.customerReviewStatus.isLoading) {
          return _buildReviewLoadingCard(context.l10n.rate_customer);
        }

        // Show error state with retry
        if (state.customerReviewStatus.isFailure) {
          return _buildReviewErrorCard(
            title: context.l10n.rate_customer,
            errorMessage: state.customerReviewStatus.error?.message,
            onRetry: () => _reviewCubit.checkCustomerReviewStatus(order.id),
          );
        }

        final reviewStatus = state.customerReviewStatus.value;

        // If already reviewed, show existing review card
        if (reviewStatus != null &&
            reviewStatus.alreadyReviewed &&
            reviewStatus.existingReview != null) {
          return _buildExistingReviewCard(
            reviewStatus.existingReview!,
            context.l10n.rate_customer,
          );
        }

        // Otherwise show the "Rate Customer" button
        return _buildRateButton(
          title: context.l10n.rate_customer,
          onPressed: () async {
            await showMerchantReviewDialog(
              context: context,
              orderId: order.id,
              toUserId: order.userId,
              toUserName: order.user?.name ?? context.l10n.text_customer,
              isDriverReview: false,
            );
            // Refresh review status after dialog closes
            _reviewCubit.checkCustomerReviewStatus(order.id);
          },
        );
      },
    );
  }

  /// Build the driver review section
  Widget _buildDriverReviewSection(Order order) {
    return BlocBuilder<MerchantReviewCubit, MerchantReviewState>(
      buildWhen: (previous, current) =>
          previous.driverReviewStatus != current.driverReviewStatus,
      builder: (context, state) {
        // Show loading state
        if (state.driverReviewStatus.isLoading) {
          return _buildReviewLoadingCard(context.l10n.rate_your_driver);
        }

        // Show error state with retry
        if (state.driverReviewStatus.isFailure) {
          return _buildReviewErrorCard(
            title: context.l10n.rate_your_driver,
            errorMessage: state.driverReviewStatus.error?.message,
            onRetry: () => _reviewCubit.checkDriverReviewStatus(order.id),
          );
        }

        final reviewStatus = state.driverReviewStatus.value;

        // If already reviewed, show existing review card
        if (reviewStatus != null &&
            reviewStatus.alreadyReviewed &&
            reviewStatus.existingReview != null) {
          return _buildExistingReviewCard(
            reviewStatus.existingReview!,
            context.l10n.rate_your_driver,
          );
        }

        // Otherwise show the "Rate Driver" button
        final driver = order.driver;
        if (driver == null) return const SizedBox.shrink();

        final driverUserId = driver.userId;
        // Can't rate if we don't have the driver's user ID
        if (driverUserId == null) return const SizedBox.shrink();

        final driverName = driver.user?.name ?? context.l10n.text_driver;

        return _buildRateButton(
          title: context.l10n.rate_your_driver,
          onPressed: () async {
            await showMerchantReviewDialog(
              context: context,
              orderId: order.id,
              toUserId: driverUserId,
              toUserName: driverName,
              isDriverReview: true,
            );
            // Refresh review status after dialog closes
            _reviewCubit.checkDriverReviewStatus(order.id);
          },
        );
      },
    );
  }

  /// Build loading card for review section
  Widget _buildReviewLoadingCard(String title) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.typography.h4.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
                Gap(12.w),
                Text(
                  context.l10n.loading,
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build error card for review section
  Widget _buildReviewErrorCard({
    required String title,
    String? errorMessage,
    required VoidCallback onRetry,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.typography.h4.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(12.h),
            Icon(
              LucideIcons.circleAlert,
              size: 24.sp,
              color: context.colorScheme.destructive,
            ),
            Gap(8.h),
            Text(
              errorMessage ?? context.l10n.error_generic,
              textAlign: TextAlign.center,
              style: context.typography.small.copyWith(
                fontSize: 14.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
            Gap(12.h),
            Center(
              child: Button.outline(
                onPressed: onRetry,
                child: Text(context.l10n.button_retry),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build rate button card
  Widget _buildRateButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.typography.h4.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(12.h),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(onPressed: onPressed, child: Text(title)),
            ),
          ],
        ),
      ),
    );
  }

  /// Build existing review card showing the merchant's submitted review
  Widget _buildExistingReviewCard(Review review, String title) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: context.typography.h4.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(12.h),

            // Header with badge
            Row(
              children: [
                Icon(
                  LucideIcons.circleCheck,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Gap(8.w),
                Text(
                  context.l10n.text_already_reviewed,
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            Gap(16.h),

            // Star rating display
            _buildExistingRatingStars(review.score),
            Gap(12.h),

            // Categories display
            if (review.categories.isNotEmpty) ...[
              _buildExistingCategoriesChips(review.categories),
              Gap(12.h),
            ],

            // Comment display (if any)
            if (review.comment != null && review.comment!.isNotEmpty) ...[
              _buildExistingCommentDisplay(review.comment!),
              Gap(12.h),
            ],

            // Review date
            Divider(color: context.colorScheme.border.withValues(alpha: 0.5)),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.calendar,
                  size: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Gap(8.w),
                Text(
                  context.l10n.text_reviewed_on(
                    review.createdAt.format('d MMM yyyy'),
                  ),
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExistingRatingStars(int score) {
    return Row(
      children: [
        Text(
          context.l10n.text_your_rating,
          style: context.typography.small.copyWith(
            fontSize: 14.sp,
            color: context.colorScheme.mutedForeground,
          ),
        ),
        Gap(12.w),
        Row(
          children: List.generate(5, (index) {
            final starValue = index + 1;
            return Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Icon(
                LucideIcons.star,
                size: 18.sp,
                color: starValue <= score
                    ? const Color(0xFFFFA000)
                    : context.colorScheme.mutedForeground,
                fill: starValue <= score ? 1.0 : 0.0,
              ),
            );
          }),
        ),
        Gap(8.w),
        Text(
          _getRatingLabel(score),
          style: context.typography.small.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: context.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildExistingCategoriesChips(List<ReviewCategory> categories) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children: categories.map((category) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: context.colorScheme.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getCategoryIcon(category),
                size: 12.sp,
                color: context.colorScheme.primary,
              ),
              Gap(6.w),
              Text(
                _getCategoryLabel(category),
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExistingCommentDisplay(String comment) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.muted.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.quote,
            size: 16.sp,
            color: context.colorScheme.mutedForeground,
          ),
          Gap(10.w),
          Expanded(
            child: Text(
              comment,
              style: context.typography.small.copyWith(
                fontSize: 13.sp,
                fontStyle: FontStyle.italic,
                color: context.colorScheme.foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(ReviewCategory category) {
    switch (category) {
      case ReviewCategory.CLEANLINESS:
        return LucideIcons.sparkles;
      case ReviewCategory.COURTESY:
        return LucideIcons.heart;
      case ReviewCategory.PUNCTUALITY:
        return LucideIcons.clock;
      case ReviewCategory.SAFETY:
        return LucideIcons.shield;
      case ReviewCategory.COMMUNICATION:
        return LucideIcons.messageCircle;
      case ReviewCategory.OTHER:
        return LucideIcons.star;
    }
  }

  String _getCategoryLabel(ReviewCategory category) {
    switch (category) {
      case ReviewCategory.CLEANLINESS:
        return context.l10n.category_cleanliness;
      case ReviewCategory.COURTESY:
        return context.l10n.category_courtesy;
      case ReviewCategory.PUNCTUALITY:
        return context.l10n.category_punctuality;
      case ReviewCategory.SAFETY:
        return context.l10n.category_safety;
      case ReviewCategory.COMMUNICATION:
        return context.l10n.category_communication;
      case ReviewCategory.OTHER:
        return context.l10n.category_overall;
    }
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1:
        return context.l10n.rating_poor;
      case 2:
        return context.l10n.rating_below_average;
      case 3:
        return context.l10n.rating_average;
      case 4:
        return context.l10n.rating_good;
      case 5:
        return context.l10n.rating_excellent;
      default:
        return '';
    }
  }
}
