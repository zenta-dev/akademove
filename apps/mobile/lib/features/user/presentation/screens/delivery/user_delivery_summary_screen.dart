import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' show showModalBottomSheet;
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
      final deliveryState = context.read<UserDeliveryCubit>().state;
      final totalAmount = deliveryState.estimate?.summary.totalCost ?? 0;
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
    return MyScaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            'Order Summary',
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
      body: BlocBuilder<UserDeliveryCubit, UserDeliveryState>(
        builder: (context, state) {
          if (state.state == CubitState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final estimate = state.estimate;
          if (estimate == null) {
            return Center(
              child: DefaultText('No estimate available', fontSize: 14.sp),
            );
          }

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              spacing: 16.h,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12.h,
                      children: [
                        DefaultText(
                          'Delivery Details',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        _buildDetailRow(
                          context,
                          'From',
                          estimate.pickup.vicinity,
                        ),
                        _buildDetailRow(
                          context,
                          'To',
                          estimate.dropoff.vicinity,
                        ),
                        _buildDetailRow(
                          context,
                          'Item',
                          estimate.details.description,
                        ),
                        _buildDetailRow(
                          context,
                          'Weight',
                          '${estimate.details.weight}kg',
                        ),
                        if (estimate.details.specialInstructions
                            case final instructions?) ...[
                          const Divider(),
                          _buildDetailRow(
                            context,
                            'Instructions',
                            instructions,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // Coupon selector
                BlocBuilder<CouponCubit, CouponState>(
                  builder: (context, couponState) {
                    return OutlineButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => BlocProvider.value(
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
                                              .data
                                              ?.bestDiscountAmount ??
                                          0;
                                    } else {
                                      discountAmount = 0;
                                    }
                                  });
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
                                  ? 'Apply Coupon'
                                  : 'Coupon: ${selectedCoupon!.code}',
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
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12.h,
                      children: [
                        DefaultText(
                          'Price Breakdown',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        _buildPriceRow(
                          context,
                          'Distance',
                          '${estimate.summary.distanceKm}km',
                        ),
                        _buildPriceRow(
                          context,
                          'Base Fare',
                          context.formatCurrency(estimate.summary.baseFare),
                        ),
                        _buildPriceRow(
                          context,
                          'Distance Fare',
                          context.formatCurrency(estimate.summary.distanceFare),
                        ),
                        const Divider(),
                        _buildPriceRow(
                          context,
                          'Subtotal',
                          context.formatCurrency(estimate.summary.totalCost),
                        ),
                        if (discountAmount > 0) ...[
                          const Divider(),
                          _buildPriceRow(
                            context,
                            'Discount',
                            '- ${context.formatCurrency(discountAmount)}',
                            isDiscount: true,
                          ),
                        ],
                        const Divider(),
                        _buildPriceRow(
                          context,
                          'Total',
                          context.formatCurrency(
                            estimate.summary.totalCost - discountAmount,
                          ),
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: Button.primary(
                    onPressed: () {
                      // Store coupon in delivery cubit for payment screen
                      if (selectedCoupon != null) {
                        context.read<UserDeliveryCubit>().setSelectedCoupon(
                          selectedCoupon!.code,
                        );
                      }
                      context.push(Routes.userDeliveryPayment.path);
                    },
                    child: const Text('Choose Payment Method'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
