import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<DriverOrderCubit>()),
        BlocProvider(create: (context) => sl<EmergencyCubit>()),
      ],
      child: BlocConsumer<DriverOrderCubit, DriverOrderState>(
        listener: (context, state) {
          // Show error messages
          if (state.isFailure && state.error != null) {
            context.showMyToast(
              state.error?.message ?? context.l10n.an_error_occurred,
              type: ToastType.failed,
            );
          }

          // Show success messages
          final message = state.message;
          if (message != null && message.isNotEmpty) {
            context.showMyToast(message, type: ToastType.success);
          }

          // Navigate back when order is completed or cancelled
          if (state.orderStatus == OrderStatus.COMPLETED ||
              state.orderStatus == OrderStatus.CANCELLED_BY_DRIVER ||
              state.orderStatus == OrderStatus.CANCELLED_BY_USER ||
              state.orderStatus == OrderStatus.CANCELLED_BY_SYSTEM) {
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted && context.mounted) {
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
                title: Text(
                  context.l10n.text_order_id_short(order.id.substring(0, 8)),
                ),
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
                        if (status != null)
                          _buildStatusIndicator(context, status),
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
          infoWindow: InfoWindow(title: context.l10n.pickup_location),
        ),
      )
      ..add(
        Marker(
          markerId: const MarkerId('dropoff'),
          position: LatLng(dropoffLat, dropoffLng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: context.l10n.dropoff_location),
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

  Widget _buildStatusIndicator(BuildContext context, OrderStatus status) {
    String statusText;
    Color statusColor;

    switch (status) {
      case OrderStatus.REQUESTED:
        statusText = context.l10n.requested;
        statusColor = const Color(0xFFFF9800);
      case OrderStatus.MATCHING:
        statusText = context.l10n.finding_driver;
        statusColor = const Color(0xFF2196F3);
      case OrderStatus.PREPARING:
        statusText = context.l10n.preparing_order;
        statusColor = const Color(0xFFFF9800);
      case OrderStatus.READY_FOR_PICKUP:
        statusText = context.l10n.ready_for_pickup;
        statusColor = const Color(0xFF4CAF50);
      case OrderStatus.ACCEPTED:
        statusText = context.l10n.accepted;
        statusColor = const Color(0xFF4CAF50);
      case OrderStatus.ARRIVING:
        statusText = context.l10n.arriving;
        statusColor = const Color(0xFF2196F3);
      case OrderStatus.IN_TRIP:
        statusText = context.l10n.in_trip;
        statusColor = const Color(0xFF9C27B0);
      case OrderStatus.COMPLETED:
        statusText = context.l10n.completed;
        statusColor = const Color(0xFF4CAF50);
      case OrderStatus.CANCELLED_BY_USER:
        statusText = context.l10n.cancelled_by_user;
        statusColor = const Color(0xFFF44336);
      case OrderStatus.CANCELLED_BY_DRIVER:
        statusText = context.l10n.cancelled_by_driver;
        statusColor = const Color(0xFFF44336);
      case OrderStatus.CANCELLED_BY_MERCHANT:
        statusText = context.l10n.cancelled_by_merchant;
        statusColor = const Color(0xFFF44336);
      case OrderStatus.CANCELLED_BY_SYSTEM:
        statusText = context.l10n.cancelled_by_system;
        statusColor = const Color(0xFFF44336);
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
            _buildInfoRow(
              LucideIcons.package,
              context.l10n.service,
              order.type.name,
            ),
            _buildInfoRow(
              LucideIcons.mapPin,
              context.l10n.pickup_location,
              '${order.pickupLocation.y.toStringAsFixed(4)}, ${order.pickupLocation.x.toStringAsFixed(4)}',
            ),
            _buildInfoRow(
              LucideIcons.navigation,
              context.l10n.dropoff_location,
              '${order.dropoffLocation.y.toStringAsFixed(4)}, ${order.dropoffLocation.x.toStringAsFixed(4)}',
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
                        context.l10n.label_notes,
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
                      order.user?.name?.substring(0, 1).toUpperCase() ?? 'U',
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
                      Text(
                        order.user?.name ?? context.l10n.text_unknown_user,
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
                      context.showMyToast(
                        context.l10n.customer_phone_number_not_available,
                        type: ToastType.warning,
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
                child: Text(context.l10n.reject_order),
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
                    ? CircularProgressIndicator()
                    : Text(context.l10n.accept_order),
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
                  : Text(context.l10n.mark_as_arrived),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
              onPressed: isLoading
                  ? null
                  : () => _showCancelDialog(context, order.id),
              child: Text(context.l10n.cancel_order),
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
                  : Text(context.l10n.start_trip),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
              onPressed: isLoading
                  ? null
                  : () => _showCancelDialog(context, order.id),
              child: Text(context.l10n.cancel_order),
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
              : Text(context.l10n.complete_trip),
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
                  toUserName: order.user?.name ?? context.l10n.text_customer,
                );
              },
              child: Text(context.l10n.rate_customer),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
              onPressed: () => context.goNamed(Routes.driverHome.name),
              child: Text(context.l10n.back_to_home),
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
        child: Text(context.l10n.back_to_home),
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
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.reject_order),
        content: Text(context.l10n.are_you_sure_you_want_to_reject_this_order),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.cancel),
          ),
          DestructiveButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<DriverOrderCubit>().rejectOrder(orderId);
            },
            child: Text(context.l10n.reject_order),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.cancel_order),
        content: Text(context.l10n.are_you_sure_you_want_to_cancel_this_order),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.no),
          ),
          DestructiveButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<DriverOrderCubit>().cancelOrder();
            },
            child: Text(context.l10n.yes_cancel),
          ),
        ],
      ),
    );
  }

  void _showCallDialog(BuildContext context, Phone phone) {
    final phoneNumber = '+${phone.countryCode.value}${phone.number}';

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.button_call_customer),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Text(
              context.l10n.customer_phone_number,
              style: context.typography.p.copyWith(fontSize: 14.sp),
            ),
            material.SelectableText(
              phoneNumber,
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              context
                  .l10n
                  .tap_the_phone_number_to_copy_it_then_use_your_phone_app_to_call,
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
          ],
        ),
        actions: [
          PrimaryButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.close),
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
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: material.Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: context.colorScheme.border,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.chat_with_customer,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(material.Icons.close),
                      onPressed: () => Navigator.of(bottomSheetContext).pop(),
                      variance: ButtonVariance.ghost,
                    ),
                  ],
                ),
              ),
              Expanded(child: OrderChatWidget(orderId: orderId)),
            ],
          ),
        ),
      ),
    );
  }
}
