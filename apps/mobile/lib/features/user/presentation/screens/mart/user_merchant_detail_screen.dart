import "package:akademove/app/router/router.dart";
import "package:akademove/core/_export.dart";
import "package:akademove/features/features.dart";
import "package:akademove/features/user/presentation/cubits/user_merchant_detail_cubit.dart";
import "package:akademove/l10n/l10n.dart";
import "package:api_client/api_client.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// User Merchant Detail Screen - Clean marketplace-style storefront layout
class UserMerchantDetailScreen extends StatefulWidget {
  /// Merchant ID to load
  final String merchantId;
  final Merchant merchant;

  const UserMerchantDetailScreen({
    required this.merchantId,
    required this.merchant,
    super.key,
  });

  @override
  State<UserMerchantDetailScreen> createState() =>
      _UserMerchantDetailScreenState();
}

class _UserMerchantDetailScreenState extends State<UserMerchantDetailScreen> {
  late UserMerchantDetailCubit _detailCubit;
  late CartCubit _cartCubit;

  @override
  void initState() {
    super.initState();
    _detailCubit = context.read<UserMerchantDetailCubit>();
    _cartCubit = context.read<CartCubit>();

    _detailCubit.getMerchantDetail(
      widget.merchantId,
      merchant: widget.merchant,
    );
  }

