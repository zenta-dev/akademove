import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' show RefreshIndicator;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauges;

class MerchantSalesReportDetailScreen extends StatefulWidget {
  const MerchantSalesReportDetailScreen({super.key});

  @override
  State<MerchantSalesReportDetailScreen> createState() =>
      _MerchantSalesReportDetailScreenState();
}

class _MerchantSalesReportDetailScreenState
    extends State<MerchantSalesReportDetailScreen> {
  final _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    // Fetch analytics data on init
    context.read<MerchantAnalyticsCubit>().getMonthlyAnalytics();
  }

  Future<void> _handleExport() async {
    setState(() => _isExporting = true);

    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    await context.read<MerchantAnalyticsCubit>().exportAnalytics(
      startDate: startOfMonth,
      endDate: now,
    );

    if (!mounted) return;

    final state = context.read<MerchantAnalyticsCubit>().state;
    setState(() => _isExporting = false);

    if (state.exportResult.isSuccess) {
      showToast(
        context: context,
        builder: (context, overlay) => context.buildToast(
          title: context.l10n.success,
          message: context.l10n.toast_success,
        ),
        location: ToastLocation.topCenter,
      );
      context.read<MerchantAnalyticsCubit>().clearExportResult();
    } else if (state.exportResult.isFailed) {
      showToast(
        context: context,
        builder: (context, overlay) => context.buildToast(
          title: context.l10n.error,
          message:
              state.exportResult.error?.message ??
              context.l10n.an_error_occurred,
        ),
        location: ToastLocation.topCenter,
      );
    }
  }

  Widget _buildSalesGauge({
    required BuildContext context,
    required String title,
    required double value,
    required String amount,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          spacing: 16.h,
          children: [
            Text(
              title,
              style: context.typography.p.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 160.w,
              height: 160.w,
              child: gauges.SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 1500,
                axes: <gauges.RadialAxis>[
                  gauges.RadialAxis(
                    showLabels: false,
                    showTicks: false,
                    startAngle: 270,
                    endAngle: 270,
                    axisLineStyle: gauges.AxisLineStyle(
                      thickness: 10.w,
                      color: Colors.gray,
                    ),
                    pointers: <gauges.GaugePointer>[
                      gauges.RangePointer(
                        value: value,
                        width: 10.w,
                        cornerStyle: gauges.CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: <gauges.GaugeAnnotation>[
                      gauges.GaugeAnnotation(
                        widget: Text(
                          '${value.toInt()}%',
                          style: context.typography.p.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        angle: 90,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              spacing: 8.h,
              children: [
                Text(
                  context.l10n.label_earns,
                  style: context.typography.p.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  amount,
                  style: context.typography.p.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopOrderedCategories(
    BuildContext context,
    List<MerchantAnalytics200ResponseDataTopSellingItemsInner> topItems,
  ) {
    // Group items by a simple category logic (you may want to enhance this)
    // For now, we use the items directly with colors
    final colors = [
      const Color(0xFF5EC4D4),
      const Color(0xFFF9EFC7),
      Colors.gray.shade400,
      const Color(0xFF8BC34A),
      const Color(0xFFFF9800),
    ];

    final data = topItems.take(5).toList().asMap().entries.map((entry) {
      return _ChartData(
        entry.value.menuName,
        entry.value.totalOrders.toDouble(),
        colors[entry.key % colors.length],
      );
    }).toList();

    if (data.isEmpty) {
      return SizedBox(
        width: double.infinity,
        child: Card(
          child: Column(
            spacing: 16.h,
            children: [
              Text(
                context.l10n.label_top_ordered_categories,
                style: context.typography.p.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                context.l10n.no_orders_found,
                style: context.typography.p.copyWith(
                  fontSize: 14.sp,
                  color: Colors.gray,
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          spacing: 16.h,
          children: [
            Text(
              context.l10n.label_top_ordered_categories,
              style: context.typography.p.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 180.h,
              child: charts.SfCircularChart(
                series: <charts.CircularSeries<_ChartData, String>>[
                  charts.DoughnutSeries<_ChartData, String>(
                    dataSource: data,
                    xValueMapper: (_ChartData d, _) => d.label,
                    yValueMapper: (_ChartData d, _) => d.value,
                    pointColorMapper: (_ChartData d, _) => d.color,
                    innerRadius: '70%',
                    radius: '90%',
                  ),
                ],
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16.w,
              runSpacing: 8.h,
              children: data
                  .map(
                    (item) => Row(
                      spacing: 8.w,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 16.w,
                          height: 16.w,
                          decoration: BoxDecoration(
                            color: item.color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Text(
                          item.label,
                          style: context.typography.p.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopOrderedProducts(
    BuildContext context,
    List<MerchantAnalytics200ResponseDataTopSellingItemsInner> topItems,
  ) {
    final colors = [
      const Color(0xFF5EC4D4),
      const Color(0xFFF9EFC7),
      Colors.gray.shade400,
      const Color(0xFF8BC34A),
      const Color(0xFFFF9800),
    ];

    final maxOrders = topItems.isNotEmpty
        ? topItems
              .map((e) => e.totalOrders.toDouble())
              .reduce((a, b) => a > b ? a : b)
        : 1.0;

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.label_top_ordered_products,
              style: context.typography.p.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (topItems.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(
                  child: Text(
                    context.l10n.no_orders_found,
                    style: context.typography.p.copyWith(
                      fontSize: 14.sp,
                      color: Colors.gray,
                    ),
                  ),
                ),
              )
            else
              Column(
                spacing: 16.h,
                children: topItems.take(5).toList().asMap().entries.map((
                  entry,
                ) {
                  final item = entry.value;
                  final color = colors[entry.key % colors.length];
                  final width =
                      (item.totalOrders.toDouble() / maxOrders) * 200.w;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          spacing: 6.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.menuName,
                              style: context.typography.p.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              width: width,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${item.totalOrders.toInt()}',
                        style: context.typography.p.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantAnalyticsCubit, MerchantAnalyticsState>(
      builder: (context, state) {
        final isLoading = state.analytics.isLoading;
        final analytics = state.analytics.value;

        // Calculate completion percentage (completed / total * 100)
        final totalOrders = analytics?.totalOrders.toDouble() ?? 0;
        final completedOrders = analytics?.completedOrders.toDouble() ?? 0;
        final completionRate = totalOrders > 0
            ? (completedOrders / totalOrders) * 100
            : 0.0;

        final totalRevenue = analytics?.totalRevenue.toDouble() ?? 0;
        final topItems = analytics?.topSellingItems ?? [];

        return Stack(
          children: [
            MyScaffold(
              headers: [DefaultAppBar(title: context.l10n.title_sales_report)],
              padding: EdgeInsets.all(16.w),
              body: SafeArea(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () => context
                            .read<MerchantAnalyticsCubit>()
                            .getMonthlyAnalytics(),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(bottom: 100.h),
                          child: Column(
                            spacing: 16.h,
                            children: [
                              _buildSalesGauge(
                                context: context,
                                title: context.l10n.label_weekly_sales,
                                value: completionRate.clamp(0, 100),
                                amount: _currencyFormat.format(
                                  totalRevenue * 0.25,
                                ),
                              ),
                              _buildSalesGauge(
                                context: context,
                                title: context.l10n.label_monthly_sales,
                                value: completionRate.clamp(0, 100),
                                amount: _currencyFormat.format(totalRevenue),
                              ),
                              _buildTopOrderedCategories(context, topItems),
                              _buildTopOrderedProducts(context, topItems),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 16,
              right: 16,
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Button.primary(
                      onPressed: _isExporting ? null : _handleExport,
                      child: _isExporting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              context.l10n.button_export_pdf,
                              style: context.typography.small.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ChartData {
  _ChartData(this.label, this.value, this.color);
  final String label;
  final double value;
  final Color color;
}
