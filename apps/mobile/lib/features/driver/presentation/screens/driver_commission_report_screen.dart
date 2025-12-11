import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverCommissionReportScreen extends StatefulWidget {
  const DriverCommissionReportScreen({super.key});

  @override
  State<DriverCommissionReportScreen> createState() =>
      _DriverCommissionReportScreenState();
}

class _DriverCommissionReportScreenState
    extends State<DriverCommissionReportScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DriverEarningsCubit>().init();
    });
  }

  Future<void> _onRefresh() async {
    await context.read<DriverEarningsCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverEarningsCubit, DriverEarningsState>(
      builder: (context, state) {
        final isLoading =
            state.fetchWalletResult.isLoading ||
            state.fetchTransactionsResult.isLoading;
        final wallet = state.wallet;
        final transactions = state.transactions;

        return MyScaffold(
          headers: [
            AppBar(
              title: Text(context.l10n.title_commission_report),
              leading: [
                IconButton(
                  icon: const Icon(LucideIcons.arrowLeft),
                  onPressed: () => context.pop(),
                  variance: ButtonVariance.ghost,
                ),
              ],
            ),
          ],
          body: isLoading && wallet == null
              ? const Center(child: CircularProgressIndicator())
              : RefreshTrigger(
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.dg),
                    child: Column(
                      spacing: 16.h,
                      children: [
                        _buildBalanceCards(transactions),
                        _buildCommissionChart(transactions),
                        _buildCommissionSummary(transactions),
                        _buildCommissionDetails(transactions),
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildBalanceCards(List<Transaction> transactions) {
    final totalEarnings = _calculateTotalEarnings(transactions);
    final totalCommission = _calculateTotalCommission(transactions);
    final netIncome = totalEarnings - totalCommission;

    return Row(
      spacing: 12.w,
      children: [
        Expanded(
          child: _buildBalanceCard(
            context.l10n.total_income,
            totalEarnings,
            LucideIcons.trendingUp,
            const Color(0xFF4CAF50),
          ),
        ),
        Expanded(
          child: _buildBalanceCard(
            context.l10n.commission,
            totalCommission,
            LucideIcons.trendingDown,
            const Color(0xFFF44336),
          ),
        ),
        Expanded(
          child: _buildBalanceCard(
            context.l10n.net_earnings,
            netIncome,
            LucideIcons.dollarSign,
            context.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCard(
    String label,
    num amount,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          spacing: 8.h,
          children: [
            Icon(icon, color: color, size: 24.sp),
            Text(
              label,
              style: context.typography.small.copyWith(
                color: context.colorScheme.mutedForeground,
              ),
            ),
            Text(
              context.formatCurrency(amount),
              style: context.typography.h4.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommissionChart(List<Transaction> transactions) {
    final totalEarnings = _calculateTotalEarnings(transactions);
    final totalCommission = _calculateTotalCommission(transactions);
    final netIncome = totalEarnings - totalCommission;

    if (totalEarnings == 0) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(32.dg),
          child: Center(
            child: Column(
              spacing: 12.h,
              children: [
                Icon(
                  LucideIcons.trendingUp,
                  size: 48.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Text(
                  'No commission data available',
                  style: context.typography.p.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          spacing: 16.h,
          children: [
            Text(
              'Commission Breakdown',
              style: context.typography.h3.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Simple pie chart representation using containers
            Row(
              spacing: 16.w,
              children: [
                // Pie chart visual
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.gray.shade300,
                  ),
                  child: Stack(
                    children: [
                      // Net income portion
                      Positioned.fill(
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: netIncome / totalEarnings,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                        ),
                      ),
                      // Commission portion
                      Positioned.fill(
                        child: FractionallySizedBox(
                          alignment: Alignment.centerRight,
                          widthFactor: totalCommission / totalEarnings,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFF44336),
                            ),
                          ),
                        ),
                      ),
                      // Center circle
                      Center(
                        child: Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colorScheme.background,
                          ),
                          child: Center(
                            child: Text(
                              '${((totalCommission / totalEarnings) * 100).toStringAsFixed(1)}%',
                              style: context.typography.h4.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Legend
                Expanded(
                  child: Column(
                    spacing: 12.h,
                    children: [
                      _buildLegendItem(
                        context.l10n.net_earnings,
                        netIncome,
                        const Color(0xFF4CAF50),
                      ),
                      _buildLegendItem(
                        context.l10n.commission,
                        totalCommission,
                        const Color(0xFFF44336),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, num amount, Color color) {
    return Row(
      spacing: 8.w,
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Expanded(child: Text(label, style: context.typography.small)),
        Text(
          context.formatCurrency(amount),
          style: context.typography.small.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildCommissionSummary(List<Transaction> transactions) {
    final totalEarnings = _calculateTotalEarnings(transactions);
    final totalCommission = _calculateTotalCommission(transactions);
    final commissionRate = totalEarnings > 0
        ? (totalCommission / totalEarnings) * 100
        : 0.0;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          spacing: 12.h,
          children: [
            Text(
              'Summary',
              style: context.typography.h3.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildSummaryRow(
              'Total Earnings',
              totalEarnings,
              LucideIcons.trendingUp,
            ),
            _buildSummaryRow(
              '${context.l10n.label_platform_commission} (${commissionRate.toStringAsFixed(1)}%)',
              totalCommission,
              LucideIcons.percent,
            ),
            _buildSummaryRow(
              'Net Income',
              totalEarnings - totalCommission,
              LucideIcons.dollarSign,
              isHighlighted: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    num amount,
    IconData icon, {
    bool isHighlighted = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        spacing: 12.w,
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: isHighlighted
                ? context.colorScheme.primary
                : context.colorScheme.mutedForeground,
          ),
          Expanded(
            child: Text(
              label,
              style: context.typography.p.copyWith(
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                color: isHighlighted
                    ? context.colorScheme.primary
                    : context.colorScheme.foreground,
              ),
            ),
          ),
          Text(
            context.formatCurrency(amount),
            style: context.typography.p.copyWith(
              fontWeight: FontWeight.bold,
              color: isHighlighted
                  ? context.colorScheme.primary
                  : context.colorScheme.foreground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommissionDetails(List<Transaction> transactions) {
    final commissionTransactions = transactions
        .where((t) => t.type == TransactionType.COMMISSION)
        .toList();

    if (commissionTransactions.isEmpty) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(32.dg),
          child: Center(
            child: Column(
              spacing: 12.h,
              children: [
                Icon(
                  LucideIcons.receipt,
                  size: 48.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Text(
                  context.l10n.no_transactions_yet,
                  style: context.typography.p.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          spacing: 12.h,
          children: [
            Text(
              'Commission Details',
              style: context.typography.h3.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...commissionTransactions.map(_buildCommissionTransactionCard),
          ],
        ),
      ),
    );
  }

  Widget _buildCommissionTransactionCard(Transaction transaction) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.dg),
        child: Row(
          spacing: 12.w,
          children: [
            Container(
              padding: EdgeInsets.all(8.dg),
              decoration: BoxDecoration(
                color: const Color(0xFFF44336).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.percent,
                size: 20.sp,
                color: const Color(0xFFF44336),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Text(
                    transaction.description ?? context.l10n.commission,
                    style: context.typography.h4.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat(
                      'MMM dd, yyyy HH:mm',
                    ).format(transaction.createdAt),
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '-${context.formatCurrency(transaction.amount)}',
              style: context.typography.h4.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF44336),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      spacing: 12.w,
      children: [
        Expanded(
          child: OutlineButton(
            onPressed: () {
              // TODO: Implement export functionality
              context.showMyToast(
                'Export feature coming soon',
                type: ToastType.info,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.w,
              children: [const Icon(LucideIcons.download), Text('Export')],
            ),
          ),
        ),
        Expanded(
          child: PrimaryButton(
            onPressed: () {
              // Navigate to earnings screen for withdrawal
              context.push(Routes.driverEarnings.path);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.w,
              children: [
                const Icon(LucideIcons.banknote),
                Text(context.l10n.withdraw_earnings),
              ],
            ),
          ),
        ),
      ],
    );
  }

  num _calculateTotalEarnings(List<Transaction> transactions) {
    return transactions
        .where((t) => t.type == TransactionType.EARNING)
        .fold<num>(0, (sum, t) => sum + t.amount);
  }

  num _calculateTotalCommission(List<Transaction> transactions) {
    return transactions
        .where((t) => t.type == TransactionType.COMMISSION)
        .fold<num>(0, (sum, t) => sum + t.amount);
  }
}
