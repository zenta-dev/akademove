import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../widgets/review_submission_dialog.dart';

class DriverOrderDetailScreen extends StatefulWidget {
  const DriverOrderDetailScreen({required this.orderId, super.key});

  final String orderId;

  @override
  State<DriverOrderDetailScreen> createState() =>
      _DriverOrderDetailScreenState();
}

class _DriverOrderDetailScreenState extends State<DriverOrderDetailScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _initializeOrder();
  }

  Future<void> _initializeOrder() async {
    // Load order details
    final order = await context
        .read<OrderRepository>()
        .get(widget.orderId)
        .then((res) => res.data);
    if (mounted) {
      context.read<DriverOrderCubit>().init(order);
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EmergencyCubit>(),
      child: BlocConsumer<DriverOrderCubit, DriverOrderState>(
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
          if (message != null && message.isNotEmpty) {
            showToast(
              context: context,
              builder: (context, overlay) =>
                  context.buildToast(title: 'Success', message: message),
            );
          }

          // Navigate back when order is completed or cancelled
          if (state.orderStatus == OrderStatus.COMPLETED ||
              state.orderStatus == OrderStatus.CANCELLED_BY_DRIVER ||
              state.orderStatus == OrderStatus.CANCELLED_BY_USER ||
              state.orderStatus == OrderStatus.CANCELLED_BY_SYSTEM) {
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                context.goNamed(Routes.driverHome.name);
              }
            });
          }

          // Update map when order data changes
          final currentOrder = state.currentOrder;
          if (currentOrder != null) {
            _updateMapWithOrderData(currentOrder);
          }
        },
        builder: (context, state) {
          if (state.currentOrder == null) {
            return const MyScaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final order = state.currentOrder;
          if (order == null) {
            return const MyScaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          final status = state.orderStatus;

          return MyScaffold(
            headers: [
              AppBar(
                leading: [
                  IconButton(
                    icon: const Icon(LucideIcons.arrowLeft),
                    onPressed: () => context.pop(),
                    variance: ButtonVariance.ghost,
                  ),
                ],
                title: Text('Order #${order.id.substring(0, 8)}'),
              ),
            ],
            body: Column(
              children: [
                // Map view
                Expanded(flex: 2, child: _buildMap(order)),
                // Order details and actions
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.dg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20.h,
                      children: [
                        if (status != null) _buildStatusIndicator(status),
                        _buildOrderInfo(order),
                        _buildCustomerInfo(order),
                        _buildActionButtons(state, order),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMap(Order order) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              order.pickupLocation.y.toDouble(),
              order.pickupLocation.x.toDouble(),
            ),
            zoom: 14,
          ),
          markers: _markers,
          polylines: _polylines,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            _mapController = controller;
            _updateMapWithOrderData(order);
          },
        ),
        // Emergency button - only show during IN_TRIP status
        BlocBuilder<DriverOrderCubit, DriverOrderState>(
          builder: (context, state) {
            if (state.orderStatus != OrderStatus.IN_TRIP) {
              return const SizedBox.shrink();
            }

            // Use pickup location as fallback for emergency location
            final emergencyLocation = EmergencyLocation(
              latitude: order.pickupLocation.y.toDouble(),
              longitude: order.pickupLocation.x.toDouble(),
            );

            return Positioned(
              bottom: 16,
              right: 16,
              child: EmergencyButton(
                orderId: order.id,
                currentLocation: emergencyLocation,
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _updateMapWithOrderData(Order order) async {
    final pickupLat = order.pickupLocation.y.toDouble();
    final pickupLng = order.pickupLocation.x.toDouble();
    final dropoffLat = order.dropoffLocation.y.toDouble();
    final dropoffLng = order.dropoffLocation.x.toDouble();

    final newMarkers = <Marker>{}
      ..add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: LatLng(pickupLat, pickupLng),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: const InfoWindow(title: 'Pickup Location'),
        ),
      )
      ..add(
        Marker(
          markerId: const MarkerId('dropoff'),
          position: LatLng(dropoffLat, dropoffLng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: 'Dropoff Location'),
        ),
      );

    setState(() {
      _markers
        ..clear()
        ..addAll(newMarkers);
    });

    // Fit bounds to show both markers
    final mapController = _mapController;
    if (mapController != null) {
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
      await mapController.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 100),
      );
    }
  }

  Widget _buildStatusIndicator(OrderStatus status) {
    String statusText;
    material.Color statusColor;

    switch (status) {
      case OrderStatus.REQUESTED:
        statusText = 'Requested';
        statusColor = material.Colors.orange;
      case OrderStatus.MATCHING:
        statusText = 'Finding Driver';
        statusColor = material.Colors.blue;
      case OrderStatus.PREPARING:
        statusText = 'Preparing';
        statusColor = material.Colors.orange;
      case OrderStatus.READY_FOR_PICKUP:
        statusText = 'Ready for Pickup';
        statusColor = material.Colors.green;
      case OrderStatus.ACCEPTED:
        statusText = 'Order Accepted';
        statusColor = material.Colors.green;
      case OrderStatus.ARRIVING:
        statusText = 'On the Way to Pickup';
        statusColor = material.Colors.blue;
      case OrderStatus.IN_TRIP:
        statusText = 'Trip in Progress';
        statusColor = material.Colors.purple;
      case OrderStatus.COMPLETED:
        statusText = 'Completed';
        statusColor = material.Colors.green;
      case OrderStatus.CANCELLED_BY_USER:
      case OrderStatus.CANCELLED_BY_DRIVER:
      case OrderStatus.CANCELLED_BY_MERCHANT:
      case OrderStatus.CANCELLED_BY_SYSTEM:
        statusText = 'Cancelled';
        statusColor = material.Colors.red;
    }

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
              'Order Details',
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            _buildInfoRow(LucideIcons.package, 'Type', order.type.name),
            _buildInfoRow(
              LucideIcons.mapPin,
              'Pickup',
              '${order.pickupLocation.y.toStringAsFixed(4)}, ${order.pickupLocation.x.toStringAsFixed(4)}',
            ),
            _buildInfoRow(
              LucideIcons.navigation,
              'Dropoff',
              '${order.dropoffLocation.y.toStringAsFixed(4)}, ${order.dropoffLocation.x.toStringAsFixed(4)}',
            ),
            _buildInfoRow(
              LucideIcons.ruler,
              'Distance',
              '${order.distanceKm.toStringAsFixed(2)} km',
            ),
            _buildInfoRow(
              LucideIcons.dollarSign,
              'Fare',
              context.formatCurrency(order.totalPrice),
            ),
            if (order.note?.instructions != null)
              Builder(
                builder: (context) {
                  final instructions = order.note?.instructions;
                  if (instructions == null) return const SizedBox.shrink();

                  return Column(
                    children: [
                      const Divider(),
                      _buildInfoRow(
                        LucideIcons.messageSquare,
                        'Notes',
                        instructions,
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

  Widget _buildCustomerInfo(Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              'Customer Information',
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Row(
              spacing: 12.w,
              children: [
                material.CircleAvatar(
                  radius: 24.r,
                  child: Text(
                    order.user?.name?.substring(0, 1).toUpperCase() ?? 'U',
                    style: context.typography.h3.copyWith(fontSize: 20.sp),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Text(
                        order.user?.name ?? 'Unknown User',
                        style: context.typography.h4.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          final phone = order.user?.phone;
                          if (phone == null) return const SizedBox.shrink();

                          return Text(
                            _formatPhone(phone),
                            style: context.typography.small.copyWith(
                              fontSize: 14.sp,
                              color: context.colorScheme.mutedForeground,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.phone),
                  onPressed: () {
                    final phone = order.user?.phone;
                    if (phone != null) {
                      _showCallDialog(context, phone);
                    } else {
                      showToast(
                        context: context,
                        builder: (context, overlay) => context.buildToast(
                          title: 'No Phone Number',
                          message: 'Customer phone number not available',
                        ),
                      );
                    }
                  },
                  variance: ButtonVariance.ghost,
                ),
                IconButton(
                  icon: const Icon(LucideIcons.messageCircle),
                  onPressed: () {
                    _showChatDialog(context, order.id);
                  },
                  variance: ButtonVariance.ghost,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(DriverOrderState state, Order order) {
    final status = state.orderStatus;
    final isLoading = state.isLoading;

    // Pending order - show accept/reject
    if (status == OrderStatus.REQUESTED || status == OrderStatus.MATCHING) {
      return Row(
        spacing: 12.w,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: OutlineButton(
                onPressed: isLoading
                    ? null
                    : () => _showRejectDialog(context, order.id),
                child: const Text('Reject'),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onPressed: isLoading
                    ? null
                    : () => context.read<DriverOrderCubit>().acceptOrder(
                        order.id,
                      ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Accept Order'),
              ),
            ),
          ),
        ],
      );
    }

    // Accepted - show arriving button
    if (status == OrderStatus.ACCEPTED) {
      return Column(
        spacing: 12.h,
        children: [
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onPressed: isLoading
                  ? null
                  : () => context.read<DriverOrderCubit>().markArrived(),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Mark as Arrived'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
              onPressed: isLoading
                  ? null
                  : () => _showCancelDialog(context, order.id),
              child: const Text('Cancel Order'),
            ),
          ),
        ],
      );
    }

    // Arriving - show start trip button
    if (status == OrderStatus.ARRIVING) {
      return Column(
        spacing: 12.h,
        children: [
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onPressed: isLoading
                  ? null
                  : () => context.read<DriverOrderCubit>().startTrip(),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Start Trip'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
              onPressed: isLoading
                  ? null
                  : () => _showCancelDialog(context, order.id),
              child: const Text('Cancel Order'),
            ),
          ),
        ],
      );
    }

    // In trip - show complete trip button
    if (status == OrderStatus.IN_TRIP) {
      return SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          onPressed: isLoading
              ? null
              : () => context.read<DriverOrderCubit>().completeTrip(),
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text('Complete Trip'),
        ),
      );
    }

    // Completed - show rating and back button
    if (status == OrderStatus.COMPLETED) {
      return Column(
        spacing: 12.h,
        children: [
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onPressed: () async {
                await showReviewDialog(
                  context: context,
                  orderId: order.id,
                  toUserId: order.userId,
                  toUserName: order.user?.name ?? 'Customer',
                );
              },
              child: const Text('Rate Customer'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
              onPressed: () => context.goNamed(Routes.driverHome.name),
              child: const Text('Back to Home'),
            ),
          ),
        ],
      );
    }

    // Cancelled - show back button only
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        onPressed: () => context.goNamed(Routes.driverHome.name),
        child: const Text('Back to Home'),
      ),
    );
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

  String _formatPhone(Phone phone) {
    return '+${phone.countryCode.value}${phone.number}';
  }

  void _showRejectDialog(BuildContext context, String orderId) {
    material.showDialog(
      context: context,
      builder: (dialogContext) => material.AlertDialog(
        title: const Text('Reject Order'),
        content: const Text(
          'Are you sure you want to reject this order? This action cannot be undone.',
        ),
        actions: [
          material.TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          material.TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<DriverOrderCubit>().rejectOrder(orderId);
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context, String orderId) {
    material.showDialog(
      context: context,
      builder: (dialogContext) => material.AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text(
          'Are you sure you want to cancel this order? The customer will be notified.',
        ),
        actions: [
          material.TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('No'),
          ),
          material.TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<DriverOrderCubit>().cancelOrder();
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _showCallDialog(BuildContext context, Phone phone) {
    final phoneNumber = '+${phone.countryCode.value}${phone.number}';

    material.showDialog(
      context: context,
      builder: (dialogContext) => material.AlertDialog(
        title: const Text('Call Customer'),
        content: material.Column(
          mainAxisSize: material.MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Customer phone number:'),
            material.SizedBox(height: 8.h),
            material.SelectableText(
              phoneNumber,
              style: material.TextStyle(
                fontSize: 18.sp,
                fontWeight: material.FontWeight.bold,
              ),
            ),
            material.SizedBox(height: 16.h),
            Text(
              'Tap the phone number to copy it, then use your phone app to call.',
              style: material.TextStyle(
                fontSize: 12.sp,
                color: material.Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          material.TextButton(
            onPressed: () => material.Navigator.of(dialogContext).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showChatDialog(BuildContext context, String orderId) {
    material.showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) => material.DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => material.Container(
          decoration: material.BoxDecoration(
            color: material.Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const material.BorderRadius.only(
              topLeft: material.Radius.circular(16),
              topRight: material.Radius.circular(16),
            ),
          ),
          child: material.Column(
            children: [
              material.Container(
                padding: material.EdgeInsets.all(16.w),
                decoration: material.BoxDecoration(
                  border: material.Border(
                    bottom: material.BorderSide(
                      color: material.Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
                child: material.Row(
                  mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
                  children: [
                    material.Text(
                      'Chat with Customer',
                      style: material.TextStyle(
                        fontSize: 18.sp,
                        fontWeight: material.FontWeight.bold,
                      ),
                    ),
                    material.IconButton(
                      icon: const material.Icon(material.Icons.close),
                      onPressed: () =>
                          material.Navigator.of(bottomSheetContext).pop(),
                    ),
                  ],
                ),
              ),
              material.Expanded(child: OrderChatWidget(orderId: orderId)),
            ],
          ),
        ),
      ),
    );
  }
}
