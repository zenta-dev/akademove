import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserVoucherScreen extends StatefulWidget {
  const UserVoucherScreen({super.key});

  @override
  State<UserVoucherScreen> createState() => _UserVoucherScreenState();
}

class _UserVoucherScreenState extends State<UserVoucherScreen> {
  @override
  void initState() {
    super.initState();
    // Load all coupons when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserCouponCubit>().loadEligibleCoupons(
        serviceType: OrderType.RIDE,
        // Use a reasonable default amount to show available coupons
        // The actual eligibility will be checked when applying to an order
        totalAmount: 10000,
      );
    });
  }

  Future<void> _onRefresh() async {
    await context.read<UserCouponCubit>().loadEligibleCoupons(
      serviceType: OrderType.RIDE,
      totalAmount: 10000,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            context.l10n.voucher,
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
      child: RefreshTrigger(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.dg),
            child: BlocBuilder<UserCouponCubit, UserCouponState>(
              builder: (context, state) {
                if (state.eligibleCoupons.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.eligibleCoupons.isFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 16.h,
                      children: [
                        Icon(
                          LucideIcons.triangleAlert,
                          size: 64.sp,
                          color: context.colorScheme.destructive,
                        ),
                        Text(
                          state.eligibleCoupons.error?.message ??
                              context.l10n.failed_to_load,
                          style: context.typography.p.copyWith(fontSize: 14.sp),
                          textAlign: TextAlign.center,
                        ),
                        OutlineButton(
                          onPressed: () {
                            context.read<UserCouponCubit>().loadEligibleCoupons(
                              serviceType: OrderType.RIDE,
                              totalAmount: 10000,
                            );
                          },
                          child: Text(context.l10n.retry),
                        ),
                      ],
                    ),
                  );
                }

                final data = state.eligibleCoupons.value;
                if (data == null || data.coupons.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 16.h,
                      children: [
                        Icon(
                          LucideIcons.tag,
                          size: 64.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                        Text(
                          context.l10n.no_vouchers_available,
                          style: context.typography.h4.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          context.l10n.check_back_later_for_promotions,
                          style: context.typography.p.copyWith(
                            fontSize: 14.sp,
                            color: context.colorScheme.mutedForeground,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: data.coupons.asMap().entries.map((entry) {
                    final index = entry.key;
                    final coupon = entry.value;
                    final isBestCoupon = data.bestCoupon?.id == coupon.id;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < data.coupons.length - 1 ? 12.h : 0,
                      ),
                      child: _VoucherCard(
                        coupon: coupon,
                        isBestCoupon: isBestCoupon,
                        onTap: () => _showCouponDetails(context, coupon),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showCouponDetails(BuildContext context, Coupon coupon) {
    showDialog(
      context: context,
      builder: (ctx) => _CouponDetailDialog(coupon: coupon),
    );
  }
}

class _VoucherCard extends StatelessWidget {
  const _VoucherCard({
    required this.coupon,
    required this.isBestCoupon,
    required this.onTap,
  });

  final Coupon coupon;
  final bool isBestCoupon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final discountText = _getDiscountText();
    final expiryDate = DateFormat(
      'dd MMM yyyy',
    ).format(coupon.periodEnd.toLocal());
    final theme = Theme.of(context);
    final isExpiringSoon =
        coupon.periodEnd.toLocal().difference(DateTime.now()).inDays <= 3;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isBestCoupon
                ? const Color(0xFF10B981)
                : theme.colorScheme.border,
            width: isBestCoupon ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Main content
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  // Discount badge
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withAlpha(200),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Icon(
                        LucideIcons.ticketPercent,
                        color: Colors.white,
                        size: 32.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),

                  // Coupon details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                coupon.name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isBestCoupon)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withAlpha(25),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  'Best',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF10B981),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          discountText,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.muted,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                coupon.code,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              LucideIcons.calendar,
                              size: 12.sp,
                              color: isExpiringSoon
                                  ? theme.colorScheme.destructive
                                  : theme.colorScheme.mutedForeground,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              expiryDate,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: isExpiringSoon
                                    ? theme.colorScheme.destructive
                                    : theme.colorScheme.mutedForeground,
                              ),
                            ),
                            if (isExpiringSoon) ...[
                              SizedBox(width: 4.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.destructive
                                      .withAlpha(25),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  'Expiring',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.destructive,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    LucideIcons.chevronRight,
                    size: 20.sp,
                    color: theme.colorScheme.mutedForeground,
                  ),
                ],
              ),
            ),

            // Bottom info bar
            if (coupon.rules.general?.minOrderAmount != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted.withAlpha(128),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.info,
                      size: 12.sp,
                      color: theme.colorScheme.mutedForeground,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Min. order ${_formatCurrency(coupon.rules.general?.minOrderAmount ?? 0)}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: theme.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getDiscountText() {
    if (coupon.discountPercentage != null) {
      final maxDiscount = coupon.rules.general?.maxDiscountAmount;
      final percentText = '${coupon.discountPercentage?.toInt()}% OFF';
      if (maxDiscount != null && maxDiscount > 0) {
        return '$percentText (max ${_formatCurrency(maxDiscount)})';
      }
      return percentText;
    } else if (coupon.discountAmount case final discountAmount?) {
      return '${_formatCurrency(discountAmount)} OFF';
    }
    return 'Discount';
  }

  String _formatCurrency(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
}

class _CouponDetailDialog extends StatelessWidget {
  const _CouponDetailDialog({required this.coupon});

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(coupon.name, style: TextStyle(fontSize: 18.sp)),
          ),
          IconButton(
            icon: Icon(LucideIcons.x),
            onPressed: () => Navigator.pop(context),
            variance: ButtonVariance.ghost,
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInfoRow(context, 'Code', coupon.code),
            SizedBox(height: 12.h),
            _buildInfoRow(context, 'Discount', _getDiscountText()),
            SizedBox(height: 12.h),
            _buildInfoRow(
              context,
              'Valid Period',
              '${DateFormat('dd MMM yyyy').format(coupon.periodStart.toLocal())} - ${DateFormat('dd MMM yyyy').format(coupon.periodEnd.toLocal())}',
            ),
            if (coupon.rules.general?.minOrderAmount != null) ...[
              SizedBox(height: 12.h),
              _buildInfoRow(
                context,
                'Minimum Order',
                _formatCurrency(coupon.rules.general?.minOrderAmount ?? 0),
              ),
            ],
            if (coupon.usageLimit > 0) ...[
              SizedBox(height: 12.h),
              _buildInfoRow(
                context,
                'Usage',
                '${coupon.usedCount.toInt()} / ${coupon.usageLimit.toInt()} used',
              ),
            ],
            if (coupon.rules.user?.perUserLimit != null) ...[
              SizedBox(height: 12.h),
              _buildInfoRow(
                context,
                'Per User Limit',
                '${coupon.rules.user?.perUserLimit} time(s)',
              ),
            ],
            if (coupon.merchantId != null) ...[
              SizedBox(height: 12.h),
              _buildInfoRow(context, 'Type', 'Merchant-specific'),
            ],
            if (coupon.rules.time?.allowedDays != null &&
                coupon.rules.time!.allowedDays!.isNotEmpty) ...[
              SizedBox(height: 12.h),
              _buildInfoRow(
                context,
                'Valid Days',
                coupon.rules.time!.allowedDays!.map((d) => d.name).join(', '),
              ),
            ],
          ],
        ),
      ),
      actions: [
        PrimaryButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.close),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
              color: Theme.of(context).colorScheme.mutedForeground,
            ),
          ),
        ),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 13.sp)),
        ),
      ],
    );
  }

  String _getDiscountText() {
    if (coupon.discountPercentage != null) {
      final maxDiscount = coupon.rules.general?.maxDiscountAmount;
      final percentText = '${coupon.discountPercentage?.toInt()}% OFF';
      if (maxDiscount != null && maxDiscount > 0) {
        return '$percentText (max ${_formatCurrency(maxDiscount)})';
      }
      return percentText;
    } else if (coupon.discountAmount case final discountAmount?) {
      return '${_formatCurrency(discountAmount)} OFF';
    }
    return 'Discount';
  }

  String _formatCurrency(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
}
