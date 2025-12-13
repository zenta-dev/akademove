import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/_export.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Menu detail screen showing menu information with Add to Cart functionality
///
/// Note: This is a simplified version that receives menu data as parameter.
/// In a real app, you might want to fetch fresh data from API, but that requires
/// the merchant API to support fetching menu by ID without merchantId parameter.
class UserMenuDetailScreen extends StatefulWidget {
  const UserMenuDetailScreen({
    required this.menu,
    required this.merchantName,
    this.merchantLocation,
    super.key,
  });

  final MerchantMenu menu;
  final String merchantName;
  final Coordinate? merchantLocation;

  @override
  State<UserMenuDetailScreen> createState() => _UserMenuDetailScreenState();
}

class _UserMenuDetailScreenState extends State<UserMenuDetailScreen> {
  final _notesController = TextEditingController();
  int _quantity = 1;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _addToCart(BuildContext context) {
    context.read<UserCartCubit>().addItem(
      menu: widget.menu,
      merchantName: widget.merchantName,
      quantity: _quantity,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      merchantLocation: widget.merchantLocation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCartCubit, UserCartState>(
      listener: (context, state) {
        // Show merchant conflict dialog
        if (state.showMerchantConflict) {
          MerchantConflictDialog.show(
            context,
            currentMerchantName: state.currentCart?.merchantName ?? '',
            newMerchantName: state.pendingMerchantName ?? '',
          );
        } else if (state.addItemResult.isSuccess &&
            !state.showMerchantConflict) {
          // Successfully added to cart without conflict
          showToast(
            context: context,
            builder: (context, overlay) => context.buildToast(
              title: context.l10n.menu_added_to_cart,
              message: context.l10n.menu_item_added_to_cart,
            ),
            location: ToastLocation.topCenter,
          );
          context.pop(); // Go back after success
        }
      },
      child: Scaffold(
        headers: [
          DefaultAppBar(
            title: context.l10n.menu_details,
            trailing: [
              BlocProvider.value(
                value: context.read<UserCartCubit>(),
                child: CartBadge(
                  onTap: () {
                    // Cart navigation handled at parent level
                  },
                ),
              ),
            ],
          ),
        ],
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final menu = widget.menu;
    final mutedColor = context.colorScheme.mutedForeground;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menu Image
                if (menu.image != null) ...[
                  CachedNetworkImage(
                    imageUrl: menu.image!,
                    width: double.infinity,
                    height: 250.h,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Assets.images.noImage
                        .svg(width: double.infinity, height: 250.h),
                  ),
                ] else ...[
                  Assets.images.noImage.svg(
                    width: double.infinity,
                    height: 250.h,
                  ),
                ],

                Padding(
                  padding: EdgeInsets.all(16.dg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Menu Name & Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              menu.name,
                              style: context.typography.h3.copyWith(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Gap(8.w),
                          Text(
                            'Rp ${menu.price}',
                            style: context.typography.h4.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),

                      Gap(8.h),

                      // Merchant Name
                      Row(
                        children: [
                          Icon(
                            LucideIcons.store,
                            size: 16.sp,
                            color: mutedColor,
                          ),
                          Gap(4.w),
                          Text(
                            widget.merchantName,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: mutedColor,
                            ),
                          ),
                        ],
                      ),

                      Gap(16.h),
                      Divider(),
                      Gap(16.h),

                      // Stock Info
                      Row(
                        children: [
                          Icon(
                            menu.stock > 0
                                ? LucideIcons.circleCheck
                                : LucideIcons.circleX,
                            size: 16.sp,
                            color: menu.stock > 0 ? Colors.green : Colors.red,
                          ),
                          Gap(4.w),
                          Text(
                            menu.stock > 0
                                ? context.l10n.menu_in_stock(menu.stock)
                                : context.l10n.menu_out_of_stock,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: menu.stock > 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      if (menu.category != null) ...[
                        Gap(8.h),
                        Row(
                          children: [
                            Icon(
                              LucideIcons.tag,
                              size: 16.sp,
                              color: mutedColor,
                            ),
                            Gap(4.w),
                            Text(
                              menu.category!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: mutedColor,
                              ),
                            ),
                          ],
                        ),
                      ],

                      Gap(24.h),

                      // Quantity Selector
                      Text(
                        context.l10n.menu_quantity,
                        style: context.typography.h4.copyWith(fontSize: 16.sp),
                      ),
                      Gap(12.h),
                      _buildQuantitySelector(context),

                      Gap(24.h),

                      // Notes Input
                      Text(
                        context.l10n.menu_special_notes_optional,
                        style: context.typography.h4.copyWith(fontSize: 16.sp),
                      ),
                      Gap(12.h),
                      TextField(
                        controller: _notesController,
                        placeholder: const Text('e.g., No ice, extra spicy'),
                        maxLines: 3,
                      ),

                      Gap(24.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bottom Add to Cart Button
        _buildBottomBar(context),
      ],
    );
  }

  Widget _buildQuantitySelector(BuildContext context) {
    final menu = widget.menu;

    return Row(
      children: [
        IconButton(
          onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
          icon: const Icon(LucideIcons.minus, size: 20),
          variance: ButtonVariance.primary,
        ),
        Gap(16.w),
        Text(
          _quantity.toString(),
          style: context.typography.h3.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(16.w),
        IconButton(
          onPressed: _quantity < menu.stock
              ? () => setState(() => _quantity++)
              : null,
          icon: const Icon(LucideIcons.plus, size: 20),
          variance: ButtonVariance.primary,
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final menu = widget.menu;
    final totalPrice = menu.price.toDouble() * _quantity;

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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.menu_total_price,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    'Rp ${totalPrice.toStringAsFixed(0)}',
                    style: context.typography.h3.copyWith(fontSize: 20.sp),
                  ),
                ],
              ),
            ),
            Gap(16.w),
            Button(
              style: const ButtonStyle.primary(),
              onPressed: menu.stock > 0 ? () => _addToCart(context) : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.shoppingCart, size: 16.sp),
                  Gap(8.w),
                  Text(context.l10n.menu_add_to_cart),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
