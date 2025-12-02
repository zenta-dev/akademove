import 'package:akademove/core/_export.dart';
import 'package:akademove/features/coupon/presentation/cubits/_export.dart';
import 'package:akademove/features/coupon/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:intl/intl.dart';

/// Bottom sheet for selecting coupons
class CouponSelectorWidget extends material.StatelessWidget {
  const CouponSelectorWidget({required this.onCouponSelected, super.key});

  final void Function(Coupon?) onCouponSelected;

  @override
  material.Widget build(material.BuildContext context) {
    return BlocBuilder<CouponCubit, CouponState>(
      builder: (context, state) {
        if (state.state == CubitState.loading) {
          return const Center(child: material.CircularProgressIndicator());
        }

        if (state.state == CubitState.failure) {
          return Center(
            child: Column(
              mainAxisSize: material.MainAxisSize.min,
              children: [
                Icon(LucideIcons.triangleAlert, size: 48),
                const SizedBox(height: 16),
                Text(
                  state.error?.message ?? 'Failed to load coupons',
                  textAlign: material.TextAlign.center,
                ),
              ],
            ),
          );
        }

        final data = state.data;
        if (data == null || data.coupons.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: material.MainAxisSize.min,
              children: [
                Icon(LucideIcons.ticketPercent, size: 48),
                const SizedBox(height: 16),
                const Text(
                  'No coupons available',
                  textAlign: material.TextAlign.center,
                ),
              ],
            ),
          );
        }

        return material.Column(
          mainAxisSize: material.MainAxisSize.min,
          crossAxisAlignment: material.CrossAxisAlignment.stretch,
          children: [
            // Header
            material.Padding(
              padding: const EdgeInsets.all(16),
              child: material.Row(
                children: [
                  const material.Expanded(
                    child: Text(
                      'Select Coupon',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: material.FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(LucideIcons.x),
                    onPressed: () => material.Navigator.pop(context),
                    variance: const ButtonStyle.ghost(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Best coupon highlight (if any)
            if (data.bestCoupon != null && data.bestDiscountAmount > 0)
              material.Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: material.BoxDecoration(
                  color: const Color(0xFF10B981).withAlpha(25),
                  borderRadius: material.BorderRadius.circular(8),
                  border: material.Border.all(color: const Color(0xFF10B981)),
                ),
                child: material.Row(
                  children: [
                    Icon(
                      LucideIcons.badgeCheck,
                      color: const Color(0xFF10B981),
                    ),
                    const SizedBox(width: 12),
                    material.Expanded(
                      child: material.Column(
                        crossAxisAlignment: material.CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Best Discount',
                            style: TextStyle(
                              fontWeight: material.FontWeight.bold,
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
            material.Expanded(
              child: material.ListView.separated(
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
                      material.Navigator.pop(context);
                    },
                    onInfo: () => _showCouponDetails(context, coupon),
                  );
                },
              ),
            ),

            // Remove coupon button
            if (data.bestCoupon != null)
              material.Padding(
                padding: const EdgeInsets.all(16),
                child: OutlineButton(
                  onPressed: () {
                    context.read<CouponCubit>().clearCoupon();
                    onCouponSelected(null);
                    material.Navigator.pop(context);
                  },
                  child: const Text('Remove Coupon'),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showCouponDetails(material.BuildContext context, Coupon coupon) {
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
class _CouponCard extends material.StatelessWidget {
  const _CouponCard({
    required this.coupon,
    required this.isSelected,
    required this.onTap,
    required this.onInfo,
  });

  final Coupon coupon;
  final bool isSelected;
  final material.VoidCallback onTap;
  final material.VoidCallback onInfo;

  @override
  material.Widget build(material.BuildContext context) {
    final discountText = _getDiscountText();
    final expiryDate = DateFormat('dd MMM yyyy').format(coupon.periodEnd);
    final theme = Theme.of(context);

    return material.InkWell(
      onTap: onTap,
      borderRadius: material.BorderRadius.circular(12),
      child: material.Container(
        padding: const EdgeInsets.all(16),
        decoration: material.BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withAlpha(25)
              : theme.colorScheme.background,
          borderRadius: material.BorderRadius.circular(12),
          border: material.Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: material.Row(
          children: [
            // Discount icon/badge
            material.Container(
              width: 56,
              height: 56,
              decoration: material.BoxDecoration(
                color: theme.colorScheme.primary.withAlpha(25),
                borderRadius: material.BorderRadius.circular(8),
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
            material.Expanded(
              child: material.Column(
                crossAxisAlignment: material.CrossAxisAlignment.start,
                children: [
                  Text(
                    coupon.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: material.FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: material.TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    discountText,
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.primary,
                      fontWeight: material.FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  material.Row(
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
            material.IconButton(
              icon: Icon(LucideIcons.info, size: 20),
              onPressed: onInfo,
              padding: material.EdgeInsets.zero,
              constraints: const material.BoxConstraints(),
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
    } else if (coupon.discountAmount != null) {
      return '${_formatCurrency(coupon.discountAmount!)} OFF';
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
class CouponDetailDialog extends material.StatelessWidget {
  const CouponDetailDialog({required this.coupon, super.key});

  final Coupon coupon;

  @override
  material.Widget build(material.BuildContext context) {
    return AlertDialog(
      title: material.Row(
        children: [
          material.Expanded(child: Text(coupon.name)),
          material.IconButton(
            icon: Icon(LucideIcons.x),
            onPressed: () => material.Navigator.pop(context),
          ),
        ],
      ),
      content: material.SingleChildScrollView(
        child: material.Column(
          crossAxisAlignment: material.CrossAxisAlignment.start,
          mainAxisSize: material.MainAxisSize.min,
          children: [
            _buildInfoRow('Code', coupon.code),
            const SizedBox(height: 12),
            _buildInfoRow('Discount', _getDiscountText()),
            const SizedBox(height: 12),
            _buildInfoRow(
              'Valid Period',
              '${DateFormat('dd MMM yyyy').format(coupon.periodStart)} - ${DateFormat('dd MMM yyyy').format(coupon.periodEnd)}',
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
          onPressed: () => material.Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }

  material.Widget _buildInfoRow(String label, String value) {
    return material.Row(
      crossAxisAlignment: material.CrossAxisAlignment.start,
      children: [
        material.SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: material.FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        material.Expanded(
          child: Text(value, style: const TextStyle(fontSize: 13)),
        ),
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
    } else if (coupon.discountAmount != null) {
      return '${_formatCurrency(coupon.discountAmount!)} OFF';
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
