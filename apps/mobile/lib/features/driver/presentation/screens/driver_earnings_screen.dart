import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverEarningsScreen extends StatefulWidget {
  const DriverEarningsScreen({super.key});

  @override
  State<DriverEarningsScreen> createState() => _DriverEarningsScreenState();
}

class _DriverEarningsScreenState extends State<DriverEarningsScreen> {
  Wallet? _wallet;
  WalletMonthlySummaryResponse? _monthlySummary;
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  DateTime _selectedMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      // Load wallet, monthly summary, and transactions in parallel
      final results = await Future.wait([
        context.read<WalletRepository>().getWallet(),
        context.read<WalletRepository>().getMonthlySummary(
          month: _selectedMonth.month,
          year: _selectedMonth.year,
        ),
        context.read<TransactionRepository>().list(),
      ]);

      if (mounted) {
        setState(() {
          _wallet = (results[0] as BaseResponse<Wallet>).data;
          _monthlySummary =
              (results[1] as BaseResponse<WalletMonthlySummaryResponse>).data;
          _transactions = (results[2] as BaseResponse<List<Transaction>>).data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Error',
            message: 'Failed to load earnings: ${e.toString()}',
          ),
        );
      }
    }
  }

  Future<void> _onRefresh() async {
    await _loadData();
  }

  Future<void> _changeMonth(int delta) async {
    setState(() {
      _selectedMonth = DateTime(
        _selectedMonth.year,
        _selectedMonth.month + delta,
      );
    });
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          title: const Text('Earnings & Wallet'),
          leading: [
            IconButton(
              icon: const Icon(LucideIcons.arrowLeft),
              onPressed: () => context.pop(),
              variance: ButtonVariance.ghost,
            ),
          ],
        ),
      ],
      body: _isLoading && _wallet == null
          ? const Center(child: CircularProgressIndicator())
          : material.RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.dg),
                child: Column(
                  spacing: 16.h,
                  children: [
                    if (_wallet != null) _buildWalletBalanceCard(_wallet!),
                    if (_monthlySummary != null) _buildMonthSelector(),
                    if (_monthlySummary != null)
                      _buildEarningsSummary(_monthlySummary!),
                    _buildRecentTransactions(),
                    _buildWithdrawButton(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildWalletBalanceCard(Wallet wallet) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.dg),
        child: Column(
          spacing: 12.h,
          children: [
            Row(
              children: [
                Icon(
                  LucideIcons.wallet,
                  size: 24.sp,
                  color: context.colorScheme.primary,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Available Balance',
                  style: context.typography.h4.copyWith(
                    fontSize: 16.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            Text(
              context.formatCurrency(wallet.balance),
              style: context.typography.h1.copyWith(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: wallet.isActive
                    ? material.Colors.green.withValues(alpha: 0.1)
                    : material.Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: wallet.isActive
                      ? material.Colors.green
                      : material.Colors.grey,
                ),
              ),
              child: Text(
                wallet.isActive ? 'Active' : 'Inactive',
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: wallet.isActive
                      ? material.Colors.green
                      : material.Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    final monthFormat = DateFormat('MMMM yyyy');

    return Row(
      children: [
        IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => _changeMonth(-1),
          variance: ButtonVariance.ghost,
        ),
        Expanded(
          child: Text(
            monthFormat.format(_selectedMonth),
            textAlign: TextAlign.center,
            style: context.typography.h3.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(LucideIcons.chevronRight),
          onPressed:
              DateTime.now().month == _selectedMonth.month &&
                  DateTime.now().year == _selectedMonth.year
              ? null
              : () => _changeMonth(1),
          variance: ButtonVariance.ghost,
        ),
      ],
    );
  }

  Widget _buildEarningsSummary(WalletMonthlySummaryResponse summary) {
    return Column(
      spacing: 12.h,
      children: [
        Row(
          spacing: 12.w,
          children: [
            Expanded(
              child: _buildSummaryCard(
                'Total Income',
                summary.totalIncome,
                LucideIcons.trendingUp,
                material.Colors.green,
              ),
            ),
            Expanded(
              child: _buildSummaryCard(
                'Total Expense',
                summary.totalExpense,
                LucideIcons.trendingDown,
                material.Colors.red,
              ),
            ),
          ],
        ),
        _buildSummaryCard(
          'Net Earnings',
          summary.net,
          LucideIcons.dollarSign,
          summary.net >= 0 ? material.Colors.blue : material.Colors.red,
          isLarge: true,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String label,
    num amount,
    IconData icon,
    material.Color color, {
    bool isLarge = false,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isLarge ? 20.dg : 16.dg),
        child: Column(
          spacing: isLarge ? 12.h : 8.h,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.w,
              children: [
                Icon(icon, size: isLarge ? 24.sp : 20.sp, color: color),
                Text(
                  label,
                  style: context.typography.h4.copyWith(
                    fontSize: isLarge ? 16.sp : 14.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            Text(
              context.formatCurrency(amount),
              style: context.typography.h2.copyWith(
                fontSize: isLarge ? 28.sp : 20.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    final recentTransactions = _transactions.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Row(
          children: [
            Text(
              'Recent Transactions',
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                showToast(
                  context: context,
                  builder: (context, overlay) => context.buildToast(
                    title: 'View All',
                    message: 'Full transaction history coming soon',
                  ),
                );
              },
              child: const Text('View All'),
            ),
          ],
        ),
        if (recentTransactions.isEmpty)
          Card(
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
                      'No transactions yet',
                      style: context.typography.p.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          ...recentTransactions.map(_buildTransactionCard),
      ],
    );
  }

  Widget _buildTransactionCard(Transaction transaction) {
    final isIncome =
        transaction.type == TransactionType.TOPUP ||
        transaction.type == TransactionType.REFUND;
    final color = isIncome ? material.Colors.green : material.Colors.red;
    final icon = _getTransactionIcon(transaction.type);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.dg),
        child: Row(
          spacing: 12.w,
          children: [
            Container(
              padding: EdgeInsets.all(8.dg),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20.sp, color: color),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Text(
                    _getTransactionTypeText(transaction.type),
                    style: context.typography.h4.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (transaction.description != null)
                    Text(
                      transaction.description!,
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  Text(
                    DateFormat(
                      'MMM dd, yyyy HH:mm',
                    ).format(transaction.createdAt),
                    style: context.typography.small.copyWith(
                      fontSize: 11.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${isIncome ? "+" : "-"}${context.formatCurrency(transaction.amount)}',
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

  Widget _buildWithdrawButton() {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        onPressed: (_wallet?.balance ?? 0) > 0 ? _showWithdrawDialog : null,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [Icon(LucideIcons.banknote), Text('Withdraw Earnings')],
        ),
      ),
    );
  }

  void _showWithdrawDialog() {
    showToast(
      context: context,
      builder: (context, overlay) => context.buildToast(
        title: 'Withdraw',
        message: 'Withdrawal feature coming soon',
      ),
    );
  }

  IconData _getTransactionIcon(TransactionType type) {
    switch (type) {
      case TransactionType.TOPUP:
        return LucideIcons.arrowDownToLine;
      case TransactionType.WITHDRAW:
        return LucideIcons.arrowUpFromLine;
      case TransactionType.PAYMENT:
        return LucideIcons.shoppingCart;
      case TransactionType.REFUND:
        return LucideIcons.undo2;
      case TransactionType.ADJUSTMENT:
        return LucideIcons.settings;
    }
  }

  String _getTransactionTypeText(TransactionType type) {
    switch (type) {
      case TransactionType.TOPUP:
        return 'Top Up';
      case TransactionType.WITHDRAW:
        return 'Withdrawal';
      case TransactionType.PAYMENT:
        return 'Payment';
      case TransactionType.REFUND:
        return 'Refund';
      case TransactionType.ADJUSTMENT:
        return 'Adjustment';
    }
  }
}