  Future<void> _onRefresh() async {
    await _detailCubit.getMerchantDetail(
      widget.merchantId,
      merchant: widget.merchant,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final previousMerchantId = _detailCubit.currentMerchantId;
    if (previousMerchantId != null && previousMerchantId != widget.merchantId) {
      _cartCubit.clearCart();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showToast(
            context: context,
            location: ToastLocation.bottomCenter,
            builder: (context, overlay) => context.buildToast(
              title: "Cart Cleared",
              message: "Previous cart cleared",
            ),
          );
        }
      });
    }

    _detailCubit.checkStockChanges(widget.merchantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          leading: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
        ),
      ],
      child: BlocConsumer<UserMerchantDetailCubit, UserMerchantDetailState>(
        listener: (context, state) {
          if (state.menuByCategory.isFailure &&
              state.menuByCategory.message != null) {
            showToast(
              context: context,
              location: ToastLocation.bottomCenter,
              builder: (context, overlay) => context.buildToast(
                title: context.l10n.error,
                message: state.menuByCategory.message!,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.menuByCategory.isLoading &&
              state.menuByCategory.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.menuByCategory.isFailure &&
              state.menuByCategory.value == null) {
            return _buildErrorState(context, state);
          }

          if (state.isEmpty) {
            return _buildEmptyState(context);
          }

          return _buildDetailContent(context, state);
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, UserMerchantDetailState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.circleAlert,
            size: 64.sp,
            color: context.colorScheme.destructive,
          ),
          Gap(16.h),
          Text(
            state.menuByCategory.message ?? context.l10n.error_unexpected,
            style: context.typography.base,
            textAlign: TextAlign.center,
          ),
          Gap(16.h),
          Button(
            style: const ButtonStyle.primary(),
            onPressed: () {
              _detailCubit.getMerchantDetail(
                widget.merchantId,
                merchant: widget.merchant,
              );
            },
            child: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.store,
            size: 64.sp,
            color: context.colorScheme.mutedForeground,
          ),
          Gap(16.h),
          Text(
            context.l10n.no_menu_items_yet,
            style: context.typography.base,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailContent(
    BuildContext context,
    UserMerchantDetailState detailState,
  ) {
    final merchant = detailState.merchant.value ?? widget.merchant;

    return Stack(
      children: [
        // Use BlocSelector to only get totalItems for padding calculation
        BlocSelector<CartCubit, CartState, int>(
          selector: (state) => state.totalItems,
          builder: (context, itemCount) {
            return RefreshTrigger(
              onRefresh: _onRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: itemCount > 0 ? 100.h : 16.h),
                children: [
                  // Brand Header
                  _buildBrandHeader(context, merchant),

                  Gap(16.h),

                  // Shop Information Card
                  _buildShopInfoCard(context, merchant),

                  Gap(16.h),

                  // Warning toast if stock changed
                  if (detailState.warningToast != null)
                    _buildWarningBanner(context, detailState.warningToast!),

                  // Product List (Stack of Cards)
                  if (detailState.menuByCategory.hasData)
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, cartState) {
                        return _buildProductList(
                          context,
                          detailState,
                          cartState,
                          merchant,
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),

        // Bottom Floating Action Bar - separate builder to avoid RefreshTrigger rebuilds
        BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            final itemCount = cartState.totalItems;
            if (itemCount > 0) {
              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildBottomActionBar(context, cartState),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildBrandHeader(BuildContext context, Merchant merchant) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          // Large centered shop logo
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: context.colorScheme.background,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: context.colorScheme.border.withValues(alpha: 0.5),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: merchant.image != null && merchant.image!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: merchant.image!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: context.colorScheme.muted.withValues(alpha: 0.3),
                        child: Center(
                          child: Icon(
                            LucideIcons.store,
                            size: 40.sp,
                            color: context.colorScheme.mutedForeground,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: context.colorScheme.muted.withValues(alpha: 0.3),
                        child: Center(
                          child: Icon(
                            LucideIcons.store,
                            size: 40.sp,
                            color: context.colorScheme.mutedForeground,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      color: context.colorScheme.muted.withValues(alpha: 0.3),
                      child: Center(
                        child: Icon(
                          LucideIcons.store,
                          size: 40.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopInfoCard(BuildContext context, Merchant merchant) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: context.colorScheme.border.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shop name and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  merchant.name,
                  style: context.typography.h3.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(4.h),
                Text(
                  merchant.address,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Gap(12.w),
          // Rating badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: context.colorScheme.muted.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.star,
                      size: 16.sp,
                      color: const Color(0xFFFBBF24),
                    ),
                    Gap(4.w),
                    Text(
                      merchant.rating.toStringAsFixed(2),
                      style: context.typography.semiBold.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                Gap(2.h),
                Text(
                  "1k+ ratings",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningBanner(BuildContext context, String message) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.dg),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFCD34D)),
      ),
      child: Row(
        children: [
          Icon(
            LucideIcons.triangleAlert,
            color: const Color(0xFFD97706),
            size: 18.sp,
          ),
          Gap(8.w),
          Expanded(
            child: Text(
              message,
              style: context.typography.small.copyWith(
                color: const Color(0xFF92400E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(
    BuildContext context,
    UserMerchantDetailState detailState,
    CartState cartState,
    Merchant merchant,
  ) {
    final allItems = <MerchantMenu>[];
    for (final entry in detailState.menuByCategory.value!.entries) {
      allItems.addAll(entry.value);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.menu_details,
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(12.h),
          ...allItems.map((item) {
            final cartItem = cartState.currentCart?.items
                .where((cartItem) => cartItem.menuId == item.id)
                .toList();
            final currentQty = cartItem != null && cartItem.isNotEmpty
                ? cartItem.first.quantity
                : 0;

            return _buildProductCard(
              context,
              item: item,
              currentQty: currentQty,
              merchant: merchant,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context, {
    required MerchantMenu item,
    required int currentQty,
    required Merchant merchant,
  }) {
    final isOutOfStock = item.stock == 0;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: isOutOfStock
            ? context.colorScheme.muted.withValues(alpha: 0.2)
            : context.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: context.colorScheme.border.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name
                Text(
                  item.name,
                  style: context.typography.semiBold.copyWith(
                    fontSize: 16.sp,
                    color: isOutOfStock
                        ? context.colorScheme.mutedForeground
                        : context.colorScheme.foreground,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(6.h),
                // Rating row
                Row(
                  children: [
                    Icon(
                      LucideIcons.star,
                      size: 12.sp,
                      color: const Color(0xFFFBBF24),
                    ),
                    Gap(4.w),
                    Text(
                      "4.5",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                    Gap(4.w),
                    Text(
                      context.l10n.menu_in_stock(item.stock),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
                Gap(8.h),
                // Product price
                Text(
                  context.formatCurrency(item.price),
                  style: context.typography.semiBold.copyWith(
                    fontSize: 16.sp,
                    color: isOutOfStock
                        ? context.colorScheme.mutedForeground
                        : context.colorScheme.primary,
                  ),
                ),
                Gap(12.h),
                // Action button area
                if (isOutOfStock)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.destructive.withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      context.l10n.menu_out_of_stock,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.colorScheme.destructive,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                else if (currentQty == 0)
                  // Add button
                  Button(
                    style: const ButtonStyle.outline(
                      density: ButtonDensity.compact,
                    ),
                    onPressed: () => _onQuantityChanged(
                      item: item,
                      newQty: 1,
                      merchant: merchant,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.plus, size: 14.sp),
                        Gap(4.w),
                        Text(
                          context.l10n.add,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  )
                else
                  // Quantity selector
                  _buildQuantitySelector(
                    context,
                    item: item,
                    currentQty: currentQty,
                    merchant: merchant,
                  ),
              ],
            ),
          ),
          Gap(12.w),
          // Product thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Opacity(
              opacity: isOutOfStock ? 0.5 : 1.0,
              child: item.image != null && item.image!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: item.image!,
                      width: 80.w,
                      height: 80.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 80.w,
                        height: 80.w,
                        color: context.colorScheme.muted.withValues(alpha: 0.3),
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 80.w,
                        height: 80.w,
                        color: context.colorScheme.muted.withValues(alpha: 0.3),
                        child: Icon(
                          LucideIcons.image,
                          size: 24.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                    )
                  : Container(
                      width: 80.w,
                      height: 80.w,
                      color: context.colorScheme.muted.withValues(alpha: 0.3),
                      child: Icon(
                        LucideIcons.image,
                        size: 24.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(
    BuildContext context, {
    required MerchantMenu item,
    required int currentQty,
    required Merchant merchant,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease button
          GestureDetector(
            onTap: () => _onQuantityChanged(
              item: item,
              newQty: currentQty - 1,
              merchant: merchant,
            ),
            child: Container(
              padding: EdgeInsets.all(8.dg),
              child: Icon(
                LucideIcons.minus,
                size: 16.sp,
                color: context.colorScheme.foreground,
              ),
            ),
          ),
          // Quantity display
          Container(
            constraints: BoxConstraints(minWidth: 32.w),
            alignment: Alignment.center,
            child: Text(
              currentQty.toString(),
              style: context.typography.semiBold.copyWith(fontSize: 14.sp),
            ),
          ),
          // Increase button
          GestureDetector(
            onTap: currentQty < item.stock
                ? () => _onQuantityChanged(
                    item: item,
                    newQty: currentQty + 1,
                    merchant: merchant,
                  )
                : null,
            child: Container(
              padding: EdgeInsets.all(8.dg),
              child: Icon(
                LucideIcons.plus,
                size: 16.sp,
                color: currentQty < item.stock
                    ? context.colorScheme.foreground
                    : context.colorScheme.mutedForeground.withValues(
                        alpha: 0.5,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQuantityChanged({
    required MerchantMenu item,
    required int newQty,
    required Merchant merchant,
  }) {
    if (newQty > item.stock) {
      showToast(
        context: context,
        location: ToastLocation.bottomCenter,
        builder: (context, overlay) => context.buildToast(
          title: context.l10n.error,
          message: context.l10n.menu_in_stock(item.stock),
        ),
      );
      return;
    }

    if (newQty > 0) {
      _cartCubit.addItem(
        menu: item,
        merchantName: merchant.name,
        quantity: newQty,
        merchantLocation: merchant.location,
      );
    } else {
      _cartCubit.removeItem(item.id);
    }
  }

  Widget _buildBottomActionBar(BuildContext context, CartState cartState) {
    final firstItem = cartState.currentCart?.items.firstOrNull;
    final itemName = firstItem?.menuName ?? "";
    final totalPrice = cartState.subtotal;

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
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 52.h,
          child: Button(
            style: const ButtonStyle.primary(),
            onPressed: () {
              context.pushNamed(Routes.userOrderConfirm.name);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "$itemName (${context.formatCurrency(totalPrice)})",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Gap(8.w),
                Icon(LucideIcons.arrowRight, size: 18.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
