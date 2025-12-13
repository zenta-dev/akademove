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
  EarningsPeriod _selectedPeriod = EarningsPeriod.daily;

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

        return Scaffold(
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
          child: isLoading && wallet == null
              ? const Center(child: CircularProgressIndicator())
              : RefreshTrigger(
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.dg),
                    child: Column(
                      spacing: 16.h,
                      children: [
                        // Current Balance Card
                        _buildCurrentBalanceCard(wallet),
                        // Summary Cards (Side-by-Side)
                        _buildSummaryCards(transactions),
                        // Income & Outcome Chart Section
                        _buildChartSection(transactions),
                        // Balance Detail List
                        _buildBalanceDetailList(transactions),
                        // Action Buttons
                        _buildActionButtons(wallet),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  /// Current Saldo Card - Light cream background with prominent balance
  Widget _buildCurrentBalanceCard(Wallet? wallet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.dg),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Text(
            context.l10n.current_saldo,
            style: context.typography.p.copyWith(
              fontSize: 14.sp,
              color: const Color(0xFF8B7355),
            ),
          ),
          Text(
            context.formatCurrency(wallet?.balance ?? 0),
            style: context.typography.h1.copyWith(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4A3728),
            ),
          ),
        ],
      ),
    );
  }

  /// Summary Cards - Two side-by-side cards for incoming/outgoing balance
  Widget _buildSummaryCards(List<Transaction> transactions) {
    final incoming = _calculateIncomingBalance(transactions);
    final outgoing = _calculateOutgoingBalance(transactions);

    return Row(
      spacing: 12.w,
      children: [
        Expanded(
          child: _buildSummaryCard(
            title: context.l10n.incoming_balance,
            amount: incoming,
            icon: LucideIcons.arrowDownLeft,
            iconBackgroundColor: const Color(0xFFE3F2FD),
            iconColor: const Color(0xFF1976D2),
          ),
        ),
        Expanded(
          child: _buildSummaryCard(
            title: context.l10n.outgoing_balance,
            amount: outgoing,
            icon: LucideIcons.arrowUpRight,
            iconBackgroundColor: const Color(0xFFFFEBEE),
            iconColor: const Color(0xFFD32F2F),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required num amount,
    required IconData icon,
    required Color iconBackgroundColor,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4FD),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Row(
            spacing: 8.w,
            children: [
              Container(
                padding: EdgeInsets.all(6.dg),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, size: 16.sp, color: iconColor),
              ),
              Expanded(
                child: Text(
                  title,
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xFF5C6BC0),
                  ),
                ),
              ),
            ],
          ),
          Text(
            context.formatCurrency(amount),
            style: context.typography.h3.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A237E),
            ),
          ),
        ],
      ),
    );
  }

  /// Chart Section with period filter buttons
  Widget _buildChartSection(List<Transaction> transactions) {
    return Container(
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [
          Text(
            context.l10n.income_outcome_chart,
            style: context.typography.h3.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Chart visualization
          _buildLineChart(transactions),
          // Period filter buttons
          _buildPeriodFilterButtons(),
        ],
      ),
    );
  }

  /// Simple line chart representation
  Widget _buildLineChart(List<Transaction> transactions) {
    // Generate chart data points based on selected period
    final chartData = _generateChartData(transactions);

    if (chartData.isEmpty) {
      return Container(
        height: 150.h,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.h,
          children: [
            Icon(
              LucideIcons.chartArea,
              size: 32.sp,
              color: context.colorScheme.mutedForeground,
            ),
            Text(
              context.l10n.no_data_available,
              style: context.typography.small.copyWith(
                color: context.colorScheme.mutedForeground,
              ),
            ),
          ],
        ),
      );
    }

    final maxValue = chartData
        .map((d) => d.income > d.outcome ? d.income : d.outcome)
        .reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 150.h,
      child: Column(
        children: [
          // Y-axis labels and chart area
          Expanded(
            child: Row(
              children: [
                // Y-axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      context.formatCurrency(maxValue),
                      style: context.typography.small.copyWith(
                        fontSize: 10.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                    Text(
                      context.formatCurrency(maxValue * 0.5),
                      style: context.typography.small.copyWith(
                        fontSize: 10.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                    Text(
                      context.formatCurrency(0),
                      style: context.typography.small.copyWith(
                        fontSize: 10.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8.w),
                // Chart area with bars
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: chartData.map((data) {
                      final incomeHeight = maxValue > 0
                          ? (data.income / maxValue) * 100.h
                          : 0.0;
                      final outcomeHeight = maxValue > 0
                          ? (data.outcome / maxValue) * 100.h
                          : 0.0;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            spacing: 2.w,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Income bar
                              Container(
                                width: 12.w,
                                height: incomeHeight,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4CAF50),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(4.r),
                                  ),
                                ),
                              ),
                              // Outcome bar
                              Container(
                                width: 12.w,
                                height: outcomeHeight,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF44336),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(4.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          // X-axis labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: chartData.map((data) {
              return Text(
                data.label,
                style: context.typography.small.copyWith(
                  fontSize: 10.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 12.h),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16.w,
            children: [
              _buildLegendItem(context.l10n.income, const Color(0xFF4CAF50)),
              _buildLegendItem(context.l10n.outcome, const Color(0xFFF44336)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      spacing: 4.w,
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        Text(
          label,
          style: context.typography.small.copyWith(
            fontSize: 12.sp,
            color: context.colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }

  /// Period filter buttons (Daily, Weekly, Monthly)
  Widget _buildPeriodFilterButtons() {
    return Row(
      spacing: 8.w,
      children: [
        Expanded(
          child: _buildPeriodButton(
            label: context.l10n.daily,
            period: EarningsPeriod.daily,
          ),
        ),
        Expanded(
          child: _buildPeriodButton(
            label: context.l10n.weekly,
            period: EarningsPeriod.weekly,
          ),
        ),
        Expanded(
          child: _buildPeriodButton(
            label: context.l10n.monthly,
            period: EarningsPeriod.monthly,
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodButton({
    required String label,
    required EarningsPeriod period,
  }) {
    final isSelected = _selectedPeriod == period;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPeriod = period;
        });
        context.read<DriverEarningsCubit>().setSelectedPeriod(period);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primary
              : context.colorScheme.background,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.border,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: context.typography.small.copyWith(
            fontSize: 13.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected
                ? context.colorScheme.primaryForeground
                : context.colorScheme.foreground,
          ),
        ),
      ),
    );
  }

  /// Balance Detail List - Transaction history card
  Widget _buildBalanceDetailList(List<Transaction> transactions) {
    final relevantTransactions = transactions
        .where(
          (t) =>
              t.type == TransactionType.EARNING ||
              t.type == TransactionType.COMMISSION,
        )
        .take(10)
        .toList();

    return Container(
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            context.l10n.balance_details,
            style: context.typography.h3.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (relevantTransactions.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: Column(
                  spacing: 8.h,
                  children: [
                    Icon(
                      LucideIcons.receipt,
                      size: 40.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                    Text(
                      context.l10n.no_transactions_yet,
                      style: context.typography.small.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...relevantTransactions.map(_buildTransactionItem),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    final isIncoming = transaction.type == TransactionType.EARNING;
    final color = isIncoming
        ? const Color(0xFF4CAF50)
        : const Color(0xFFF44336);
    final icon = isIncoming
        ? LucideIcons.arrowDownLeft
        : LucideIcons.arrowUpRight;
    final title = isIncoming
        ? context.l10n.incoming_balance
        : context.l10n.outgoing_balance;

    // Parse order type from description or metadata
    String subtitle = transaction.description ?? '';
    if (subtitle.isEmpty) {
      subtitle = isIncoming
          ? 'Ride (${context.formatCurrency(transaction.amount)})'
          : 'Commission';
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        spacing: 12.w,
        children: [
          // Icon thumbnail
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20.sp, color: color),
          ),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                Text(
                  title,
                  style: context.typography.p.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  DateFormat(
                    'dd-MM-yyyy HH:mm',
                  ).format(transaction.createdAt.toLocal()),
                  style: context.typography.small.copyWith(
                    fontSize: 11.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          // Amount
          Text(
            '${isIncoming ? '+' : '-'}${context.formatCurrency(transaction.amount)}',
            style: context.typography.h4.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// Action Buttons - Withdrawal and Export to PDF
  Widget _buildActionButtons(Wallet? wallet) {
    return Row(
      spacing: 12.w,
      children: [
        Expanded(
          child: OutlineButton(
            onPressed: () {
              context.push(Routes.driverEarnings.path);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.w,
              children: [
                Icon(LucideIcons.banknote, size: 18.sp),
                Text(context.l10n.withdrawal),
              ],
            ),
          ),
        ),
        Expanded(
          child: PrimaryButton(
            onPressed: () {
              context.showMyToast(
                context.l10n.export_coming_soon,
                type: ToastType.info,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.w,
              children: [
                Icon(LucideIcons.fileDown, size: 18.sp),
                Text(context.l10n.export_pdf),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper methods for calculations
  num _calculateIncomingBalance(List<Transaction> transactions) {
    return transactions
        .where(
          (t) =>
              t.type == TransactionType.EARNING ||
              t.type == TransactionType.TOPUP ||
              t.type == TransactionType.REFUND,
        )
        .fold<num>(0, (sum, t) => sum + t.amount.abs());
  }

  num _calculateOutgoingBalance(List<Transaction> transactions) {
    return transactions
        .where(
          (t) =>
              t.type == TransactionType.COMMISSION ||
              t.type == TransactionType.WITHDRAW ||
              t.type == TransactionType.PAYMENT,
        )
        .fold<num>(0, (sum, t) => sum + t.amount.abs());
  }

  List<_ChartDataPoint> _generateChartData(List<Transaction> transactions) {
    final now = DateTime.now();
    final data = <_ChartDataPoint>[];

    switch (_selectedPeriod) {
      case EarningsPeriod.daily:
        // Group by hour for the last 24 hours
        for (int hour = 0; hour < 24; hour += 4) {
          final hourStr = '${hour.toString().padLeft(2, '0')}:00';
          final hourTransactions = transactions.where((t) {
            final txHour = t.createdAt.toLocal().hour;
            return txHour >= hour && txHour < hour + 4;
          }).toList();

          final income = hourTransactions
              .where((t) => t.type == TransactionType.EARNING)
              .fold<num>(0, (sum, t) => sum + t.amount.abs());
          final outcome = hourTransactions
              .where((t) => t.type == TransactionType.COMMISSION)
              .fold<num>(0, (sum, t) => sum + t.amount.abs());

          data.add(
            _ChartDataPoint(label: hourStr, income: income, outcome: outcome),
          );
        }
        break;

      case EarningsPeriod.weekly:
        // Group by day for the last 7 days
        final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        for (int i = 6; i >= 0; i--) {
          final date = now.subtract(Duration(days: i));
          final dayTransactions = transactions.where((t) {
            final txDate = t.createdAt.toLocal();
            return txDate.year == date.year &&
                txDate.month == date.month &&
                txDate.day == date.day;
          }).toList();

          final income = dayTransactions
              .where((t) => t.type == TransactionType.EARNING)
              .fold<num>(0, (sum, t) => sum + t.amount.abs());
          final outcome = dayTransactions
              .where((t) => t.type == TransactionType.COMMISSION)
              .fold<num>(0, (sum, t) => sum + t.amount.abs());

          data.add(
            _ChartDataPoint(
              label: days[date.weekday % 7],
              income: income,
              outcome: outcome,
            ),
          );
        }
        break;

      case EarningsPeriod.monthly:
        // Group by week for the last month
        for (int week = 1; week <= 4; week++) {
          final weekStart = now.subtract(Duration(days: (4 - week) * 7 + 7));
          final weekEnd = weekStart.add(const Duration(days: 7));
          final weekTransactions = transactions.where((t) {
            final txDate = t.createdAt.toLocal();
            return txDate.isAfter(weekStart) && txDate.isBefore(weekEnd);
          }).toList();

          final income = weekTransactions
              .where((t) => t.type == TransactionType.EARNING)
              .fold<num>(0, (sum, t) => sum + t.amount.abs());
          final outcome = weekTransactions
              .where((t) => t.type == TransactionType.COMMISSION)
              .fold<num>(0, (sum, t) => sum + t.amount.abs());

          data.add(
            _ChartDataPoint(label: 'W$week', income: income, outcome: outcome),
          );
        }
        break;
    }

    return data;
  }
}

class _ChartDataPoint {
  final String label;
  final num income;
  final num outcome;

  _ChartDataPoint({
    required this.label,
    required this.income,
    required this.outcome,
  });
}
