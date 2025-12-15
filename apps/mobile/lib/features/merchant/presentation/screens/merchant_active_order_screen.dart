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

class MerchantActiveOrderScreen extends StatefulWidget {
  const MerchantActiveOrderScreen({required this.orderId, super.key});

  final String orderId;

  @override
  State<MerchantActiveOrderScreen> createState() =>
      _MerchantActiveOrderScreenState();
}

class _MerchantActiveOrderScreenState extends State<MerchantActiveOrderScreen> {
  String? _merchantId;
  OrderStatus? _previousStatus;
  late final MerchantOrderCubit _merchantOrderCubit;

  @override
  void initState() {
    super.initState();
    _merchantOrderCubit = context.read<MerchantOrderCubit>();
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
      }
    } catch (e) {
      // Silently fail - merchantId will be checked before actions
    }
  }

  Future<void> _subscribeToOrderUpdates() async {
    await _merchantOrderCubit.subscribeToOrder(widget.orderId);
  }

  Future<void> _unsubscribeFromOrderUpdates() async {
    await _merchantOrderCubit.unsubscribeFromOrder();
  }

  Future<void> _handleAcceptOrder() async {
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
      context.read<MerchantOrderCubit>().acceptOrder(
        merchantId: merchantId,
        orderId: widget.orderId,
      );
    }
  }

  Future<void> _handleRejectOrder() async {
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
      context.read<MerchantOrderCubit>().rejectOrder(
        merchantId: merchantId,
        orderId: widget.orderId,
        reason: result.reason,
        note: result.note,
      );
    }
  }

  void _handleMarkPreparing() {
    final merchantId = _merchantId;
    if (merchantId == null) {
      context.showMyToast(
        context.l10n.toast_merchant_id_not_found,
        type: ToastType.failed,
      );
      return;
    }

    context.read<MerchantOrderCubit>().markPreparing(
      merchantId: merchantId,
      orderId: widget.orderId,
    );
  }

  void _handleMarkReady() {
    final merchantId = _merchantId;
    if (merchantId == null) {
      context.showMyToast(
        context.l10n.toast_merchant_id_not_found,
        type: ToastType.failed,
      );
      return;
    }

    context.read<MerchantOrderCubit>().markReady(
      merchantId: merchantId,
      orderId: widget.orderId,
    );
  }

  /// Navigate to review screen after order completion
  Future<void> _navigateToReviewScreen(Order order) async {
    if (!mounted || !context.mounted) return;

    // Small delay to let the UI update
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted || !context.mounted) return;

    final user = order.user;

    context.pushNamed(
      Routes.merchantOrderCompletion.name,
      extra: {
        'orderId': order.id,
        'orderType': order.type,
        'order': order,
        'user': user,
        'payment': null,
      },
    );
  }

  Widget _buildCustomerInfo(BuildContext context, Order order) {
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
                Row(
                  children: [
                    Text(
                      order.user?.name ?? order.userId,
                      style: context.typography.small.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final rating = order.user?.rating;
                        if (rating == null || rating == 0) {
                          return const SizedBox.shrink();
                        }

                        return Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                '•',
                                style: context.typography.small.copyWith(
                                  color: context.colorScheme.mutedForeground,
                                ),
                              ),
                            ),
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
                                color: context.colorScheme.mutedForeground,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          ChatButtonWithBadge(
            orderId: order.id,
            onPressed: () {
              _showChatDialog(context, order.id);
            },
            variance: ButtonVariance.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfo(BuildContext context, Order order) {
    final driverId = order.driverId;
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
                order.driver?.user?.name ?? driverId,
                style: context.typography.small.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ChatButtonWithBadge(
                orderId: order.id,
                onPressed: () {
                  _showChatDialog(context, order.id);
                },
                variance: ButtonVariance.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context, Order order) {
    final items = order.items ?? [];

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
          if (order.note != null) ...[
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
                context.formatCurrency(order.basePrice),
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
                context.formatCurrency(order.totalPrice),
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

  Widget _buildOrderInfo(BuildContext context, Order order) {
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
                order.id.prefix(8),
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
                order.status.value,
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: _getStatusColor(order.status),
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
                ).format(order.requestedAt.toLocal()),
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

  Widget? _buildActionButtons(
    BuildContext context,
    MerchantOrderState state,
    Order order,
  ) {
    final status = order.status;

    // Only show actions for food orders that belong to this merchant
    if (order.type != OrderType.FOOD || order.merchantId == null) {
      return null;
    }

    // Extract action-specific loading states
    final isAccepting = state.acceptOrderResult.isLoading;
    final isRejecting = state.rejectOrderResult.isLoading;
    final isPreparing = state.markPreparingResult.isLoading;
    final isMarkingReady = state.markReadyResult.isLoading;

    Widget? primaryButton;
    Widget? secondaryButton;

    switch (status) {
      case OrderStatus.REQUESTED:
        // Show accept/reject buttons for new incoming orders
        primaryButton = ActionButton.primary(
          isLoading: isAccepting,
          enabled: !isRejecting,
          onPressed: _handleAcceptOrder,
          child: Text(
            context.l10n.accept_order,
            style: context.typography.small.copyWith(fontSize: 16.sp),
          ),
        );
        secondaryButton = ActionButton.destructive(
          isLoading: isRejecting,
          enabled: !isAccepting,
          onPressed: _handleRejectOrder,
          child: Text(
            context.l10n.reject_order,
            style: context.typography.small.copyWith(fontSize: 16.sp),
          ),
        );
        break;

      case OrderStatus.MATCHING:
        // Show finding driver message (order is ready, searching for driver)
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              context.l10n.finding_driver,
              style: context.typography.small.copyWith(
                fontSize: 16.sp,
                color: const Color(0xFFFFA500), // Orange
              ),
            ),
          ),
        );

      case OrderStatus.ACCEPTED:
        // Show start preparing button
        primaryButton = ActionButton.primary(
          isLoading: isPreparing,
          onPressed: _handleMarkPreparing,
          child: Text(
            context.l10n.start_preparing,
            style: context.typography.small.copyWith(fontSize: 16.sp),
          ),
        );
        break;

      case OrderStatus.PREPARING:
        // Show order ready button
        primaryButton = ActionButton.primary(
          isLoading: isMarkingReady,
          onPressed: _handleMarkReady,
          child: Text(
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

  /// Get order from cubit state - check both `order` and `orders` list
  Order? _getOrderFromState(MerchantOrderState state) {
    // First try to get from selected order
    final selectedOrder = state.order.value;
    if (selectedOrder != null && selectedOrder.id == widget.orderId) {
      return selectedOrder;
    }

    // Fall back to orders list
    final orders = state.orders.value;
    if (orders != null) {
      return orders.where((o) => o.id == widget.orderId).firstOrNull;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listen for accept order result
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) =>
              previous.acceptOrderResult != current.acceptOrderResult,
          listener: (context, state) {
            if (state.acceptOrderResult.isSuccess) {
              final message = state.acceptOrderResult.message;
              if (message != null && message.isNotEmpty) {
                context.showMyToast(message, type: ToastType.success);
              }
            }
            if (state.acceptOrderResult.isFailure) {
              context.showMyToast(
                state.acceptOrderResult.error?.message ??
                    context.l10n.an_error_occurred,
                type: ToastType.failed,
              );
            }
          },
        ),
        // Listen for reject order result
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) =>
              previous.rejectOrderResult != current.rejectOrderResult,
          listener: (context, state) {
            if (state.rejectOrderResult.isSuccess) {
              final updatedOrder = state.rejectOrderResult.value;
              if (updatedOrder != null && updatedOrder.id == widget.orderId) {
                final message = state.rejectOrderResult.message;
                if (message != null && message.isNotEmpty) {
                  context.showMyToast(message, type: ToastType.success);
                }
                // Navigate back after rejection
                context.pop();
              }
            }
            if (state.rejectOrderResult.isFailure) {
              context.showMyToast(
                state.rejectOrderResult.error?.message ??
                    context.l10n.an_error_occurred,
                type: ToastType.failed,
              );
            }
          },
        ),
        // Listen for mark preparing result
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) =>
              previous.markPreparingResult != current.markPreparingResult,
          listener: (context, state) {
            if (state.markPreparingResult.isSuccess) {
              final message = state.markPreparingResult.message;
              if (message != null && message.isNotEmpty) {
                context.showMyToast(message, type: ToastType.success);
              }
            }
            if (state.markPreparingResult.isFailure) {
              context.showMyToast(
                state.markPreparingResult.error?.message ??
                    context.l10n.an_error_occurred,
                type: ToastType.failed,
              );
            }
          },
        ),
        // Listen for mark ready result
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) =>
              previous.markReadyResult != current.markReadyResult,
          listener: (context, state) {
            if (state.markReadyResult.isSuccess) {
              final message = state.markReadyResult.message;
              if (message != null && message.isNotEmpty) {
                context.showMyToast(message, type: ToastType.success);
              }
            }
            if (state.markReadyResult.isFailure) {
              context.showMyToast(
                state.markReadyResult.error?.message ??
                    context.l10n.an_error_occurred,
                type: ToastType.failed,
              );
            }
          },
        ),
        // Listen for order completion to navigate to review screen
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) {
            final prevOrder = _getOrderFromState(previous);
            final currOrder = _getOrderFromState(current);
            return prevOrder?.status != currOrder?.status;
          },
          listener: (context, state) {
            final order = _getOrderFromState(state);
            if (order == null) return;

            final newStatus = order.status;

            // Check if order just transitioned to COMPLETED
            if (_previousStatus != null &&
                _previousStatus != OrderStatus.COMPLETED &&
                newStatus == OrderStatus.COMPLETED) {
              _navigateToReviewScreen(order);
            }

            _previousStatus = newStatus;
          },
        ),
      ],
      child: BlocBuilder<MerchantOrderCubit, MerchantOrderState>(
        builder: (context, state) {
          final order = _getOrderFromState(state);

          // Show loading if order not yet available
          if (order == null) {
            return Scaffold(
              headers: [
                DefaultAppBar(
                  title: context.l10n.order_detail,
                  subtitle: 'F-${widget.orderId.prefix(8)}',
                ),
              ],
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          // Update previous status for completion detection
          _previousStatus ??= order.status;

          final actionButtons = _buildActionButtons(context, state, order);

          return Scaffold(
            headers: [
              DefaultAppBar(
                title: context.l10n.order_detail,
                subtitle: 'F-${order.id.prefix(8)}',
              ),
            ],
            footers: [?actionButtons],
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(16.dg),
                child: Column(
                  spacing: 16.h,
                  children: [
                    _buildCustomerInfo(context, order),
                    _buildDriverInfo(context, order),
                    _buildOrderDetails(context, order),
                    _buildOrderInfo(context, order),
                    // Add bottom padding if there are action buttons
                    if (actionButtons != null) SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          );
        },
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
