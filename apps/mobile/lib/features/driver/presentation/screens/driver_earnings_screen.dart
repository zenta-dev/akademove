import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
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
    } on BaseError catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        context.showMyToast(
          e.message ?? context.l10n.failed_to_load_earnings,
          type: ToastType.failed,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        context.showMyToast(
          context.l10n.failed_to_load_earnings,
          type: ToastType.failed,
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
          title: Text(context.l10n.earnings_wallet),
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
          : RefreshTrigger(
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
                  context.l10n.available_balance,
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
                    ? const Color(0xFF4CAF50).withValues(alpha: 0.1)
                    : context.colorScheme.mutedForeground.withValues(
                        alpha: 0.1,
                      ),
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: wallet.isActive
                      ? const Color(0xFF4CAF50)
                      : context.colorScheme.mutedForeground,
                ),
              ),
              child: Text(
                wallet.isActive ? context.l10n.active : context.l10n.inactive,
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: wallet.isActive
                      ? const Color(0xFF4CAF50)
                      : context.colorScheme.mutedForeground,
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
                context.l10n.total_income,
                summary.totalIncome,
                LucideIcons.trendingUp,
                const Color(0xFF4CAF50),
              ),
            ),
            Expanded(
              child: _buildSummaryCard(
                context.l10n.total_expenses,
                summary.totalExpense,
                LucideIcons.trendingDown,
                const Color(0xFFF44336),
              ),
            ),
          ],
        ),
        _buildSummaryCard(
          context.l10n.net_earnings,
          summary.net,
          LucideIcons.dollarSign,
          summary.net >= 0
              ? context.colorScheme.primary
              : const Color(0xFFF44336),
          isLarge: true,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String label,
    num amount,
    IconData icon,
    Color color, {
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
              context.l10n.recent_transactions,
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
              child: Text(context.l10n.view_all),
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
                      context.l10n.no_transactions_yet,
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
    final color = isIncome ? const Color(0xFF4CAF50) : const Color(0xFFF44336);
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
                    _getTransactionTypeText(context, transaction.type),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            const Icon(LucideIcons.banknote),
            Text(context.l10n.withdraw_earnings),
          ],
        ),
      ),
    );
  }

  void _showWithdrawDialog() {
    final amountController = TextEditingController();
    final accountNumberController = TextEditingController();
    final accountNameController = TextEditingController();
    BankProvider selectedBank = BankProvider.BCA;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(context.l10n.withdraw_earnings),
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
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: context.colorScheme.primary),
                  ),
                  child: Row(
                    spacing: 8.w,
                    children: [
                      Icon(
                        LucideIcons.info,
                        size: 20.sp,
                        color: context.colorScheme.primary,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4.h,
                          children: [
                            Text(
                              context.l10n.available_balance,
                              style: context.typography.small.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: context.colorScheme.primary,
                              ),
                            ),
                            Text(
                              context.formatCurrency(_wallet?.balance ?? 0),
                              style: context.typography.h3.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Amount field
                TextField(
                  controller: amountController,
                  placeholder: Text(context.l10n.enter_withdrawal_amount),
                ),
                // Bank provider dropdown
                Select<BankProvider>(
                  value: selectedBank,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedBank = value);
                    }
                  },
                  placeholder: Text(context.l10n.select_bank),
                  itemBuilder: (context, item) => Text(item.name),
                  popupConstraints: const BoxConstraints(
                    maxHeight: 300,
                    maxWidth: 300,
                  ),
                  popup: SelectPopup(
                    items: SelectItemList(
                      children: [
                        for (final bank in BankProvider.values)
                          SelectItemButton(value: bank, child: Text(bank.name)),
                      ],
                    ),
                  ).call,
                ),
                // Account number field
                TextField(
                  controller: accountNumberController,
                  placeholder: Text(context.l10n.hint_bank_account_number),
                ),
                TextField(
                  controller: accountNameController,
                  placeholder: Text(context.l10n.hint_account_name),
                ),
              ],
            ),
          ),
          actions: [
            OutlineButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(context.l10n.cancel),
            ),
            PrimaryButton(
              onPressed: () async {
                final amountText = amountController.text.trim();
                final accountNumber = accountNumberController.text.trim();
                final accountName = accountNameController.text.trim();

                // Validate amount
                if (amountText.isEmpty) {
                  if (mounted) {
                    context.showMyToast(
                      context.l10n.enter_withdrawal_amount,
                      type: ToastType.failed,
                    );
                  }
                  return;
                }

                final amount = num.tryParse(amountText);
                if (amount == null || amount <= 0) {
                  if (mounted) {
                    context.showMyToast(
                      context.l10n.invalid_amount,
                      type: ToastType.failed,
                    );
                  }
                  return;
                }

                final balance = _wallet?.balance ?? 0;
                if (amount > balance) {
                  if (mounted) {
                    context.showMyToast(
                      context.l10n.insufficient_balance,
                      type: ToastType.failed,
                    );
                  }
                  return;
                }

                // Validate account number
                if (accountNumber.isEmpty) {
                  if (mounted) {
                    context.showMyToast(
                      context.l10n.please_enter_bank_account_number,
                      type: ToastType.failed,
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
              child: Text(context.l10n.withdraw),
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
        context.showMyToast(result.message, type: ToastType.success);
        // Reload data to reflect new balance
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        context.showMyToast(
          context.l10n.failed_to_withdraw,
          type: ToastType.failed,
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

  String _getTransactionTypeText(BuildContext context, TransactionType type) {
    switch (type) {
      case TransactionType.TOPUP:
        return context.l10n.top_up;
      case TransactionType.WITHDRAW:
        return context.l10n.withdrawal;
      case TransactionType.PAYMENT:
        return context.l10n.payment;
      case TransactionType.REFUND:
        return context.l10n.refund;
      case TransactionType.ADJUSTMENT:
        return context.l10n.adjustment;
      case TransactionType.COMMISSION:
        return context.l10n.commission;
      case TransactionType.EARNING:
        return context.l10n.earning;
    }
  }

  void _showAllTransactionsDialog(List<Transaction> transactions) {
    openDrawer(
      context: context,
      position: OverlayPosition.bottom,
      builder: (drawerContext) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: context.colorScheme.border,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Transactions',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.x),
                    onPressed: () => closeDrawer(drawerContext),
                    variance: ButtonVariance.ghost,
                  ),
                ],
              ),
            ),
            if (transactions.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.receipt, size: 64.sp),
                      SizedBox(height: 16.h),
                      Text(
                        'No transactions found',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  itemCount: transactions.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    final isIncome =
                        transaction.type == TransactionType.TOPUP ||
                        transaction.type == TransactionType.REFUND ||
                        transaction.type == TransactionType.EARNING;
                    final amountColor = isIncome
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFF44336);
                    final amountPrefix = isIncome ? '+' : '-';

                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(12.dg),
                        child: Row(
                          spacing: 12.w,
                          children: [
                            Container(
                              width: 40.sp,
                              height: 40.sp,
                              decoration: BoxDecoration(
                                color: amountColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  _getTransactionIcon(transaction.type),
                                  color: amountColor,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getTransactionTypeText(
                                      context,
                                      transaction.type,
                                    ),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  if (transaction.description != null)
                                    Text(
                                      transaction.description!,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color:
                                            context.colorScheme.mutedForeground,
                                      ),
                                    ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    DateFormat(
                                      'MMM dd, yyyy HH:mm',
                                    ).format(transaction.createdAt),
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color:
                                          context.colorScheme.mutedForeground,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '$amountPrefix${context.formatCurrency(transaction.amount)}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: amountColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
