import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RideSummaryWidget extends StatelessWidget {
  const RideSummaryWidget({required this.summary, super.key});
  final OrderSummary? summary;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        spacing: 6.h,
        children: [
          _buildRow('Distance', '${summary?.distanceKm} Km'),
          const Divider(),
          _buildRow(
            'Fare',
            context.formatCurrency(summary?.subtotal ?? 0),
          ),
          const Divider(),
          _buildRow('Tax', context.formatCurrency(summary?.tax ?? 0)),
          const Divider(),
          _buildRow(
            'Platform fee',
            context.formatCurrency(summary?.platformFee ?? 0),
          ),
          const Divider(),
          _buildRow(
            'Total cost',
            context.formatCurrency(summary?.platformFee ?? 0),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DefaultText(key, fontSize: 14.sp),
        DefaultText(value, fontSize: 14.sp),
      ],
    );
  }
}
