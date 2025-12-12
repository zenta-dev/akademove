import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/features/user/presentation/cubits/user_merchant_detail_cubit.dart';
import 'package:akademove/features/user/presentation/widgets/bottom_cart_button_widget.dart';
import 'package:akademove/features/user/presentation/widgets/item_card_widget.dart';
import 'package:akademove/features/user/presentation/widgets/merchant_detail_header_widget.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserMerchantDetailScreen extends StatefulWidget {
  /// Merchant ID to load
  final String merchantId;
  final Merchant merchant;

  /// If true, shows read-only summary mode (no quantity adjustment)
  final bool isSummary;

  const UserMerchantDetailScreen({
    required this.merchantId,
    required this.merchant,
    this.isSummary = false,
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

    // Pass merchant object
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

    // Check if user switched to different merchant
    final previousMerchantId = _detailCubit.currentMerchantId;
    if (previousMerchantId != null && previousMerchantId != widget.merchantId) {
      // User switched to different merchant - clear cart
      _cartCubit.clearCart();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showToast(
            context: context,
            location: ToastLocation.bottomCenter,
            builder: (context, overlay) => context.buildToast(
              title: 'Cart Cleared',
              message: 'Previous cart cleared',
            ),
          );
        }
      });
    }

    // Check for stock changes
    _detailCubit.checkStockChanges(widget.merchantId);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      key: ValueKey('pop_scope_${widget.isSummary}'),
      canPop: !widget.isSummary,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && widget.isSummary) {
          // Go back to detail screen (non-summary mode)
          context.pop();
        }
      },
      child: Scaffold(
        headers: [
          DefaultAppBar(
            title: 'Merchant Details',
            trailing: [
              BlocProvider.value(
                value: context.read<CartCubit>(),
                child: CartBadge(
                  onTap: () {
                    // Cart navigation handled at parent level
                  },
                ),
              ),
            ],
          ),
        ],
        child: BlocConsumer<UserMerchantDetailCubit, UserMerchantDetailState>(
          listener: (context, state) {
            // Show error toast if failed
            if (state.menuByCategory.isFailure &&
                state.menuByCategory.message != null) {
              showToast(
                context: context,
                location: ToastLocation.bottomCenter,
                builder: (context, overlay) => context.buildToast(
                  title: 'Error',
                  message: state.menuByCategory.message!,
                ),
              );
            }
          },
          builder: (context, state) {
            // Loading state
            if (state.menuByCategory.isLoading &&
                state.menuByCategory.value == null) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error state
            if (state.menuByCategory.isFailure &&
                state.menuByCategory.value == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
                    SizedBox(height: 16.h),
                    Text(
                      state.menuByCategory.message ??
                          'Failed to load merchant details',
                      style: context.typography.base,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    PrimaryButton(
                      child: const Text('Retry'),
                      onPressed: () {
                        _detailCubit.getMerchantDetail(
                          widget.merchantId,
                          merchant: widget.merchant,
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            // Empty state
            if (state.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.store_outlined, size: 64.sp, color: Colors.gray),
                    SizedBox(height: 16.h),
                    Text('No items available', style: context.typography.base),
                  ],
                ),
              );
            }

            // Success state - show content
            return _buildDetailContent(context, state);
          },
        ),
      ),
    );
  }

  /// Build main content with merchant header and menu items
  Widget _buildDetailContent(
    BuildContext context,
    UserMerchantDetailState detailState,
  ) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final itemCount = cartState.totalItems;
        final totalPrice = cartState.subtotal;

        // Use merchant from state if available, otherwise fallback to widget.merchant
        // But state.merchant is OperationResult, so we check value.
        // Also widget.merchant is passed to cubit so it should be in state.
        final merchant = detailState.merchant.value ?? widget.merchant;

        return Stack(
          children: [
            // Main content - scrollable with refresh
            RefreshTrigger(
              onRefresh: _onRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: itemCount > 0 ? 80.h : 16.h),
                children: [
                  // Merchant header
                  MerchantDetailHeaderWidget(merchant: merchant),

                  SizedBox(height: 8.h),

                  // Show warning toast if stock changed
                  if (detailState.warningToast != null)
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.orange[200]),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_rounded,
                            color: Colors.orange,
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              detailState.warningToast!,
                              style: context.typography.small.copyWith(
                                color: Colors.orange[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Menu items grouped by category
                  if (detailState.menuByCategory.hasData)
                    ...detailState.menuByCategory.value!.entries.map((entry) {
                      final category = entry.key;
                      final items = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category header
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              16.w,
                              16.h,
                              16.w,
                              12.h,
                            ),
                            child: Text(
                              category,
                              style: context.typography.h4.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          // Items in category
                          ...items.map((item) {
                            // Get current quantity from cart
                            final cartItem = cartState.currentCart?.items
                                .where((cartItem) => cartItem.menuId == item.id)
                                .toList();
                            final currentQty =
                                cartItem != null && cartItem.isNotEmpty
                                ? cartItem.first.quantity
                                : 0;

                            return ItemCardWidget(
                              item: item,
                              currentQty: currentQty,
                              onQuantityChanged: (newQty) {
                                // Validate quantity doesn't exceed stock
                                if (newQty > item.stock) {
                                  showToast(
                                    context: context,
                                    location: ToastLocation.bottomCenter,
                                    builder: (context, overlay) =>
                                        context.buildToast(
                                          title: 'Stock Limit',
                                          message:
                                              'Only ${item.stock} items available',
                                        ),
                                  );
                                  return;
                                }

                                // Update cart
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
                              },
                            );
                          }),
                        ],
                      );
                    }),
                ],
              ),
            ),

            // Bottom sticky cart button
            if (itemCount > 0)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: BottomCartButtonWidget(
                    itemCount: itemCount,
                    totalPrice: totalPrice,
                    buttonText: widget.isSummary ? 'Confirm Order' : 'Checkout',
                    onPressed: () {
                      if (widget.isSummary) {
                        // Navigate to payment screen
                        context.pushNamed(Routes.userOrderConfirm.name);
                      } else {
                        // Navigate to summary (same screen with isSummary=true)
                        context.pushNamed(
                          Routes.userMerchantDetail.name,
                          pathParameters: {'merchantId': widget.merchantId},
                          extra: {
                            'isSummary': true,
                            'merchant': widget.merchant,
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
