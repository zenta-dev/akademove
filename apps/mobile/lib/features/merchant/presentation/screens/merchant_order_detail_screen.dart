import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/features/merchant/presentation/widgets/order_rejection_dialog.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantOrderDetailScreen extends StatefulWidget {
  const MerchantOrderDetailScreen({required this.order, super.key});

  final Order order;

  @override
  State<MerchantOrderDetailScreen> createState() =>
      _MerchantOrderDetailScreenState();
}

class _MerchantOrderDetailScreenState extends State<MerchantOrderDetailScreen> {
  late Order _currentOrder;
  String? _merchantId;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _currentOrder = widget.order;
    _loadMerchantId();
    _subscribeToOrderUpdates();
  }

  @override
  void dispose() {
    _unsubscribeFromOrderUpdates();
    super.dispose();
  }

  Future<void> _loadMerchantId() async {
    // TODO: Get merchant ID from auth state or merchant cubit
    // For now, use order's merchantId
    setState(() {
      _merchantId = _currentOrder.merchantId;
    });
  }

  Future<void> _subscribeToOrderUpdates() async {
    await context.read<MerchantOrderCubit>().subscribeToOrder(_currentOrder.id);
  }

  Future<void> _unsubscribeFromOrderUpdates() async {
    await context.read<MerchantOrderCubit>().unsubscribeFromOrder();
  }

  Future<void> _handleAcceptOrder() async {
    if (_isProcessing) return;

    if (_merchantId == null) {
      context.showMyToast('Merchant ID not found', type: ToastType.failed);
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Accept Order'),
        content: const Text('Are you sure you want to accept this order?'),
        actions: [
          Button.ghost(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          Button.primary(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Accept'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() => _isProcessing = true);

      await context.read<MerchantOrderCubit>().acceptOrder(
        merchantId: _merchantId!,
        orderId: _currentOrder.id,
      );

      if (mounted) {
        setState(() => _isProcessing = false);

        final cubitState = context.read<MerchantOrderCubit>().state;
        if (cubitState.isSuccess) {
          if (cubitState.selected != null) {
            setState(() => _currentOrder = cubitState.selected!);
            context.showMyToast(
              cubitState.message ?? 'Order accepted successfully',
              type: ToastType.success,
            );
          }
        } else if (cubitState.isFailure) {
          context.showMyToast(
            cubitState.error?.message ?? 'Failed to accept order',
            type: ToastType.failed,
          );
        }
      }
    }
  }

  Future<void> _handleRejectOrder() async {
    if (_isProcessing) return;

    if (_merchantId == null) {
      context.showMyToast('Merchant ID not found', type: ToastType.failed);
      return;
    }

    final result = await showOrderRejectionDialog(context: context);

    if (result != null && mounted) {
      setState(() => _isProcessing = true);

      await context.read<MerchantOrderCubit>().rejectOrder(
        merchantId: _merchantId!,
        orderId: _currentOrder.id,
        reason: result['reason'] as String,
        note: result['note'] as String?,
      );

      if (mounted) {
        setState(() => _isProcessing = false);

        final cubitState = context.read<MerchantOrderCubit>().state;
        if (cubitState.isSuccess) {
          context.showMyToast(
            cubitState.message ?? 'Order rejected successfully',
            type: ToastType.success,
          );
          context.pop(); // Go back to order list
        } else if (cubitState.isFailure) {
          context.showMyToast(
            cubitState.error?.message ?? 'Failed to reject order',
            type: ToastType.failed,
          );
        }
      }
    }
  }

  Future<void> _handleMarkPreparing() async {
    if (_isProcessing) return;

    if (_merchantId == null) {
      context.showMyToast('Merchant ID not found', type: ToastType.failed);
      return;
    }

    setState(() => _isProcessing = true);

    await context.read<MerchantOrderCubit>().markPreparing(
      merchantId: _merchantId!,
      orderId: _currentOrder.id,
    );

    if (mounted) {
      setState(() => _isProcessing = false);

      final cubitState = context.read<MerchantOrderCubit>().state;
      if (cubitState.isSuccess) {
        if (cubitState.selected != null) {
          setState(() => _currentOrder = cubitState.selected!);
          context.showMyToast(
            cubitState.message ?? 'Order marked as preparing',
            type: ToastType.success,
          );
        }
      } else if (cubitState.isFailure) {
        context.showMyToast(
          cubitState.error?.message ?? 'Failed to update order',
          type: ToastType.failed,
        );
      }
    }
  }

  Future<void> _handleMarkReady() async {
    if (_isProcessing) return;

    if (_merchantId == null) {
      context.showMyToast('Merchant ID not found', type: ToastType.failed);
      return;
    }

    setState(() => _isProcessing = true);

    await context.read<MerchantOrderCubit>().markReady(
      merchantId: _merchantId!,
      orderId: _currentOrder.id,
    );

    if (mounted) {
      setState(() => _isProcessing = false);

      final cubitState = context.read<MerchantOrderCubit>().state;
      if (cubitState.isSuccess) {
        if (cubitState.selected != null) {
          setState(() => _currentOrder = cubitState.selected!);
          context.showMyToast(
            cubitState.message ?? 'Order marked as ready for pickup',
            type: ToastType.success,
          );
        }
      } else if (cubitState.isFailure) {
        context.showMyToast(
          cubitState.error?.message ?? 'Failed to update order',
          type: ToastType.failed,
        );
      }
    }
  }

  Widget _buildCustomerInfo(BuildContext context) {
    return Card(
      child: Row(
        spacing: 8.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ordered by',
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  _currentOrder.userId, // TODO: Fetch user name
                  style: context.typography.small.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Open chat
            },
            icon: const Icon(Icons.message_rounded),
            variance: ButtonVariance.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfo(BuildContext context) {
    if (_currentOrder.driverId == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Column(
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Driver assigned',
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentOrder.driverId!, // TODO: Fetch driver name
                style: context.typography.small.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {
                  // TODO: Open chat with driver
                },
                icon: const Icon(Icons.message_rounded),
                variance: ButtonVariance.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
    final items = _currentOrder.items ?? [];

    return Card(
      child: Column(
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Items',
            style: context.typography.small.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          ...items.map(
            (item) => Row(
              spacing: 8.w,
              children: [
                Text(
                  '${item.quantity}x',
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  item.item.name ?? 'Unknown Item',
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (_currentOrder.note != null) ...[
            Gap(8.h),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0XFF7F7035),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                spacing: 8.w,
                children: [
                  const Icon(Icons.menu_book_rounded),
                  Expanded(
                    child: Text(
                      _currentOrder.note?.instructions ?? '',
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.w,
            children: [
              Text(
                'Base Price',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                context.formatCurrency(_currentOrder.basePrice),
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.w,
            children: [
              Text(
                'Total',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                context.formatCurrency(_currentOrder.totalPrice),
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    return Card(
      child: Column(
        spacing: 8.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.w,
            children: [
              Text(
                'Order ID',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _currentOrder.id.substring(0, 8),
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.w,
            children: [
              Text(
                'Status',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _currentOrder.status.value,
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: _getStatusColor(_currentOrder.status),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.w,
            children: [
              Text(
                'Order Time',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _currentOrder.requestedAt.toString().substring(0, 16),
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.REQUESTED:
      case OrderStatus.MATCHING:
        return const Color(0xFFFFA500); // Orange
      case OrderStatus.ACCEPTED:
      case OrderStatus.PREPARING:
        return const Color(0xFF0000FF); // Blue
      case OrderStatus.READY_FOR_PICKUP:
      case OrderStatus.ARRIVING:
      case OrderStatus.IN_TRIP:
        return const Color(0xFF800080); // Purple
      case OrderStatus.COMPLETED:
        return const Color(0xFF008000); // Green
      default:
        return const Color(0xFFFF0000); // Red
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    final status = _currentOrder.status;

    // Only show actions for food orders that belong to this merchant
    if (_currentOrder.type != OrderType.FOOD ||
        _currentOrder.merchantId == null) {
      return const SizedBox.shrink();
    }

    Widget? primaryButton;
    Widget? secondaryButton;

    switch (status) {
      case OrderStatus.REQUESTED:
      case OrderStatus.MATCHING:
        // Show accept/reject buttons
        primaryButton = Button.primary(
          onPressed: _isProcessing ? null : _handleAcceptOrder,
          child: _isProcessing
              ? material.SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const material.CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: material.AlwaysStoppedAnimation<material.Color>(
                      material.Colors.white,
                    ),
                  ),
                )
              : Text(
                  'Accept Order',
                  style: context.typography.small.copyWith(fontSize: 16.sp),
                ),
        );
        secondaryButton = Button.destructive(
          onPressed: _isProcessing ? null : _handleRejectOrder,
          child: Text(
            'Reject Order',
            style: context.typography.small.copyWith(fontSize: 16.sp),
          ),
        );
        break;

      case OrderStatus.ACCEPTED:
        // Show start preparing button
        primaryButton = Button.primary(
          onPressed: _isProcessing ? null : _handleMarkPreparing,
          child: _isProcessing
              ? material.SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const material.CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: material.AlwaysStoppedAnimation<material.Color>(
                      material.Colors.white,
                    ),
                  ),
                )
              : Text(
                  'Start Preparing',
                  style: context.typography.small.copyWith(fontSize: 16.sp),
                ),
        );
        break;

      case OrderStatus.PREPARING:
        // Show order ready button
        primaryButton = Button.primary(
          onPressed: _isProcessing ? null : _handleMarkReady,
          child: _isProcessing
              ? material.SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const material.CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: material.AlwaysStoppedAnimation<material.Color>(
                      material.Colors.white,
                    ),
                  ),
                )
              : Text(
                  'Order Ready',
                  style: context.typography.small.copyWith(fontSize: 16.sp),
                ),
        );
        break;

      case OrderStatus.READY_FOR_PICKUP:
        // Show waiting for driver message
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              'Waiting for driver to pickup...',
              style: context.typography.small.copyWith(
                fontSize: 16.sp,
                color: const Color(0xFF0000FF), // Blue
              ),
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: secondaryButton != null
          ? Row(
              spacing: 16.w,
              children: [
                Expanded(child: primaryButton!),
                Expanded(child: secondaryButton),
              ],
            )
          : primaryButton ?? const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MerchantOrderCubit, MerchantOrderState>(
      listener: (context, state) {
        // Update current order when state changes (from WebSocket or actions)
        if (state.selected != null && state.selected!.id == _currentOrder.id) {
          setState(() {
            _currentOrder = state.selected!;
          });

          // Show toast for important events
          if (state.message != null && state.message!.isNotEmpty) {
            context.showMyToast(state.message!, type: ToastType.success);
          }
        }
      },
      child: Stack(
        children: [
          MyScaffold(
            headers: [
              DefaultAppBar(
                title: 'Order Detail',
                subtitle: 'F-${_currentOrder.id.substring(0, 8)}',
              ),
            ],
            padding: EdgeInsets.all(16.w),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 120.h),
                child: Column(
                  spacing: 16.h,
                  children: [
                    _buildCustomerInfo(context),
                    _buildDriverInfo(context),
                    _buildOrderDetails(context),
                    _buildOrderInfo(context),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(child: _buildActionButtons(context)),
          ),
        ],
      ),
    );
  }
}
