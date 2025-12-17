import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Read-only screen for viewing driver order history details.
/// Unlike [DriverOrderDetailScreen], this screen does not have:
/// - Auto-navigation on terminal status
/// - Real-time location tracking
/// - Order action buttons (accept, reject, etc.)
/// - WebSocket connections
class DriverHistoryDetailScreen extends StatefulWidget {
  const DriverHistoryDetailScreen({required this.orderId, super.key});

  final String orderId;

  @override
  State<DriverHistoryDetailScreen> createState() =>
      _DriverHistoryDetailScreenState();
}

class _DriverHistoryDetailScreenState extends State<DriverHistoryDetailScreen> {
  Order? _order;
  bool _isLoading = true;
  String? _errorMessage;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
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
    if (order == null) return;

    final pickupLat = order.pickupLocation.y.toDouble();
    final pickupLng = order.pickupLocation.x.toDouble();
    final dropoffLat = order.dropoffLocation.y.toDouble();
    final dropoffLng = order.dropoffLocation.x.toDouble();

    final newMarkers = <Marker>{
      Marker(
        markerId: const MarkerId('pickup'),
        position: LatLng(pickupLat, pickupLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: context.l10n.pickup_location),
      ),
      Marker(
        markerId: const MarkerId('dropoff'),
        position: LatLng(dropoffLat, dropoffLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: context.l10n.dropoff_location),
      ),
    };

    // Simple straight line for historical view
    final newPolylines = <Polyline>{
      Polyline(
        polylineId: const PolylineId('route'),
        points: [LatLng(pickupLat, pickupLng), LatLng(dropoffLat, dropoffLng)],
        color: context.colorScheme.primary,
        width: 4,
      ),
    };

    setState(() {
      _markers = newMarkers;
      _polylines = newPolylines;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _buildOrderInfo(order),
                  _buildCustomerInfo(order),
                  _buildActionButtons(order),
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
      polylines: _polylines,
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

  Widget _buildOrderInfo(Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              context.l10n.order_detail,
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            _buildInfoRow(
              LucideIcons.package,
              context.l10n.service,
              order.type.name,
            ),
            _buildLocationInfoRow(
              LucideIcons.mapPin,
              context.l10n.pickup_location,
              order.pickupAddress,
              order.pickupLocation,
            ),
            _buildLocationInfoRow(
              LucideIcons.navigation,
              context.l10n.dropoff_location,
              order.dropoffAddress,
              order.dropoffLocation,
            ),
            _buildInfoRow(
              LucideIcons.ruler,
              context.l10n.distance,
              '${order.distanceKm.toStringAsFixed(2)} km',
            ),
            _buildInfoRow(
              LucideIcons.dollarSign,
              context.l10n.fare,
              context.formatCurrency(order.totalPrice),
            ),
            _buildInfoRow(
              LucideIcons.calendar,
              'Date',
              order.createdAt.format('dd MMM yyyy - HH:mm'),
            ),
          ],
        ),
      ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(Order order) {
    // Only show rate button for completed orders
    if (order.status == OrderStatus.COMPLETED) {
      return SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          onPressed: () async {
            await showReviewDialog(
              context: context,
              orderId: order.id,
              toUserId: order.userId,
              toUserName: order.user?.name ?? context.l10n.text_customer,
            );
          },
          child: Text(context.l10n.rate_customer),
        ),
      );
    }

    // No actions for cancelled orders
    return const SizedBox.shrink();
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
}
