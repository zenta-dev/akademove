import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
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

  @override
  void initState() {
    super.initState();
    _currentOrder = widget.order;
    _loadMerchantId();
  }

  Future<void> _loadMerchantId() async {
    // TODO: Get merchant ID from auth state or merchant cubit
    // For now, use order's merchantId
    setState(() {
      _merchantId = _currentOrder.merchantId;
    });
  }

  Future<void> _handleAcceptOrder() async {
    if (_merchantId == null) {
      showMyToast('Merchant ID not found', type: ToastType.failed);
      return;
    }

    final confirmed = await showMyDialog(
      title: 'Accept Order',
      message: 'Are you sure you want to accept this order?',
    );

    if (confirmed == true && mounted) {
      await context.read<MerchantOrderCubit>().acceptOrder(
        merchantId: _merchantId!,
        orderId: _currentOrder.id,
      );

      if (mounted) {
        final cubitState = context.read<MerchantOrderCubit>().state;
        if (cubitState.isSuccess) {
          if (cubitState.selected != null) {
            setState(() => _currentOrder = cubitState.selected!);
            showMyToast(
              cubitState.message ?? 'Order accepted successfully',
              type: ToastType.success,
            );
          }
        } else if (cubitState.isFailure) {
          showMyToast(
            cubitState.error?.message ?? 'Failed to accept order',
            type: ToastType.failed,
          );
        }
      }
    }
  }

  Future<void> _handleRejectOrder() async {
    if (_merchantId == null) {
      showMyToast('Merchant ID not found', type: ToastType.failed);
      return;
    }

    // For now, use a simple dialog. TODO: Create proper rejection dialog with reasons
    final confirmed = await showMyDialog(
      title: 'Reject Order',
      message: 'Are you sure you want to reject this order?',
    );

    if (confirmed == true && mounted) {
      await context.read<MerchantOrderCubit>().rejectOrder(
        merchantId: _merchantId!,
        orderId: _currentOrder.id,
        reason: 'OUT_OF_STOCK', // TODO: Get from dialog
        note: null,
      );

      if (mounted) {
        final cubitState = context.read<MerchantOrderCubit>().state;
        if (cubitState.isSuccess) {
          showMyToast(
            cubitState.message ?? 'Order rejected successfully',
            type: ToastType.success,
          );
          context.pop(); // Go back to order list
        } else if (cubitState.isFailure) {
          showMyToast(
            cubitState.error?.message ?? 'Failed to reject order',
            type: ToastType.failed,
          );
        }
      }
    }
  }

  Future<void> _handleMarkPreparing() async {
    if (_merchantId == null) {
      showMyToast('Merchant ID not found', type: ToastType.failed);
      return;
    }

    await context.read<MerchantOrderCubit>().markPreparing(
      merchantId: _merchantId!,
      orderId: _currentOrder.id,
    );

    if (mounted) {
      final cubitState = context.read<MerchantOrderCubit>().state;
      if (cubitState.isSuccess) {
        if (cubitState.selected != null) {
          setState(() => _currentOrder = cubitState.selected!);
          showMyToast(
            cubitState.message ?? 'Order marked as preparing',
            type: ToastType.success,
          );
        }
      } else if (cubitState.isFailure) {
        showMyToast(
          cubitState.error?.message ?? 'Failed to update order',
          type: ToastType.failed,
        );
      }
    }
  }

  Future<void> _handleMarkReady() async {
    if (_merchantId == null) {
      showMyToast('Merchant ID not found', type: ToastType.failed);
      return;
    }

    await context.read<MerchantOrderCubit>().markReady(
      merchantId: _merchantId!,
      orderId: _currentOrder.id,
    );

    if (mounted) {
      final cubitState = context.read<MerchantOrderCubit>().state;
      if (cubitState.isSuccess) {
        if (cubitState.selected != null) {
          setState(() => _currentOrder = cubitState.selected!);
          showMyToast(
            cubitState.message ?? 'Order marked as ready for pickup',
            type: ToastType.success,
          );
        }
      } else if (cubitState.isFailure) {
        showMyToast(
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
                      _currentOrder.note?.text ?? '',
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
          onPressed: _handleAcceptOrder,
          child: Text(
            'Accept Order',
            style: context.typography.small.copyWith(fontSize: 16.sp),
          ),
        );
        secondaryButton = Button.destructive(
          onPressed: _handleRejectOrder,
          child: Text(
            'Reject Order',
            style: context.typography.small.copyWith(fontSize: 16.sp),
          ),
        );
        break;

      case OrderStatus.ACCEPTED:
        // Show start preparing button
        primaryButton = Button.primary(
          onPressed: _handleMarkPreparing,
          child: Text(
            'Start Preparing',
            style: context.typography.small.copyWith(fontSize: 16.sp),
          ),
        );
        break;

      case OrderStatus.PREPARING:
        // Show order ready button
        primaryButton = Button.primary(
          onPressed: _handleMarkReady,
          child: Text(
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
        // Handle state changes if needed
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
