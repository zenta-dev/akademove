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

class DriverEarningsScreen extends StatefulWidget {
  const DriverEarningsScreen({super.key});

  @override
  State<DriverEarningsScreen> createState() => _DriverEarningsScreenState();
}

class _DriverEarningsScreenState extends State<DriverEarningsScreen> {
  DateTime _selectedMonth = DateTime.now();
  bool _isWithdrawing = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await context.read<DriverEarningsCubit>().init(
      month: _selectedMonth.month,
      year: _selectedMonth.year,
    );
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
    await context.read<DriverEarningsCubit>().getMonthlySummary(
      month: _selectedMonth.month,
      year: _selectedMonth.year,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverEarningsCubit, DriverEarningsState>(
      builder: (context, state) {
        final isLoading = state.fetchWalletResult.isLoading;
        final wallet = state.wallet;
        final transactions = state.transactions;
        final monthlySummary = state.monthlySummary;

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
          body: isLoading && wallet == null
              ? const Center(child: CircularProgressIndicator())
              : RefreshTrigger(
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.dg),
                    child: Column(
                      spacing: 16.h,
                      children: [
                        if (wallet != null) _buildWalletBalanceCard(wallet),
                        if (monthlySummary != null) _buildMonthSelector(),
                        if (monthlySummary is WalletMonthlySummaryResponse)
                          _buildEarningsSummary(monthlySummary),
                        _buildCommissionReportSection(transactions),
                        _buildRecentTransactions(transactions),
                        _buildWithdrawButton(wallet),
                      ],
                    ),
                  ),
                ),
        );
      },
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
    final monthFormat = DateFormat("MMMM yyyy");

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

  Widget _buildCommissionReportSection(List<Transaction> transactions) {
    return GestureDetector(
      onTap: () => context.push(Routes.driverCommissionReport.path),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Row(
                spacing: 8.w,
                children: [
                  Icon(
                    LucideIcons.percent,
                    size: 20.sp,
                    color: context.colorScheme.primary,
                  ),
                  Expanded(
                    child: Text(
                      context.l10n.commission_report,
                      style: context.typography.h3.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    LucideIcons.chevronRight,
                    size: 20.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ],
              ),
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    child: _buildCommissionStatCard(
                      context.l10n.commission,
                      _calculateTotalCommission(transactions),
                      LucideIcons.trendingDown,
                      const Color(0xFFF44336),
                    ),
                  ),
                  Expanded(
                    child: _buildCommissionStatCard(
                      context.l10n.label_platform_commission,
                      20, // Default commission rate
                      LucideIcons.percent,
                      context.colorScheme.primary,
                      isPercentage: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommissionStatCard(
    String label,
    num value,
    IconData icon,
    Color color, {
    bool isPercentage = false,
  }) {
    return Container(
      padding: EdgeInsets.all(12.dg),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        spacing: 8.h,
        children: [
          Icon(icon, color: color, size: 20.sp),
          Text(
            label,
            style: context.typography.small.copyWith(
              color: context.colorScheme.mutedForeground,
            ),
          ),
          Text(
            isPercentage ? "$value%" : context.formatCurrency(value),
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  num _calculateTotalCommission(List<Transaction> transactions) {
    return transactions
        .where((t) => t.type == TransactionType.COMMISSION)
        .fold<num>(0, (sum, t) => sum + t.amount);
  }

  Widget _buildRecentTransactions(List<Transaction> transactions) {
    final recentTransactions = transactions.take(5).toList();

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
                _showAllTransactionsDialog(transactions);
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
                      "MMM dd, yyyy HH:mm",
                    ).format(transaction.createdAt.toLocal()),
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

  Widget _buildWithdrawButton(Wallet? wallet) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        onPressed: (wallet?.balance ?? 0) > 0
            ? () => _showWithdrawDialog(wallet)
            : null,
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

  void _showWithdrawDialog(Wallet? wallet) {
    final amountController = TextEditingController();
    final accountNumberController = TextEditingController();
    final accountNameController = TextEditingController();
    BankProvider selectedBank = BankProvider.BCA;
    var isLoadingSavedBank = true;
    var isValidating = false;
    var isValidated = false;
    var saveBank = false;

    final cubit = context.read<DriverEarningsCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          if (isLoadingSavedBank) {
            isLoadingSavedBank = false;
            cubit
                .getSavedBankAccount()
                .then((result) {
                  final savedBank = result.data;
                  if (savedBank.hasSavedBank) {
                    setState(() {
                      if (savedBank.bankProvider != null) {
                        selectedBank = savedBank.bankProvider!;
                      }
                      if (savedBank.accountNumber != null) {
                        accountNumberController.text = savedBank.accountNumber!;
                      }
                      if (savedBank.accountName != null) {
                        accountNameController.text = savedBank.accountName!;
                        isValidated = true;
                      }
                    });
                  }
                })
                .catchError((_) {});
          }

          Future<void> validateBankAccount() async {
            final accountNumber = accountNumberController.text.trim();
            if (accountNumber.isEmpty) {
              context.showMyToast(
                context.l10n.toast_enter_bank_account,
                type: ToastType.failed,
              );
              return;
            }
            if (accountNumber.length < 5) {
              context.showMyToast(
                context.l10n.toast_bank_account_min_digits,
                type: ToastType.failed,
              );
              return;
            }

            setState(() => isValidating = true);

            try {
              final result = await cubit.validateBankAccount(
                bankProvider: selectedBank,
                accountNumber: accountNumber,
              );

              if (result.data.isValid && result.data.accountName != null) {
                setState(() {
                  accountNameController.text = result.data.accountName!;
                  isValidated = true;
                  isValidating = false;
                });
                if (mounted) {
                  context.showMyToast(
                    context.l10n.toast_bank_account_verified,
                    type: ToastType.success,
                  );
                }
              } else {
                setState(() => isValidating = false);
                if (mounted) {
                  context.showMyToast(
                    context.l10n.toast_failed_verify_bank,
                    type: ToastType.failed,
                  );
                }
              }
            } catch (e) {
              setState(() => isValidating = false);
              if (mounted) {
                context.showMyToast(
                  context.l10n.toast_failed_verify_bank,
                  type: ToastType.failed,
                );
              }
            }
          }

          return AlertDialog(
            title: Text(context.l10n.withdraw_earnings),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16.h,
                children: [
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
                                context.formatCurrency(wallet?.balance ?? 0),
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
                  TextField(
                    controller: amountController,
                    placeholder: Text(context.l10n.enter_withdrawal_amount),
                  ),
                  Select<BankProvider>(
                    value: selectedBank,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedBank = value;
                          isValidated = false;
                        });
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
                            SelectItemButton(
                              value: bank,
                              child: Text(bank.name),
                            ),
                        ],
                      ),
                    ).call,
                  ),
                  Row(
                    spacing: 8.w,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: accountNumberController,
                          placeholder: Text(
                            context.l10n.hint_bank_account_number,
                          ),
                          onChanged: (_) {
                            if (isValidated) {
                              setState(() => isValidated = false);
                            }
                          },
                        ),
                      ),
                      Button(
                        onPressed:
                            isValidating ||
                                isValidated ||
                                accountNumberController.text.trim().length < 5
                            ? null
                            : validateBankAccount,
                        style: isValidated
                            ? ButtonStyle.outline(
                                density: ButtonDensity.compact,
                              )
                            : ButtonStyle.secondary(
                                density: ButtonDensity.compact,
                              ),
                        child: isValidating
                            ? SizedBox(
                                width: 16.sp,
                                height: 16.sp,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : isValidated
                            ? Icon(
                                LucideIcons.check,
                                size: 16.sp,
                                color: const Color(0xFF4CAF50),
                              )
                            : Text(context.l10n.confirm),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      TextField(
                        controller: accountNameController,
                        placeholder: Text(context.l10n.hint_account_name),
                        readOnly: isValidated,
                      ),
                      if (isValidated && accountNameController.text.isNotEmpty)
                        Text(
                          accountNameController.text,
                          style: context.typography.small.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    spacing: 8.w,
                    children: [
                      Checkbox(
                        state: saveBank
                            ? CheckboxState.checked
                            : CheckboxState.unchecked,
                        onChanged: (state) {
                          setState(
                            () => saveBank = state == CheckboxState.checked,
                          );
                        },
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => saveBank = !saveBank),
                          child: Text(
                            context.l10n.withdraw_wallet_save_bank,
                            style: context.typography.small.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                onPressed: isValidating
                    ? null
                    : () async {
                        final amountText = amountController.text.trim();
                        final accountNumber = accountNumberController.text
                            .trim();
                        final accountName = accountNameController.text.trim();

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

                        final balance = wallet?.balance ?? 0;
                        if (amount > balance) {
                          if (mounted) {
                            context.showMyToast(
                              context.l10n.insufficient_balance,
                              type: ToastType.failed,
                            );
                          }
                          return;
                        }

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
                          saveBank: saveBank,
                        );
                      },
                child: Text(context.l10n.withdraw),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _processWithdrawal({
    required num amount,
    required BankProvider bankProvider,
    required String accountNumber,
    String? accountName,
    bool saveBank = false,
  }) async {
    try {
      setState(() => _isWithdrawing = true);

      final request = WithdrawRequest(
        amount: amount,
        bankProvider: bankProvider,
        accountNumber: accountNumber,
        accountName: accountName,
      );

      final result = await context.read<DriverEarningsCubit>().withdraw(
        request,
      );

      if (mounted) {
        setState(() => _isWithdrawing = false);
        context.showMyToast(result.message, type: ToastType.success);
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isWithdrawing = false);
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
                    "All Transactions",
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
                        "No transactions found",
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
                    final amountPrefix = isIncome ? "+" : "-";

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
                                      "MMM dd, yyyy HH:mm",
                                    ).format(transaction.createdAt.toLocal()),
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
                              "$amountPrefix${context.formatCurrency(transaction.amount)}",
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
