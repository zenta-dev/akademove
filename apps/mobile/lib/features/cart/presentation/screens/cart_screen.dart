import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/data/models/cart_models.dart';
import 'package:akademove/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:akademove/features/cart/presentation/states/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Cart screen displaying cart items with quantity controls and checkout button
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCart();
  }

  Future<void> _onRefresh() async {
    await context.read<CartCubit>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            context.l10n.cart_shopping_cart,
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          leading: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
          trailing: [
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state.isEmpty) return const SizedBox.shrink();
                return IconButton(
                  onPressed: () => _showClearConfirmation(context),
                  icon: Icon(LucideIcons.trash2, size: 20.sp),
                  variance: const ButtonStyle.ghost(),
                );
              },
            ),
          ],
        ),
      ],
      padding: EdgeInsets.zero,
      onRefresh: _onRefresh,
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          // Listen to cart load failures
          state.cart.whenOr(
            failure: (error) {
              showToast(
                context: context,
                builder: (context, overlay) => context.buildToast(
                  title: context.l10n.error,
                  message: error.message ?? context.l10n.an_error_occurred,
                ),
                location: ToastLocation.topCenter,
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.cart.whenOr(
            success: (cart, _) {
              if (state.isEmpty) {
                return _buildEmptyCart(context);
              }
              return _buildContent(context, state);
            },
            failure: (error) => Center(
              child: OopsAlertWidget(
                message: error.message ?? context.l10n.cart_failed_to_load,
                onRefresh: () => context.read<CartCubit>().loadCart(),
              ),
            ),
            orElse: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    final mutedColor = context.colorScheme.mutedForeground;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.dg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.shoppingCart,
              size: 80.sp,
              color: mutedColor.withValues(alpha: 0.4),
            ),
            Gap(16.h),
            Text(
              context.l10n.cart_your_cart_is_empty,
              style: context.typography.h3.copyWith(
                fontSize: 20.sp,
                color: mutedColor.withValues(alpha: 0.7),
              ),
            ),
            Gap(8.h),
            Text(
              context.l10n.cart_add_items_to_see_here,
              style: TextStyle(
                fontSize: 14.sp,
                color: mutedColor.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            Gap(24.h),
            Button(
              style: const ButtonStyle.primary(),
              onPressed: () => context.pop(),
              child: Text(context.l10n.cart_browse_amart),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CartState state) {
    final cart = state.currentCart;
    if (cart == null) return const SizedBox.shrink();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMerchantHeader(context, cart.merchantName),
                Gap(8.h),
                _buildItemsList(context, cart.items),
                Gap(16.h),
              ],
            ),
          ),
        ),
        _buildBottomBar(context, state),
      ],
    );
  }

  Widget _buildMerchantHeader(BuildContext context, String merchantName) {
    return Container(
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: context.colorScheme.mutedForeground.withValues(alpha: 0.05),
        border: Border(
          bottom: BorderSide(color: context.colorScheme.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.store, size: 20.sp),
          Gap(8.w),
          Text(
            merchantName,
            style: context.typography.semiBold.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(BuildContext context, List<CartItem> items) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final item = items[index];
        return _CartItemCard(item: item);
      },
    );
  }

  Widget _buildBottomBar(BuildContext context, CartState state) {
    final mutedColor = context.colorScheme.mutedForeground;

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
                      context.l10n.cart_total_items(state.totalItems),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: mutedColor.withValues(alpha: 0.6),
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      'Rp ${state.subtotal.toStringAsFixed(0)}',
                      style: context.typography.h3.copyWith(fontSize: 20.sp),
                    ),
                  ],
                ),
                Button(
                  style: const ButtonStyle.primary(),
                  onPressed: () {
                    context.pushNamed(Routes.userOrderConfirm.name);
                  },
                  child: Text(context.l10n.cart_checkout),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showClearConfirmation(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.cart_clear_cart),
        content: Text(context.l10n.cart_clear_cart_confirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.cancel),
          ),
          Button(
            onPressed: () {
              context.read<CartCubit>().clearCart();
              Navigator.of(dialogContext).pop();
            },
            style: ButtonStyle.destructive(),
            child: Text(context.l10n.cart_clear),
          ),
        ],
      ),
    );
  }
}

/// Individual cart item card with image, details, and quantity controls
class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final mutedColor = context.colorScheme.mutedForeground;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Item image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: item.menuImage != null
              ? CachedNetworkImage(
                  imageUrl: item.menuImage!,
                  width: 80.w,
                  height: 80.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: mutedColor.withValues(alpha: 0.1),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: mutedColor.withValues(alpha: 0.1),
                    child: Icon(
                      LucideIcons.utensilsCrossed,
                      size: 32.sp,
                      color: mutedColor.withValues(alpha: 0.5),
                    ),
                  ),
                )
              : Container(
                  width: 80.w,
                  height: 80.w,
                  color: mutedColor.withValues(alpha: 0.1),
                  child: Icon(
                    LucideIcons.utensilsCrossed,
                    size: 32.sp,
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
              Text(
                'Rp ${item.unitPrice.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: mutedColor.withValues(alpha: 0.6),
                ),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              Gap(8.h),
              // Quantity controls
              _QuantityControls(item: item),
            ],
          ),
        ),
      ],
    );
  }
}

/// Quantity increment/decrement controls
class _QuantityControls extends StatelessWidget {
  const _QuantityControls({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final mutedColor = context.colorScheme.mutedForeground;

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.read<CartCubit>().updateQuantity(
              menuId: item.menuId,
              quantity: item.quantity - 1,
            );
          },
          child: Container(
            width: 32.w,
            height: 32.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: mutedColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              item.quantity == 1 ? LucideIcons.trash2 : LucideIcons.minus,
              size: 16.sp,
            ),
          ),
        ),
        Gap(12.w),
        Text(
          item.quantity.toString(),
          style: context.typography.semiBold.copyWith(fontSize: 14.sp),
        ),
        Gap(12.w),
        GestureDetector(
          onTap: () {
            context.read<CartCubit>().updateQuantity(
              menuId: item.menuId,
              quantity: item.quantity + 1,
            );
          },
          child: Container(
            width: 32.w,
            height: 32.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(LucideIcons.plus, size: 16.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
