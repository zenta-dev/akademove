import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;

class MerchantCommissionReportDetailScreen extends StatelessWidget {
  const MerchantCommissionReportDetailScreen({super.key});

  Widget _buildBalanceCards(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: [
        Expanded(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text bisa pindah baris
                    Expanded(
                      child: Text(
                        'Incoming Balance',
                        style: context.typography.p.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                    const Icon(Icons.arrow_outward_rounded),
                  ],
                ),
                Text(
                  'Rp 100.000',
                  style: context.typography.p.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Outgoing Balance',
                        style: context.typography.p.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                    const Icon(Icons.arrow_outward_rounded),
                  ],
                ),
                Text(
                  'Rp 50.000',
                  style: context.typography.p.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceDetail(BuildContext context) {
    final details = [
      {'title': 'Incoming Balance', 'desc': 'Food (Rp 15.000)'},
      {'title': 'Incoming Balance', 'desc': 'Mart (Rp 15.000)'},
      {'title': 'Incoming Balance', 'desc': 'Print (Rp 15.000)'},
      {'title': 'Outgoing Balance', 'desc': 'Withdraw (Rp 150.000)'},
    ];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              'Balance Detail',
              style: context.typography.p.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            ...details.map(
              (d) => Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/drink.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d['title']!,
                          style: context.typography.p.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: true,
                          maxLines: 2,
                        ),
                        Text(
                          d['desc']!,
                          style: context.typography.p.copyWith(
                            fontSize: 12.sp,
                            color: Colors.gray,
                          ),
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ],
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

  Widget _buildCommissionChart(BuildContext context) {
    final data = [
      _ChartData('Nett Income', 75, const Color(0xFF5EC4D4)),
      _ChartData('Platform Commission', 35, const Color(0xFFF9EFC7)),
    ];

    return Card(
      child: Column(
        spacing: 16.h,
        children: [
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
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _summaryCard(context, 'Gross Sales', 'Rp 1.500.000'),
        _summaryCard(context, 'Platform Commission (20%)', 'Rp 300.000'),
        _summaryCard(context, 'Net Income', 'Rp 1.200.000'),
      ],
    );
  }

  Widget _summaryCard(BuildContext context, String title, String value) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        filled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.typography.small.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: context.typography.p.copyWith(
                fontWeight: FontWeight.w600,
              ),
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
          headers: const [DefaultAppBar(title: 'Commission Report')],
          padding: EdgeInsets.all(16.w),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 120.h),
              child: Column(
                spacing: 16.h,
                children: [
                  _buildBalanceCards(context),
                  _buildBalanceDetail(context),
                  _buildSummarySection(context),
                  _buildCommissionChart(context),
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
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Button.outline(
                      onPressed: () {},
                      child: Text(
                        'Withdrawal',
                        style: context.typography.small.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Button.primary(
                      onPressed: () {},
                      child: Text(
                        'Export to PDF',
                        style: context.typography.small.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
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
