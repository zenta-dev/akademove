import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;

class MerchantCommissionReportDetailScreen extends StatefulWidget {
  const MerchantCommissionReportDetailScreen({super.key});

  @override
  State<MerchantCommissionReportDetailScreen> createState() =>
      _MerchantCommissionReportDetailScreenState();
}

class _MerchantCommissionReportDetailScreenState
    extends State<MerchantCommissionReportDetailScreen> {
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
    final state = context.read<MerchantAnalyticsCubit>().state;

    // Ensure we have data to export
    if (!state.analytics.isSuccess || state.analytics.value == null) {
      showToast(
        context: context,
        builder: (context, overlay) => context.buildToast(
          title: context.l10n.error,
          message: context.l10n.an_error_occurred,
        ),
        location: ToastLocation.topCenter,
      );
      return;
    }

    setState(() => _isExporting = true);

    try {
      final pdfService = sl<PdfService>();

      // Generate PDF using client-side generation
      final pdfBytes = await pdfService.generateMerchantCommissionReportPdf(
        totalRevenue: state.totalRevenue,
        totalCommission: state.totalCommission,
        netIncome: state.netIncome,
        commissionRate: state.commissionRate,
        period: context.l10n.monthly,
      );

      // Share/save the PDF
      final now = DateTime.now();
      final filename =
          'merchant_commission_report_${DateFormat('yyyyMMdd_HHmmss').format(now)}.pdf';

      await pdfService.sharePdf(pdfBytes: pdfBytes, filename: filename);

      if (mounted) {
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: context.l10n.success,
            message: context.l10n.export_success,
          ),
          location: ToastLocation.topCenter,
        );
      }
    } catch (e) {
      if (mounted) {
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: context.l10n.error,
            message: context.l10n.export_failed,
          ),
          location: ToastLocation.topCenter,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  Widget _buildBalanceCards(
    BuildContext context,
    num totalRevenue,
    num totalCommission,
  ) {
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
                        context.l10n.label_incoming_balance,
                        style: context.typography.p.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                    const Icon(LucideIcons.arrowUpRight),
                  ],
                ),
                Text(
                  _currencyFormat.format(totalRevenue),
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
                        context.l10n.label_outgoing_balance,
                        style: context.typography.p.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                    const Icon(LucideIcons.arrowUpRight),
                  ],
                ),
                Text(
                  _currencyFormat.format(totalCommission),
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

  Widget _buildBalanceDetail(
    BuildContext context,
    num totalRevenue,
    num totalCommission,
  ) {
    final details = [
      {
        'title': context.l10n.label_incoming_balance,
        'desc':
            '${context.l10n.food} (${_currencyFormat.format(totalRevenue)})',
      },
      {
        'title': context.l10n.label_outgoing_balance,
        'desc':
            '${context.l10n.commission} (${_currencyFormat.format(totalCommission)})',
      },
    ];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              context.l10n.label_balance_detail,
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
                      color: Colors.gray.shade100,
                    ),
                    child: const Center(
                      child: Icon(
                        LucideIcons.receipt,
                        size: 24,
                        color: Colors.gray,
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

  Widget _buildCommissionChart(
    BuildContext context,
    num netIncome,
    num totalCommission,
  ) {
    final data = [
      _ChartData(
        context.l10n.label_nett_income,
        netIncome.toDouble(),
        const Color(0xFF5EC4D4),
      ),
      _ChartData(
        context.l10n.commission,
        totalCommission.toDouble(),
        const Color(0xFFF9EFC7),
      ),
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

  Widget _buildSummarySection(
    BuildContext context,
    num totalRevenue,
    num totalCommission,
    num netIncome,
  ) {
    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _summaryCard(
          context,
          context.l10n.label_gross_sales,
          _currencyFormat.format(totalRevenue),
        ),
        _summaryCard(
          context,
          context.l10n.label_platform_commission,
          _currencyFormat.format(totalCommission),
        ),
        _summaryCard(
          context,
          context.l10n.label_net_income,
          _currencyFormat.format(netIncome),
        ),
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
              style: context.typography.p.copyWith(fontWeight: FontWeight.w600),
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
        final totalRevenue = state.totalRevenue;
        final totalCommission = state.totalCommission;
        final netIncome = state.netIncome;

        return Scaffold(
          headers: [DefaultAppBar(title: context.l10n.title_commission_report)],
          footers: [
            Padding(
              padding: EdgeInsets.all(16.dg),
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
                        ),
                      ),
              ),
            ),
          ],
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeRefreshTrigger(
                  onRefresh: () => context
                      .read<MerchantAnalyticsCubit>()
                      .getMonthlyAnalytics(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(16.dg),
                      child: Column(
                        spacing: 16.h,
                        children: [
                          _buildBalanceCards(
                            context,
                            totalRevenue,
                            totalCommission,
                          ),
                          _buildBalanceDetail(
                            context,
                            totalRevenue,
                            totalCommission,
                          ),
                          _buildSummarySection(
                            context,
                            totalRevenue,
                            totalCommission,
                            netIncome,
                          ),
                          _buildCommissionChart(
                            context,
                            netIncome,
                            totalCommission,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
