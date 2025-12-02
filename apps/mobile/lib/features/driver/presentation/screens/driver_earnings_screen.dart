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
                    Builder(
                      builder: (context) {
                        final wallet = _wallet;
                        if (wallet == null) return const SizedBox.shrink();
                        return _buildWalletBalanceCard(wallet);
                      },
                    ),
                    if (_monthlySummary != null) _buildMonthSelector(),
                    Builder(
                      builder: (context) {
                        final summary = _monthlySummary;
                        if (summary == null) return const SizedBox.shrink();
                        return _buildEarningsSummary(summary);
                      },
                    ),
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
                _showAllTransactionsDialog(recentTransactions);
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
                  Builder(
                    builder: (context) {
                      final description = transaction.description;
                      if (description == null) return const SizedBox.shrink();

                      return Text(
                        description,
                        style: context.typography.small.copyWith(
                          fontSize: 12.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
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
    final amountController = TextEditingController();
    final accountNumberController = TextEditingController();
    final accountNameController = TextEditingController();
    BankProvider selectedBank = BankProvider.BCA;

    material.showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => material.AlertDialog(
          title: const Text('Withdraw Earnings'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.h,
              children: [
                // Available balance info
                Container(
                  padding: EdgeInsets.all(12.dg),
                  decoration: BoxDecoration(
                    color: material.Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: material.Colors.blue),
                  ),
                  child: Row(
                    spacing: 8.w,
                    children: [
                      Icon(
                        LucideIcons.info,
                        size: 20.sp,
                        color: material.Colors.blue,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4.h,
                          children: [
                            Text(
                              'Available Balance',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: material.Colors.blue,
                              ),
                            ),
                            Text(
                              context.formatCurrency(_wallet?.balance ?? 0),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: material.Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Amount field
                material.TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: material.InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Enter withdrawal amount',
                    border: const material.OutlineInputBorder(),
                    prefixText: 'Rp ',
                  ),
                ),
                // Bank provider dropdown
                material.DropdownButtonFormField<BankProvider>(
                  initialValue: selectedBank,
                  decoration: const material.InputDecoration(
                    labelText: 'Bank',
                    border: material.OutlineInputBorder(),
                  ),
                  items: BankProvider.values.map((bank) {
                    return material.DropdownMenuItem(
                      value: bank,
                      child: Text(bank.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedBank = value);
                    }
                  },
                ),
                // Account number field
                material.TextField(
                  controller: accountNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const material.InputDecoration(
                    labelText: 'Account Number',
                    hintText: 'Enter your account number',
                    border: material.OutlineInputBorder(),
                  ),
                ),
                // Account name field (optional)
                material.TextField(
                  controller: accountNameController,
                  decoration: const material.InputDecoration(
                    labelText: 'Account Name (Optional)',
                    hintText: 'Enter account holder name',
                    border: material.OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            material.TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            material.TextButton(
              onPressed: () async {
                final amountText = amountController.text.trim();
                final accountNumber = accountNumberController.text.trim();
                final accountName = accountNameController.text.trim();

                // Validate amount
                if (amountText.isEmpty) {
                  if (mounted) {
                    showToast(
                      context: context,
                      builder: (context, overlay) => context.buildToast(
                        title: 'Error',
                        message: 'Please enter withdrawal amount',
                      ),
                    );
                  }
                  return;
                }

                final amount = num.tryParse(amountText);
                if (amount == null || amount <= 0) {
                  if (mounted) {
                    showToast(
                      context: context,
                      builder: (context, overlay) => context.buildToast(
                        title: 'Error',
                        message: 'Please enter a valid amount',
                      ),
                    );
                  }
                  return;
                }

                final balance = _wallet?.balance ?? 0;
                if (amount > balance) {
                  if (mounted) {
                    showToast(
                      context: context,
                      builder: (context, overlay) => context.buildToast(
                        title: 'Error',
                        message: 'Insufficient balance',
                      ),
                    );
                  }
                  return;
                }

                // Validate account number
                if (accountNumber.isEmpty) {
                  if (mounted) {
                    showToast(
                      context: context,
                      builder: (context, overlay) => context.buildToast(
                        title: 'Error',
                        message: 'Please enter account number',
                      ),
                    );
                  }
                  return;
                }

                Navigator.of(dialogContext).pop();
                await _processWithdrawal(
                  amount: amount,
                  bankProvider: selectedBank,
                  accountNumber: accountNumber,
                  accountName: accountName.isEmpty ? null : accountName,
                );
              },
              child: const Text('Withdraw'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processWithdrawal({
    required num amount,
    required BankProvider bankProvider,
    required String accountNumber,
    String? accountName,
  }) async {
    try {
      setState(() => _isLoading = true);

      final request = WithdrawRequest(
        amount: amount,
        bankProvider: bankProvider,
        accountNumber: accountNumber,
        accountName: accountName,
      );

      final result = await context.read<WalletRepository>().withdraw(request);

      if (mounted) {
        setState(() => _isLoading = false);
        showToast(
          context: context,
          builder: (context, overlay) =>
              context.buildToast(title: 'Success', message: result.message),
        );
        // Reload data to reflect new balance
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Error',
            message: 'Failed to withdraw: ${e.toString()}',
          ),
        );
      }
    }
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
      case TransactionType.COMMISSION:
        return LucideIcons.percent;
      case TransactionType.EARNING:
        return LucideIcons.coins;
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
      case TransactionType.COMMISSION:
        return 'Commission';
      case TransactionType.EARNING:
        return 'Earning';
    }
  }

  void _showAllTransactionsDialog(List<Transaction> transactions) {
    material.showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) => material.DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => material.Container(
          decoration: material.BoxDecoration(
            color: material.Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const material.BorderRadius.only(
              topLeft: material.Radius.circular(16),
              topRight: material.Radius.circular(16),
            ),
          ),
          child: material.Column(
            children: [
              material.Container(
                padding: material.EdgeInsets.all(16.w),
                decoration: material.BoxDecoration(
                  border: material.Border(
                    bottom: material.BorderSide(
                      color: material.Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
                child: material.Row(
                  mainAxisAlignment: material.MainAxisAlignment.spaceBetween,
                  children: [
                    material.Text(
                      'All Transactions',
                      style: material.TextStyle(
                        fontSize: 18.sp,
                        fontWeight: material.FontWeight.bold,
                      ),
                    ),
                    material.IconButton(
                      icon: const material.Icon(material.Icons.close),
                      onPressed: () =>
                          material.Navigator.of(bottomSheetContext).pop(),
                    ),
                  ],
                ),
              ),
              if (transactions.isEmpty)
                material.Expanded(
                  child: material.Center(
                    child: material.Column(
                      mainAxisAlignment: material.MainAxisAlignment.center,
                      children: [
                        material.Icon(
                          material.Icons.receipt_long,
                          size: 64.sp,
                          color: material.Colors.grey,
                        ),
                        material.SizedBox(height: 16.h),
                        material.Text(
                          'No transactions found',
                          style: material.TextStyle(
                            fontSize: 16.sp,
                            color: material.Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                material.Expanded(
                  child: material.ListView.separated(
                    controller: scrollController,
                    padding: material.EdgeInsets.all(16.w),
                    itemCount: transactions.length,
                    separatorBuilder: (context, index) =>
                        material.SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      final isIncome =
                          transaction.type == TransactionType.TOPUP ||
                          transaction.type == TransactionType.REFUND ||
                          transaction.type == TransactionType.EARNING;
                      final amountColor = isIncome
                          ? material.Colors.green
                          : material.Colors.red;
                      final amountPrefix = isIncome ? '+' : '-';

                      return material.Card(
                        child: material.ListTile(
                          leading: material.CircleAvatar(
                            backgroundColor: amountColor.withValues(alpha: 0.1),
                            child: material.Icon(
                              _getTransactionIcon(transaction.type),
                              color: amountColor,
                              size: 20.sp,
                            ),
                          ),
                          title: material.Text(
                            _getTransactionTypeText(transaction.type),
                            style: material.TextStyle(
                              fontSize: 14.sp,
                              fontWeight: material.FontWeight.w600,
                            ),
                          ),
                          subtitle: material.Column(
                            crossAxisAlignment:
                                material.CrossAxisAlignment.start,
                            children: [
                              material.SizedBox(height: 4.h),
                              if (transaction.description != null)
                                material.Text(
                                  transaction.description!,
                                  style: material.TextStyle(
                                    fontSize: 12.sp,
                                    color: material.Colors.grey,
                                  ),
                                ),
                              material.SizedBox(height: 4.h),
                              material.Text(
                                DateFormat(
                                  'MMM dd, yyyy HH:mm',
                                ).format(transaction.createdAt),
                                style: material.TextStyle(
                                  fontSize: 11.sp,
                                  color: material.Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          trailing: Builder(
                            builder: (context) => material.Text(
                              '$amountPrefix${context.formatCurrency(transaction.amount)}',
                              style: material.TextStyle(
                                fontSize: 16.sp,
                                fontWeight: material.FontWeight.bold,
                                color: amountColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
