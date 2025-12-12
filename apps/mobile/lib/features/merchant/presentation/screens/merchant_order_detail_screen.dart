import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
    try {
      // Get merchant ID from MerchantCubit
      final merchantState = context.read<MerchantCubit>().state;
      final currentMerchant = merchantState.mine.value;

      if (currentMerchant != null) {
        setState(() {
          _merchantId = currentMerchant.id;
        });
      } else {
        // Fallback to order's merchantId if cubit state is empty
        setState(() {
          _merchantId = _currentOrder.merchantId;
        });
      }
    } catch (e) {
      // Fallback to order's merchantId on error
      setState(() {
        _merchantId = _currentOrder.merchantId;
      });
    }
  }

  Future<void> _onRefresh() async {
    final result = await sl<OrderRepository>().get(_currentOrder.id);
    final order = result.data;
    if (mounted) {
      setState(() {
        _currentOrder = order;
      });
    }
  }

  Future<void> _subscribeToOrderUpdates() async {
    await context.read<MerchantOrderCubit>().subscribeToOrder(_currentOrder.id);
  }

  Future<void> _unsubscribeFromOrderUpdates() async {
    await context.read<MerchantOrderCubit>().unsubscribeFromOrder();
  }

  void _handleAcceptOrder() async {
    if (_isProcessing) return;

    final merchantId = _merchantId;
    if (merchantId == null) {
      context.showMyToast(
        context.l10n.toast_merchant_id_not_found,
        type: ToastType.failed,
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.accept_order),
        content: Text(context.l10n.message_confirm_accept_order),
        actions: [
          Button.ghost(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.cancel),
          ),
          Button.primary(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.accept),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() => _isProcessing = true);

      // Just trigger the cubit action - response handling is done via BlocListener
      context.read<MerchantOrderCubit>().acceptOrder(
        merchantId: merchantId,
        orderId: _currentOrder.id,
      );
    }
  }

  void _handleRejectOrder() async {
    if (_isProcessing) return;

    final merchantId = _merchantId;
    if (merchantId == null) {
      context.showMyToast(
        context.l10n.toast_merchant_id_not_found,
        type: ToastType.failed,
      );
      return;
    }

    final result = await showOrderRejectionDialog(context: context);

    if (result != null && mounted) {
      setState(() => _isProcessing = true);

      // Just trigger the cubit action - response handling is done via BlocListener
      context.read<MerchantOrderCubit>().rejectOrder(
        merchantId: merchantId,
        orderId: _currentOrder.id,
        reason: result.reason,
        note: result.note,
      );
    }
  }

  void _handleMarkPreparing() {
    if (_isProcessing) return;

    final merchantId = _merchantId;
    if (merchantId == null) {
      context.showMyToast(
        context.l10n.toast_merchant_id_not_found,
        type: ToastType.failed,
      );
      return;
    }

    setState(() => _isProcessing = true);

    // Just trigger the cubit action - response handling is done via BlocListener
    context.read<MerchantOrderCubit>().markPreparing(
      merchantId: merchantId,
      orderId: _currentOrder.id,
    );
  }

  void _handleMarkReady() {
    if (_isProcessing) return;

    final merchantId = _merchantId;
    if (merchantId == null) {
      context.showMyToast(
        context.l10n.toast_merchant_id_not_found,
        type: ToastType.failed,
      );
      return;
    }

    setState(() => _isProcessing = true);

    // Just trigger the cubit action - response handling is done via BlocListener
    context.read<MerchantOrderCubit>().markReady(
      merchantId: merchantId,
      orderId: _currentOrder.id,
    );
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
                  context.l10n.ordered_by,
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  _currentOrder.user?.name ?? _currentOrder.userId,
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
              _showChatDialog(context, _currentOrder.id);
            },
            icon: const Icon(LucideIcons.messageCircle),
            variance: ButtonVariance.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfo(BuildContext context) {
    final driverId = _currentOrder.driverId;
    if (driverId == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Column(
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.driver_assigned,
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentOrder.driver?.user?.name ?? driverId,
                style: context.typography.small.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {
                  _showChatDialog(context, _currentOrder.id);
                },
                icon: const Icon(LucideIcons.messageCircle),
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
            context.l10n.order_items,
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
                  item.item.name ?? context.l10n.unknown_item,
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
                children: [const Icon(LucideIcons.bookOpen)],
              ),
            ),
          ],
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.w,
            children: [
              Text(
                context.l10n.base_price,
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
                context.l10n.total,
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
                context.l10n.order_id,
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _currentOrder.id.prefix(8),
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
                context.l10n.label_status,
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
                context.l10n.order_time,
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                DateFormat(
                  'yyyy-MM-dd HH:mm',
                ).format(_currentOrder.requestedAt.toLocal()),
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

  Widget? _buildActionButtons(BuildContext context) {
    final status = _currentOrder.status;

    // Only show actions for food orders that belong to this merchant
    if (_currentOrder.type != OrderType.FOOD ||
        _currentOrder.merchantId == null) {
      return null;
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
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(),
                )
              : Text(
                  context.l10n.accept_order,
                  style: context.typography.small.copyWith(fontSize: 16.sp),
                ),
        );
        secondaryButton = Button.destructive(
          onPressed: _isProcessing ? null : _handleRejectOrder,
          child: Text(
            context.l10n.reject_order,
            style: context.typography.small.copyWith(fontSize: 16.sp),
          ),
        );
        break;

      case OrderStatus.ACCEPTED:
        // Show start preparing button
        primaryButton = Button.primary(
          onPressed: _isProcessing ? null : _handleMarkPreparing,
          child: _isProcessing
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(),
                )
              : Text(
                  context.l10n.start_preparing,
                  style: context.typography.small.copyWith(fontSize: 16.sp),
                ),
        );
        break;

      case OrderStatus.PREPARING:
        // Show order ready button
        primaryButton = Button.primary(
          onPressed: _isProcessing ? null : _handleMarkReady,
          child: _isProcessing
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(),
                )
              : Text(
                  context.l10n.order_ready,
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
              context.l10n.waiting_for_driver_pickup,
              style: context.typography.small.copyWith(
                fontSize: 16.sp,
                color: const Color(0xFF0000FF), // Blue
              ),
            ),
          ),
        );

      default:
        return null;
    }

    // At this point, primaryButton is guaranteed to be non-null
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
                Expanded(child: primaryButton),
                Expanded(child: secondaryButton),
              ],
            )
          : primaryButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    final actionButtons = _buildActionButtons(context);

    return BlocListener<MerchantOrderCubit, MerchantOrderState>(
      listenWhen: (previous, current) => previous.order != current.order,
      listener: (context, state) {
        // Handle loading state end
        if (!state.order.isLoading && _isProcessing) {
          setState(() => _isProcessing = false);
        }

        // Handle success
        if (state.order.isSuccess) {
          final selectedOrder = state.order.value;
          if (selectedOrder != null && selectedOrder.id == _currentOrder.id) {
            // Check if order was rejected (status changed to cancelled by merchant)
            final wasRejected =
                _currentOrder.status != selectedOrder.status &&
                selectedOrder.status == OrderStatus.CANCELLED_BY_MERCHANT;

            setState(() {
              _currentOrder = selectedOrder;
            });

            // Show toast for important events
            final message = state.order.message;
            if (message != null && message.isNotEmpty) {
              context.showMyToast(message, type: ToastType.success);
            }

            // Navigate back if order was rejected
            if (wasRejected) {
              context.pop();
            }
          }
        }

        // Handle failure
        if (state.order.isFailure) {
          context.showMyToast(
            state.order.error?.message ?? context.l10n.an_error_occurred,
            type: ToastType.failed,
          );
        }
      },
      child: Scaffold(
        headers: [
          DefaultAppBar(
            title: context.l10n.order_detail,
            subtitle: 'F-${_currentOrder.id.prefix(8)}',
          ),
        ],
        footers: [?actionButtons],
        child: RefreshTrigger(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(16.dg),
              child: Column(
                spacing: 16.h,
                children: [
                  _buildCustomerInfo(context),
                  _buildDriverInfo(context),
                  _buildOrderDetails(context),
                  _buildOrderInfo(context),
                  // Add bottom padding if there are action buttons
                  if (actionButtons != null) SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showChatDialog(BuildContext context, String orderId) {
    openDrawer(
      context: context,
      position: OverlayPosition.bottom,
      expands: true,
      builder: (drawerContext) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.order_chat,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.x),
                  onPressed: () => closeDrawer(drawerContext),
                  variance: ButtonVariance.ghost,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(child: OrderChatWidget(orderId: orderId)),
          ],
        ),
      ),
    );
  }
}
