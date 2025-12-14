import "package:akademove/app/_export.dart";
import "package:akademove/core/_export.dart";
import "package:akademove/features/features.dart";
import "package:akademove/l10n/l10n.dart";
import "package:api_client/api_client.dart" hide Cart, CartItem;
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// Order confirmation screen displaying cart summary and payment method selection
class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.QRIS;
  BankProvider? _bankProvider;
  Place? _deliveryLocation;
  String? _addressDetails;
  String? _orderNotes;
  Coupon? _selectedCoupon;
  num _discountAmount = 0;

  // Controllers for notes
  final TextEditingController _addressDetailsController =
      TextEditingController();
  final TextEditingController _orderNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDeliveryLocation();
    _loadEligibleCoupons();
  }

  @override
  void dispose() {
    _addressDetailsController.dispose();
    _orderNotesController.dispose();
    super.dispose();
  }

  void _initDeliveryLocation() {
    // Initialize delivery location from user's current location
    final userLocationCubit = context.read<UserLocationCubit>();
    final coordinate = userLocationCubit.state.coordinate;
    final placemark = userLocationCubit.state.placemark;

    if (coordinate != null) {
      _deliveryLocation = Place(
        name: placemark?.name ?? "Current Location",
        vicinity: placemark?.street ?? "Your current location",
        lat: coordinate.y.toDouble(),
        lng: coordinate.x.toDouble(),
        icon: "",
      );
    }
  }

  void _loadEligibleCoupons() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartState = context.read<UserCartCubit>().state;
      final totalAmount = cartState.currentCart?.subtotal ?? 0;
      if (totalAmount > 0) {
        context.read<UserCouponCubit>().loadEligibleCoupons(
          serviceType: OrderType.FOOD,
          totalAmount: totalAmount,
        );
      }
    });
  }

  Future<void> _selectDeliveryLocation() async {
    final currentLocation = _deliveryLocation;
    Coordinate? initialLocation;

    if (currentLocation != null) {
      initialLocation = Coordinate(
        x: currentLocation.lng,
        y: currentLocation.lat,
      );
    }

    final result = await context.pushNamed<Place>(
      Routes.userMapPicker.name,
      extra: {
        "locationType": LocationType.dropoff,
        "initialLocation": initialLocation,
      },
    );

    if (result != null && mounted) {
      setState(() {
        _deliveryLocation = result;
      });
    }
  }

  void _showAddressDetailsDialog() {
    _addressDetailsController.text = _addressDetails ?? "";

    openDrawer(
      context: context,
      position: OverlayPosition.bottom,
      builder: (drawerContext) => Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Text(
              context.l10n.address,
              style: context.typography.h4.copyWith(fontSize: 18.sp),
            ),
            TextField(
              controller: _addressDetailsController,
              maxLines: 3,
              placeholder: Text(context.l10n.special_instructions_hint),
            ),
            Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: OutlineButton(
                    onPressed: () => closeDrawer(drawerContext),
                    child: Text(context.l10n.cancel),
                  ),
                ),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      setState(() {
                        _addressDetails =
                            _addressDetailsController.text.isNotEmpty
                            ? _addressDetailsController.text
                            : null;
                      });
                      closeDrawer(drawerContext);
                    },
                    child: Text(context.l10n.save),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showNotesDialog() {
    _orderNotesController.text = _orderNotes ?? "";

    openDrawer(
      context: context,
      position: OverlayPosition.bottom,
      builder: (drawerContext) => Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Text(
              context.l10n.label_notes,
              style: context.typography.h4.copyWith(fontSize: 18.sp),
            ),
            TextField(
              controller: _orderNotesController,
              maxLines: 3,
              placeholder: Text(context.l10n.special_instructions_hint),
            ),
            Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: OutlineButton(
                    onPressed: () => closeDrawer(drawerContext),
                    child: Text(context.l10n.cancel),
                  ),
                ),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      setState(() {
                        _orderNotes = _orderNotesController.text.isNotEmpty
                            ? _orderNotesController.text
                            : null;
                      });
                      closeDrawer(drawerContext);
                    },
                    child: Text(context.l10n.save),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCouponSelector() {
    final couponCubit = context.read<UserCouponCubit>();
    openDrawer(
      context: context,
      position: OverlayPosition.bottom,
      expands: true,
      builder: (drawerContext) => BlocProvider.value(
        value: couponCubit,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: UserCouponSelectorWidget(
            onClose: () => closeDrawer(drawerContext),
            onCouponSelected: (coupon) {
              setState(() {
                _selectedCoupon = coupon;
                if (coupon != null) {
                  _discountAmount =
                      couponCubit
                          .state
                          .eligibleCoupons
                          .value
                          ?.bestDiscountAmount ??
                      0;
                } else {
                  _discountAmount = 0;
                }
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      child: BlocConsumer<UserCartCubit, UserCartState>(
        listenWhen: (prev, curr) =>
            prev.placeFoodOrderResult != curr.placeFoodOrderResult,
        listener: (context, state) async {
          if (state.placeFoodOrderResult.isSuccess) {
            showToast(
              context: context,
              builder: (ctx, overlay) => ctx.buildToast(
                title: context.l10n.order_confirm_success,
                message: context.l10n.order_confirm_success_message,
              ),
              location: ToastLocation.topCenter,
            );

            await context.read<UserOrderCubit>().recoverActiveOrder();

            if (context.mounted) {
              context.go(Routes.userMartOnTrip.path);
            }
          } else if (state.placeFoodOrderResult.isFailed) {
            final error = state.placeFoodOrderResult.error;
            showToast(
              context: context,
              builder: (ctx, overlay) => ctx.buildToast(
                title: context.l10n.order_confirm_failed,
                message: error?.message ?? "Unknown error",
              ),
              location: ToastLocation.topCenter,
            );
          }
        },
        builder: (context, state) {
          final cart = state.currentCart;
          if (state.isEmpty || cart == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) context.pop();
            });
            return const Center(child: CircularProgressIndicator());
          }

          return _buildContent(context, cart, state);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, Cart cart, UserCartState state) {
    final isPrintingMerchant = state.isPrintingMerchant;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.h,
              children: [
                // Item Summary Card
                _buildItemSummaryCard(context, cart),

                // Destination Location Card
                _buildDestinationLocationCard(context),

                // Selected Item Card
                _buildSelectedItemCard(context, cart),

                // Attachment Upload Widget (for Printing merchants only)
                if (isPrintingMerchant) const AttachmentUploadWidget(),

                // Payment Summary Card
                _buildPaymentSummaryCard(context, cart),

                // Payment Method Card
                _buildPaymentMethodCard(context),

                // Apply Coupon Row
                _buildApplyCouponRow(context),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
        _buildBottomBar(context, cart, state),
      ],
    );
  }

  Widget _buildItemSummaryCard(BuildContext context, Cart cart) {
    return _buildCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.label_item,
            style: context.typography.semiBold.copyWith(fontSize: 16.sp),
          ),
          Gap(12.h),
          _buildSummaryRow(
            context,
            context.l10n.name,
            cart.items.isNotEmpty ? cart.items.first.menuName : "-",
          ),
          Gap(8.h),
          _buildSummaryRow(
            context,
            context.l10n.menu_quantity,
            cart.totalItems.toString(),
          ),
          Gap(8.h),
          _buildSummaryRow(
            context,
            context.l10n.label_total_price,
            context.formatCurrency(cart.subtotal),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationLocationCard(BuildContext context) {
    final location = _deliveryLocation;
    final hasAddressDetails =
        _addressDetails != null && _addressDetails!.isNotEmpty;

    return _buildCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.destination,
            style: context.typography.semiBold.copyWith(fontSize: 16.sp),
          ),
          Gap(12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location?.name ?? context.l10n.dropoff_location,
                      style: context.typography.semiBold.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    if (location?.vicinity != null) ...[
                      Gap(2.h),
                      Text(
                        location!.vicinity,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              GestureDetector(
                onTap: _selectDeliveryLocation,
                child: Text(
                  context.l10n.edit_detail,
                  style: context.typography.semiBold.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          Gap(12.h),
          // Alert box for address details
          Container(
            padding: EdgeInsets.all(12.dg),
            decoration: BoxDecoration(
              color: context.colorScheme.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.colorScheme.secondary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  LucideIcons.info,
                  size: 16.sp,
                  color: context.colorScheme.secondaryForeground,
                ),
                Gap(8.w),
                Expanded(
                  child: Text(
                    hasAddressDetails
                        ? _addressDetails!
                        : context.l10n.special_instructions_hint,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.colorScheme.secondaryForeground,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(12.h),
          // Add address details and Notes buttons
          Row(
            spacing: 8.w,
            children: [
              Expanded(
                child: OutlineButton(
                  onPressed: _showAddressDetailsDialog,
                  leading: Icon(LucideIcons.mapPin, size: 14.sp),
                  child: Text(
                    context.l10n.address,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ),
              Expanded(
                child: OutlineButton(
                  onPressed: _showNotesDialog,
                  leading: Icon(LucideIcons.stickyNote, size: 14.sp),
                  child: Text(
                    context.l10n.label_notes,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedItemCard(BuildContext context, Cart cart) {
    if (cart.items.isEmpty) return const SizedBox.shrink();

    return _buildCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...cart.items.map((item) => _buildItemDetail(context, item, cart)),
          const Divider(),
          Gap(8.h),
          // Need anything else?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.cart_browse_amart,
                style: context.typography.p.copyWith(fontSize: 14.sp),
              ),
              GestureDetector(
                onTap: () => context.pop(),
                child: Text(
                  context.l10n.add,
                  style: context.typography.semiBold.copyWith(
                    fontSize: 14.sp,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemDetail(BuildContext context, CartItem item, Cart cart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.menuName,
                    style: context.typography.semiBold.copyWith(
                      fontSize: 16.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4.h),
                  Text(
                    context.formatCurrency(item.unitPrice * item.quantity),
                    style: context.typography.semiBold.copyWith(
                      fontSize: 14.sp,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Gap(12.w),
            // Product thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: item.menuImage != null
                  ? CachedNetworkImage(
                      imageUrl: item.menuImage!,
                      width: 60.w,
                      height: 60.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: context.colorScheme.muted.withValues(alpha: 0.3),
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: context.colorScheme.muted.withValues(alpha: 0.3),
                        child: Icon(
                          LucideIcons.image,
                          size: 24.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                    )
                  : Container(
                      width: 60.w,
                      height: 60.w,
                      color: context.colorScheme.muted.withValues(alpha: 0.3),
                      child: Icon(
                        LucideIcons.image,
                        size: 24.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
            ),
          ],
        ),
        Gap(12.h),
        // Notes display
        if (item.notes != null && item.notes!.isNotEmpty)
          Container(
            padding: EdgeInsets.all(8.dg),
            decoration: BoxDecoration(
              color: context.colorScheme.muted.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(
                  LucideIcons.stickyNote,
                  size: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Gap(8.w),
                Expanded(
                  child: Text(
                    item.notes!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Gap(12.h),
        // Quantity selector
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(LucideIcons.minus, size: 16.sp),
                    variance: ButtonVariance.ghost,
                    onPressed: item.quantity > 1
                        ? () {
                            context.read<UserCartCubit>().updateQuantity(
                              menuId: item.menuId,
                              delta: -1,
                            );
                          }
                        : null,
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: 40.w),
                    alignment: Alignment.center,
                    child: Text(
                      item.quantity.toString(),
                      style: context.typography.semiBold.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(LucideIcons.plus, size: 16.sp),
                    variance: ButtonVariance.ghost,
                    onPressed: () {
                      context.read<UserCartCubit>().updateQuantity(
                        menuId: item.menuId,
                        delta: 1,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Gap(12.h),
      ],
    );
  }

  Widget _buildPaymentSummaryCard(BuildContext context, Cart cart) {
    // Calculate totals
    const handlingAndShipping = 16000.0;
    const totalPage = 100;
    final subtotal = cart.subtotal;
    final discount = _discountAmount;
    final totalPrice = subtotal + handlingAndShipping - discount;

    return _buildCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.label_payment_summary,
            style: context.typography.semiBold.copyWith(fontSize: 16.sp),
          ),
          Gap(12.h),
          _buildPriceRow(
            context,
            context.l10n.label_price,
            context.formatCurrency(subtotal),
          ),
          Gap(8.h),
          _buildPriceRow(
            context,
            context.l10n.delivery_service,
            context.formatCurrency(handlingAndShipping),
          ),
          Gap(8.h),
          _buildPriceRow(
            context,
            context.l10n.menu_quantity,
            totalPage.toString(),
          ),
          if (discount > 0) ...[
            Gap(8.h),
            _buildPriceRow(
              context,
              context.l10n.label_discount,
              "- ${context.formatCurrency(discount)}",
              valueColor: const Color(0xFF10B981),
            ),
          ],
          Gap(8.h),
          const Divider(),
          Gap(8.h),
          _buildPriceRow(
            context,
            context.l10n.label_total_price,
            context.formatCurrency(totalPrice),
            isBold: true,
          ),
          Gap(8.h),
          Row(
            children: [
              Icon(
                LucideIcons.creditCard,
                size: 16.sp,
                color: context.colorScheme.mutedForeground,
              ),
              Gap(8.w),
              Text(
                context.l10n.label_payment_method,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
              Gap(4.w),
              Text(
                _getPaymentMethodLabel(context),
                style: context.typography.semiBold.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(BuildContext context) {
    return _buildCard(
      context,
      child: BlocBuilder<UserWalletCubit, UserWalletState>(
        builder: (context, walletState) {
          final walletBalance =
              walletState.myWallet.value?.balance.toDouble() ?? 0;
          final cartState = context.read<UserCartCubit>().state;
          final totalCost = cartState.currentCart?.subtotal ?? 0;
          final isWalletSufficient = walletBalance >= totalCost;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.label_payment_method,
                style: context.typography.semiBold.copyWith(fontSize: 16.sp),
              ),
              Gap(12.h),
              // Wallet option
              _buildPaymentOption(
                context,
                icon: LucideIcons.wallet,
                title: context.l10n.payment_method_wallet,
                subtitle: context.l10n.text_balance_with_amount(
                  context.formatCurrency(walletBalance),
                ),
                subtitleColor: isWalletSufficient
                    ? context.colorScheme.primary
                    : context.colorScheme.destructive,
                isSelected: _selectedPaymentMethod == PaymentMethod.wallet,
                isEnabled: isWalletSufficient,
                onTap: isWalletSufficient
                    ? () {
                        setState(() {
                          _selectedPaymentMethod = PaymentMethod.wallet;
                          _bankProvider = null;
                        });
                      }
                    : null,
                trailing: !isWalletSufficient
                    ? Button(
                        style:
                            const ButtonStyle.outline(
                              density: ButtonDensity.dense,
                            ).copyWith(
                              decoration: (context, states, value) =>
                                  value.copyWithIfBoxDecoration(
                                    border: Border.all(
                                      color: context.colorScheme.destructive,
                                    ),
                                  ),
                            ),
                        onPressed: () {
                          context.pushNamed(Routes.userWalletTopUp.name);
                        },
                        child: Text(
                          context.l10n.button_top_up,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.colorScheme.destructive,
                          ),
                        ),
                      )
                    : null,
              ),
              Gap(8.h),
              // QRIS option
              _buildPaymentOption(
                context,
                icon: LucideIcons.qrCode,
                title: context.l10n.payment_method_qris,
                isSelected: _selectedPaymentMethod == PaymentMethod.QRIS,
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = PaymentMethod.QRIS;
                    _bankProvider = null;
                  });
                },
              ),
              Gap(8.h),
              // Bank Transfer option
              _buildPaymentOption(
                context,
                icon: LucideIcons.arrowUpDown,
                title: context.l10n.payment_method_bank_transfer,
                subtitle: _bankProvider?.value,
                isSelected:
                    _selectedPaymentMethod == PaymentMethod.BANK_TRANSFER,
                onTap: () => _selectBankProvider(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Color? subtitleColor,
    required bool isSelected,
    bool isEnabled = true,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.dg),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primary.withValues(alpha: 0.05)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.mutedForeground,
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.typography.semiBold.copyWith(
                      fontSize: 14.sp,
                      color: isEnabled
                          ? context.colorScheme.foreground
                          : context.colorScheme.mutedForeground,
                    ),
                  ),
                  if (subtitle != null) ...[
                    Gap(2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color:
                            subtitleColor ??
                            context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing ??
                Container(
                  width: 20.sp,
                  height: 20.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? context.colorScheme.primary
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? context.colorScheme.primary
                          : context.colorScheme.mutedForeground.withValues(
                              alpha: 0.5,
                            ),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          LucideIcons.check,
                          size: 12.sp,
                          color: context.colorScheme.primaryForeground,
                        )
                      : null,
                ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectBankProvider(BuildContext context) async {
    await openSheet<BankProvider>(
      context: context,
      position: OverlayPosition.bottom,
      builder: (sheetContext) {
        return BankProviderSelectorWidget(
          onSelected: (provider) {
            setState(() {
              _selectedPaymentMethod = PaymentMethod.BANK_TRANSFER;
              _bankProvider = provider;
            });
          },
        );
      },
    );
  }

  Widget _buildApplyCouponRow(BuildContext context) {
    return _buildCard(
      context,
      child: BlocBuilder<UserCouponCubit, UserCouponState>(
        builder: (context, couponState) {
          final hasSelectedCoupon = _selectedCoupon != null;

          return GestureDetector(
            onTap: _showCouponSelector,
            child: Row(
              children: [
                Icon(
                  LucideIcons.ticket,
                  size: 20.sp,
                  color: hasSelectedCoupon
                      ? context.colorScheme.primary
                      : context.colorScheme.mutedForeground,
                ),
                Gap(12.w),
                Expanded(
                  child: Text(
                    hasSelectedCoupon
                        ? context.l10n.text_coupon_applied(
                            _selectedCoupon?.code ?? "",
                          )
                        : context.l10n.text_apply_coupon,
                    style: context.typography.semiBold.copyWith(
                      fontSize: 14.sp,
                      color: hasSelectedCoupon
                          ? context.colorScheme.primary
                          : context.colorScheme.foreground,
                    ),
                  ),
                ),
                Icon(
                  hasSelectedCoupon
                      ? LucideIcons.check
                      : LucideIcons.chevronRight,
                  size: 20.sp,
                  color: hasSelectedCoupon
                      ? context.colorScheme.primary
                      : context.colorScheme.mutedForeground,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, Cart cart, UserCartState state) {
    final isPlacingOrder = state.placeFoodOrderResult.isLoading;
    const handlingAndShipping = 16000.0;
    final totalPrice = cart.subtotal + handlingAndShipping - _discountAmount;

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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.total,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                  Gap(2.h),
                  Text(
                    context.formatCurrency(totalPrice),
                    style: context.typography.h3.copyWith(fontSize: 20.sp),
                  ),
                ],
              ),
            ),
            Gap(16.w),
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: Button(
                  style: const ButtonStyle.primary(),
                  onPressed: isPlacingOrder
                      ? null
                      : () => _placeOrder(context, cart),
                  child: isPlacingOrder
                      ? const Submiting()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.l10n.order_confirm_place_order,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Gap(8.w),
                            Icon(LucideIcons.arrowRight, size: 18.sp),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required Widget child}) {
    return Container(
      width: double.infinity,
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
      child: child,
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: context.colorScheme.mutedForeground,
          ),
        ),
        Text(value, style: context.typography.p.copyWith(fontSize: 14.sp)),
      ],
    );
  }

  Widget _buildPriceRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            color: context.colorScheme.mutedForeground,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            color: valueColor ?? context.colorScheme.foreground,
          ),
        ),
      ],
    );
  }

  String _getPaymentMethodLabel(BuildContext context) {
    switch (_selectedPaymentMethod) {
      case PaymentMethod.wallet:
        return context.l10n.payment_method_wallet;
      case PaymentMethod.QRIS:
        return context.l10n.payment_method_qris;
      case PaymentMethod.BANK_TRANSFER:
        return _bankProvider != null
            ? "${context.l10n.payment_method_bank_transfer} - ${_bankProvider!.value}"
            : context.l10n.payment_method_bank_transfer;
    }
  }

  void _placeOrder(BuildContext context, Cart cart) {
    final userLocationCubit = context.read<UserLocationCubit>();
    final userLocation = userLocationCubit.state.coordinate;
    final cartState = context.read<UserCartCubit>().state;

    // Validate attachment for Printing merchants
    if (cartState.isPrintingMerchant && !cartState.hasAttachment) {
      showToast(
        context: context,
        builder: (ctx, overlay) => ctx.buildToast(
          title: context.l10n.order_confirm_failed,
          message: "Mohon unggah file dokumen yang ingin dicetak",
        ),
        location: ToastLocation.topCenter,
      );
      return;
    }

    // Pickup location = merchant location (where food is prepared)
    final pickupLocation = cart.merchantLocation ?? userLocation;

    // Dropoff location = user's selected delivery location (where food is delivered)
    final deliveryPlace = _deliveryLocation;
    final dropoffLocation = deliveryPlace != null
        ? Coordinate(x: deliveryPlace.lng, y: deliveryPlace.lat)
        : userLocation;

    if (pickupLocation == null || dropoffLocation == null) {
      showToast(
        context: context,
        builder: (ctx, overlay) => ctx.buildToast(
          title: context.l10n.order_confirm_failed,
          message:
              "Unable to determine location. Please enable location services.",
        ),
        location: ToastLocation.topCenter,
      );
      return;
    }

    if (_deliveryLocation == null) {
      showToast(
        context: context,
        builder: (ctx, overlay) => ctx.buildToast(
          title: context.l10n.order_confirm_failed,
          message: context.l10n.pickup_and_dropoff_must_be_set,
        ),
        location: ToastLocation.topCenter,
      );
      return;
    }

    context.read<UserCartCubit>().placeFoodOrder(
      pickupLocation: pickupLocation,
      dropoffLocation: dropoffLocation,
      paymentMethod: _selectedPaymentMethod,
    );
  }
}
