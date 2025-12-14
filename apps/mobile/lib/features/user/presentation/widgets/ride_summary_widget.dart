import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RideSummaryWidget extends StatelessWidget {
  const RideSummaryWidget({
    required this.summary,
    this.discountAmount = 0,
    super.key,
  });
  final OrderSummary? summary;
  final num discountAmount;

  @override
  Widget build(BuildContext context) {
    final totalCost = summary?.totalCost ?? 0;
    final finalAmount = totalCost - discountAmount;

    return Card(
      child: Column(
        spacing: 6.h,
        children: [
          _buildRow(context.l10n.distance, '${summary?.distanceKm} Km'),
          const Divider(),
          _buildRow(
            context.l10n.fare,
            context.formatCurrency(summary?.subtotal ?? 0),
          ),
          const Divider(),
          _buildRow(
            context.l10n.tax,
            context.formatCurrency(summary?.tax ?? 0),
          ),
          const Divider(),
          _buildRow(
            context.l10n.platform_fee,
            context.formatCurrency(summary?.platformFee ?? 0),
          ),
          const Divider(),
          _buildRow('Subtotal', context.formatCurrency(totalCost)),
          if (discountAmount > 0) ...[
            const Divider(),
            _buildRow(
              'Discount',
              '- ${context.formatCurrency(discountAmount)}',
              isDiscount: true,
            ),
          ],
          const Divider(),
          _buildRow('Total', context.formatCurrency(finalAmount), isBold: true),
        ],
      ),
    );
  }

  Widget _buildRow(
    String key,
    String value, {
    bool isDiscount = false,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DefaultText(
          key,
          fontSize: 14.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
        DefaultText(
          value,
          fontSize: 14.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: isDiscount ? const Color(0xFF10B981) : null,
        ),
      ],
    );
  }
}
