import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDeliverySummaryScreen extends StatefulWidget {
  const UserDeliverySummaryScreen({super.key});

  @override
  State<UserDeliverySummaryScreen> createState() =>
      _UserDeliverySummaryScreenState();
}

class _UserDeliverySummaryScreenState extends State<UserDeliverySummaryScreen> {
  Coupon? selectedCoupon;
  num discountAmount = 0;

  @override
  void initState() {
    super.initState();
    // Load eligible coupons when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderState = context.read<UserOrderCubit>().state;
      final totalAmount =
          orderState.estimateOrder.value?.summary.totalCost ?? 0;
      if (totalAmount > 0) {
        context.read<CouponCubit>().loadEligibleCoupons(
          serviceType: OrderType.DELIVERY,
          totalAmount: totalAmount,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserOrderCubit, UserOrderState>(
      builder: (context, state) {
        final estimate = state.estimateOrder.value;
        return Scaffold(
          headers: [
            AppBar(
              padding: EdgeInsets.all(4.dg),
              title: Text(
                context.l10n.title_order_summary,
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
          footers: [
            if (estimate != null)
              Padding(
                padding: EdgeInsets.all(16.dg),
                child: SizedBox(
                  width: double.infinity,
                  child: Button.primary(
                    onPressed: () {
                      // Store coupon in delivery cubit for payment screen
                      final coupon = selectedCoupon;
                      if (coupon != null) {
                        context.read<UserDeliveryCubit>().setSelectedCoupon(
                          coupon.code,
                        );
                      }
                      context.push(Routes.userDeliveryPayment.path);
                    },
                    child: Text(context.l10n.button_choose_payment_method),
                  ),
                ),
              ),
          ],
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.dg),
              child: _buildBody(context, state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, UserOrderState state) {
    if (state.estimateOrder.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final estimate = state.estimateOrder.value;
    if (estimate == null) {
      return Center(
        child: DefaultText(
          context.l10n.text_no_estimate_available,
          fontSize: 14.sp,
        ),
      );
    }

    return Column(
      spacing: 16.h,
      children: [
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              DefaultText(
                context.l10n.label_delivery_details,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              _buildDetailRow(
                context,
                context.l10n.label_from,
                estimate.pickup.vicinity,
              ),
              _buildDetailRow(
                context,
                context.l10n.label_to,
                estimate.dropoff.vicinity,
              ),
              _buildDetailRow(
                context,
                context.l10n.label_weight,
                '${estimate.summary.breakdown.weight}kg',
              ),
            ],
          ),
        ),
        // Coupon selector
        BlocBuilder<CouponCubit, CouponState>(
          builder: (context, couponState) {
            return OutlineButton(
              onPressed: () {
                openDrawer(
                  context: context,
                  position: OverlayPosition.bottom,
                  builder: (drawerContext) => BlocProvider.value(
                    value: context.read<CouponCubit>(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: CouponSelectorWidget(
                        onCouponSelected: (coupon) {
                          setState(() {
                            selectedCoupon = coupon;
                            if (coupon != null) {
                              final cubit = context.read<CouponCubit>();
                              discountAmount =
                                  cubit
                                      .state
                                      .eligibleCoupons
                                      .value
                                      ?.bestDiscountAmount ??
                                  0;
                            } else {
                              discountAmount = 0;
                            }
                          });
                          closeDrawer(drawerContext);
                        },
                      ),
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      selectedCoupon == null
                          ? context.l10n.button_apply_coupon
                          : '${context.l10n.text_coupon}: ${selectedCoupon?.code ?? ""}',
                    ),
                  ),
                  Icon(
                    selectedCoupon == null
                        ? LucideIcons.chevronRight
                        : LucideIcons.check,
                    size: 16,
                  ),
                ],
              ),
            );
          },
        ),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              DefaultText(
                context.l10n.label_price_breakdown,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              _buildPriceRow(
                context,
                context.l10n.label_distance,
                '${estimate.summary.distanceKm}km',
              ),
              _buildPriceRow(
                context,
                context.l10n.label_base_fare,
                context.formatCurrency(estimate.summary.baseFare),
              ),
              _buildPriceRow(
                context,
                context.l10n.label_distance_fare,
                context.formatCurrency(estimate.summary.distanceFare),
              ),
              const Divider(),
              _buildPriceRow(
                context,
                context.l10n.label_subtotal,
                context.formatCurrency(estimate.summary.totalCost),
              ),
              if (discountAmount > 0) ...[
                const Divider(),
                _buildPriceRow(
                  context,
                  context.l10n.label_discount,
                  '- ${context.formatCurrency(discountAmount)}',
                  isDiscount: true,
                ),
              ],
              const Divider(),
              _buildPriceRow(
                context,
                context.l10n.label_total,
                context.formatCurrency(
                  estimate.summary.totalCost - discountAmount,
                ),
                bold: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label).small(), Text(value).small()],
    );
  }

  Widget _buildPriceRow(
    BuildContext context,
    String label,
    String value, {
    bool bold = false,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DefaultText(
          label,
          fontSize: 14.sp,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
        DefaultText(
          value,
          fontSize: 14.sp,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: isDiscount ? const Color(0xFF10B981) : null,
        ),
      ],
    );
  }
}
