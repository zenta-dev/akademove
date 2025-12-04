import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/data/models/cart_models.dart'
    show Cart, CartItem;
import 'package:akademove/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:akademove/features/cart/presentation/states/_export.dart';
import 'package:akademove/features/order/data/repositories/order_repository.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart' hide Cart, CartItem;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Order confirmation screen displaying cart summary and payment method selection
class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({required this.orderRepository, super.key});

  final OrderRepository orderRepository;

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.wallet;
  bool _isPlacingOrder = false;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            context.l10n.order_confirm_title,
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          leading: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
        ),
      ],
      padding: EdgeInsets.zero,
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.isEmpty || state.cart == null) {
            // Cart is empty, redirect back
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) context.pop();
            });
            return const Center(child: CircularProgressIndicator());
          }

          return _buildContent(context, state.cart!);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, Cart cart) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOrderSummarySection(context, cart),
                Divider(height: 1, color: context.colorScheme.border),
                _buildPaymentMethodSection(context),
                Divider(height: 1, color: context.colorScheme.border),
                _buildPriceSummary(context, cart),
              ],
            ),
          ),
        ),
        _buildBottomBar(context, cart),
      ],
    );
  }

  Widget _buildOrderSummarySection(BuildContext context, Cart cart) {
    final mutedColor = context.colorScheme.mutedForeground;

    return Padding(
      padding: EdgeInsets.all(16.dg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.order_confirm_order_summary,
            style: context.typography.h4.copyWith(fontSize: 16.sp),
          ),
          Gap(12.h),
          // Merchant info
          Row(
            children: [
              Icon(
                LucideIcons.store,
                size: 16.sp,
                color: mutedColor.withValues(alpha: 0.6),
              ),
              Gap(8.w),
              Text(
                context.l10n.order_confirm_merchant,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: mutedColor.withValues(alpha: 0.6),
                ),
              ),
              Gap(8.w),
              Text(
                cart.merchantName,
                style: context.typography.semiBold.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
          Gap(16.h),
          // Items list
          ...cart.items.map((item) => _buildItemRow(context, item)),
        ],
      ),
    );
  }

  Widget _buildItemRow(BuildContext context, CartItem item) {
    final mutedColor = context.colorScheme.mutedForeground;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: item.menuImage != null
                ? CachedNetworkImage(
                    imageUrl: item.menuImage!,
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: mutedColor.withValues(alpha: 0.1),
                      child: Center(
                        child: SizedBox(
                          width: 16.sp,
                          height: 16.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: mutedColor.withValues(alpha: 0.1),
                      child: Icon(
                        material.Icons.fastfood,
                        size: 24.sp,
                        color: mutedColor.withValues(alpha: 0.5),
                      ),
                    ),
                  )
                : Container(
                    width: 50.w,
                    height: 50.w,
                    color: mutedColor.withValues(alpha: 0.1),
                    child: Icon(
                      material.Icons.fastfood,
                      size: 24.sp,
                      color: mutedColor.withValues(alpha: 0.5),
                    ),
                  ),
          ),
          Gap(12.w),
          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.menuName,
                  style: context.typography.semiBold.copyWith(fontSize: 14.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.quantity}x',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: mutedColor.withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      'Rp ${(item.unitPrice * item.quantity).toStringAsFixed(0)}',
                      style: context.typography.semiBold.copyWith(
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
                if (item.notes != null && item.notes!.isNotEmpty) ...[
                  Gap(4.h),
                  Text(
                    '${context.l10n.cart_note_prefix}${item.notes}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontStyle: FontStyle.italic,
                      color: mutedColor.withValues(alpha: 0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection(BuildContext context) {
    final mutedColor = context.colorScheme.mutedForeground;

    return Padding(
      padding: EdgeInsets.all(16.dg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.order_confirm_payment_method,
            style: context.typography.h4.copyWith(fontSize: 16.sp),
          ),
          Gap(12.h),
          // wallet payment option
          material.Material(
            color: _selectedPaymentMethod == PaymentMethod.wallet
                ? context.colorScheme.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            child: material.InkWell(
              onTap: () {
                setState(() {
                  _selectedPaymentMethod = PaymentMethod.wallet;
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.all(12.dg),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedPaymentMethod == PaymentMethod.wallet
                        ? context.colorScheme.primary
                        : context.colorScheme.border,
                    width: _selectedPaymentMethod == PaymentMethod.wallet
                        ? 2
                        : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.wallet,
                      size: 24.sp,
                      color: _selectedPaymentMethod == PaymentMethod.wallet
                          ? context.colorScheme.primary
                          : mutedColor,
                    ),
                    Gap(12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.order_confirm_payment_wallet,
                            style: context.typography.semiBold.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          Gap(2.h),
                          Text(
                            context.l10n.order_confirm_payment_description,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: mutedColor.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_selectedPaymentMethod == PaymentMethod.wallet)
                      Icon(
                        LucideIcons.circleCheck,
                        size: 20.sp,
                        color: context.colorScheme.primary,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummary(BuildContext context, Cart cart) {
    final mutedColor = context.colorScheme.mutedForeground;

    return Padding(
      padding: EdgeInsets.all(16.dg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.order_confirm_subtotal,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: mutedColor.withValues(alpha: 0.8),
                ),
              ),
              Text(
                'Rp ${cart.subtotal.toStringAsFixed(0)}',
                style: context.typography.semiBold.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
          Gap(8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.order_confirm_items_count(cart.totalItems),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: mutedColor.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, Cart cart) {
    return Container(
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        border: Border(
          top: BorderSide(color: context.colorScheme.border, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.total,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      'Rp ${cart.subtotal.toStringAsFixed(0)}',
                      style: context.typography.h3.copyWith(fontSize: 20.sp),
                    ),
                  ],
                ),
                Button(
                  style: const ButtonStyle.primary(),
                  onPressed: _isPlacingOrder
                      ? null
                      : () => _placeOrder(context, cart),
                  child: _isPlacingOrder
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 16.sp,
                              height: 16.sp,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                            Gap(8.w),
                            Text(context.l10n.order_confirm_processing),
                          ],
                        )
                      : Text(context.l10n.order_confirm_place_order),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _placeOrder(BuildContext context, Cart cart) async {
    setState(() {
      _isPlacingOrder = true;
    });

    try {
      // For food orders, we need pickup and dropoff locations
      // For now, use merchant location as pickup and a default dropoff
      // In production, you would get these from user input or profile
      final pickupLocation = const Coordinate(
        x: 106.8271,
        y: -6.1751,
      ); // Default Jakarta
      final dropoffLocation = const Coordinate(
        x: 106.8271,
        y: -6.1751,
      ); // Same as pickup for now

      // Convert cart items to order items
      final orderItems = cart.items.map((item) {
        return OrderItem(
          quantity: item.quantity,
          item: OrderItemItem(
            id: item.menuId,
            merchantId: item.merchantId,
            name: item.menuName,
            image: item.menuImage,
            price: item.unitPrice,
          ),
        );
      }).toList();

      // Create place order request
      final placeOrderRequest = PlaceOrder(
        type: OrderType.FOOD,
        pickupLocation: pickupLocation,
        dropoffLocation: dropoffLocation,
        items: orderItems,
        payment: PlaceOrderPayment(
          method: _selectedPaymentMethod,
          provider: PaymentProvider.MANUAL,
        ),
      );

      // Call API via repository
      final response = await widget.orderRepository.placeOrder(
        placeOrderRequest,
      );

      if (!mounted) return;

      if (response.isSuccess && mounted) {
        // Clear cart
        // ignore: use_build_context_synchronously
        context.read<CartCubit>().clearCart();

        // Show success message
        // ignore: use_build_context_synchronously
        final successTitle = context.l10n.order_confirm_success;
        // ignore: use_build_context_synchronously
        final successMessage = context.l10n.order_confirm_success_message;
        // ignore: use_build_context_synchronously
        showToast(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (ctx, overlay) =>
              ctx.buildToast(title: successTitle, message: successMessage),
          location: ToastLocation.topCenter,
        );

        // For food orders, navigate to home for now
        // TODO: Consider adding order tracking screen for food orders
        // by updating UserOrderCubit state and navigating to userRideOnTrip
        // ignore: use_build_context_synchronously
        context.go('/user/home');
      } else {
        throw Exception('Failed to place order');
      }
    } catch (e) {
      logger.e('Failed to place order', error: e);

      if (mounted) {
        // ignore: use_build_context_synchronously
        final failedTitle = context.l10n.order_confirm_failed;
        // ignore: use_build_context_synchronously
        showToast(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (ctx, overlay) =>
              ctx.buildToast(title: failedTitle, message: e.toString()),
          location: ToastLocation.topCenter,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPlacingOrder = false;
        });
      }
    }
  }
}
