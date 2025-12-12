import 'package:akademove/features/coupon/presentation/cubits/_export.dart';
import 'package:akademove/features/coupon/presentation/states/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:intl/intl.dart';

/// Bottom sheet for selecting coupons
class CouponSelectorWidget extends StatelessWidget {
  const CouponSelectorWidget({required this.onCouponSelected, super.key});

  final void Function(Coupon?) onCouponSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponCubit, CouponState>(
      builder: (context, state) {
        if (state.eligibleCoupons.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.eligibleCoupons.isFailure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.triangleAlert, size: 48),
                const SizedBox(height: 16),
                Text(
                  state.eligibleCoupons.error?.message ??
                      'Failed to load coupons',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        final data = state.eligibleCoupons.value;
        if (data == null || data.coupons.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.ticketPercent, size: 48),
                const SizedBox(height: 16),
                Text(
                  context.l10n.coupon_no_coupons_available,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.coupon_select_coupon,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(LucideIcons.x),
                    onPressed: () => Navigator.pop(context),
                    variance: ButtonVariance.ghost,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Best coupon highlight (if any)
            if (data.bestCoupon != null && data.bestDiscountAmount > 0)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF10B981)),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.badgeCheck,
                      color: const Color(0xFF10B981),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Best Discount',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF10B981),
                            ),
                          ),
                          Text(
                            'Save ${_formatCurrency(data.bestDiscountAmount)} with ${data.bestCoupon?.code ?? ""}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Coupon list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: data.coupons.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final coupon = data.coupons[index];
                  final isSelected = data.bestCoupon?.id == coupon.id;

                  return _CouponCard(
                    coupon: coupon,
                    isSelected: isSelected,
                    onTap: () {
                      context.read<CouponCubit>().selectCoupon(coupon);
                      onCouponSelected(coupon);
                      Navigator.pop(context);
                    },
                    onInfo: () => _showCouponDetails(context, coupon),
                  );
                },
              ),
            ),

            // Remove coupon button
            if (data.bestCoupon != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: OutlineButton(
                  onPressed: () {
                    context.read<CouponCubit>().clearCoupon();
                    onCouponSelected(null);
                    Navigator.pop(context);
                  },
                  child: Text(context.l10n.coupon_remove_coupon),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showCouponDetails(BuildContext context, Coupon coupon) {
    showDialog(
      context: context,
      builder: (ctx) => CouponDetailDialog(coupon: coupon),
    );
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

/// Individual coupon card widget
class _CouponCard extends StatelessWidget {
  const _CouponCard({
    required this.coupon,
    required this.isSelected,
    required this.onTap,
    required this.onInfo,
  });

  final Coupon coupon;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onInfo;

  @override
  Widget build(BuildContext context) {
    final discountText = _getDiscountText();
    final expiryDate = DateFormat(
      'dd MMM yyyy',
    ).format(coupon.periodEnd.toLocal());
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withAlpha(25)
              : theme.colorScheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Discount icon/badge
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  LucideIcons.ticketPercent,
                  color: theme.colorScheme.primary,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Coupon details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coupon.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    discountText,
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Code: ${coupon.code}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '• Valid until $expiryDate',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Info button
            IconButton(
              icon: Icon(LucideIcons.info, size: 20),
              onPressed: onInfo,
              variance: ButtonVariance.ghost,
            ),
          ],
        ),
      ),
    );
  }

  String _getDiscountText() {
    if (coupon.discountPercentage != null) {
      final maxDiscount = coupon.rules.general?.maxDiscountAmount;
      final percentText = '${coupon.discountPercentage}% OFF';
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

/// Dialog showing full coupon details
class CouponDetailDialog extends StatelessWidget {
  const CouponDetailDialog({required this.coupon, super.key});

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(child: Text(coupon.name)),
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
            _buildInfoRow('Code', coupon.code),
            const SizedBox(height: 12),
            _buildInfoRow('Discount', _getDiscountText()),
            const SizedBox(height: 12),
            _buildInfoRow(
              'Valid Period',
              '${DateFormat('dd MMM yyyy').format(coupon.periodStart.toLocal())} - ${DateFormat('dd MMM yyyy').format(coupon.periodEnd.toLocal())}',
            ),
            if (coupon.rules.general?.minOrderAmount != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                'Minimum Order',
                _formatCurrency(coupon.rules.general?.minOrderAmount ?? 0),
              ),
            ],
            if (coupon.usageLimit > 0) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                'Usage',
                '${coupon.usedCount.toInt()} / ${coupon.usageLimit.toInt()} used',
              ),
            ],
            if (coupon.merchantId != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow('Type', 'Merchant-specific'),
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
      ],
    );
  }

  String _getDiscountText() {
    if (coupon.discountPercentage != null) {
      final maxDiscount = coupon.rules.general?.maxDiscountAmount;
      final percentText = '${coupon.discountPercentage}% OFF';
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
