import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauges;

class MerchantSalesReportDetailScreen extends StatelessWidget {
  const MerchantSalesReportDetailScreen({super.key});

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
                  'Earns',
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

  Widget _buildTopOrderedCategories(BuildContext context) {
    final data = [
      _ChartData('Junk Food', 40, const Color(0xFF5EC4D4)),
      _ChartData('Drinks', 35, const Color(0xFFF9EFC7)),
      _ChartData('Snack', 25, Colors.gray.shade400),
    ];

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          spacing: 16.h,
          children: [
            Text(
              'Top Ordered Categories',
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

  Widget _buildTopOrderedProducts(BuildContext context) {
    final products = [
      ('Fried Chicken', 320, const Color(0xFF5EC4D4)),
      ('Coffee Latte', 250, const Color(0xFFF9EFC7)),
      ('Laundry Express', 190, Colors.gray.shade400),
    ];

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Ordered Products',
              style: context.typography.p.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              spacing: 16.h,
              children: products.map((item) {
                final name = item.$1;
                final value = item.$2;
                final color = item.$3;
                final width = (value / 320) * 200.w;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 6.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: context.typography.p.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
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
                      '$value',
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
    return Stack(
      children: [
        MyScaffold(
          headers: const [
            DefaultAppBar(title: 'Sales Report'),
          ],
          padding: EdgeInsets.all(16.w),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: 100.h,
              ),
              child: Column(
                spacing: 16.h,
                children: [
                  _buildSalesGauge(
                    context: context,
                    title: 'Weekly Sales',
                    value: 70,
                    amount: 'Rp 1.500.000',
                  ),
                  _buildSalesGauge(
                    context: context,
                    title: 'Monthly Sales',
                    value: 85,
                    amount: 'Rp 6.800.000',
                  ),
                  _buildTopOrderedCategories(context),
                  _buildTopOrderedProducts(context),
                ],
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
                  onPressed: () {},
                  child: Text(
                    'Export to PDF',
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
  }
}

class _ChartData {
  _ChartData(this.label, this.value, this.color);
  final String label;
  final double value;
  final Color color;
}
