import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantWalletWithdrawScreen extends StatefulWidget {
  const MerchantWalletWithdrawScreen({super.key});

  @override
  State<MerchantWalletWithdrawScreen> createState() =>
      _MerchantWalletWithdrawScreenState();
}

class _MerchantWalletWithdrawScreenState
    extends State<MerchantWalletWithdrawScreen> {
  final _amountController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();
  BankProvider _selectedBank = BankProvider.BCA;
  bool _isLoadingSavedBank = true;
  bool _isValidating = false;
  bool _isValidated = false;
  bool _saveBank = false;
  bool _isWithdrawing = false;

  String? get _merchantId {
    final merchantState = context.read<MerchantCubit>().state;
    return merchantState.mine.value?.id;
  }

  @override
  void initState() {
    super.initState();
    _loadSavedBankAccount();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedBankAccount() async {
    final merchantId = _merchantId;
    if (merchantId == null) {
      setState(() => _isLoadingSavedBank = false);
      return;
    }

    try {
      final cubit = context.read<MerchantWalletCubit>();
      final result = await cubit.getSavedBankAccount(merchantId);
      final savedBank = result.data;
      if (savedBank.hasSavedBank && mounted) {
        setState(() {
          if (savedBank.bankProvider != null) {
            _selectedBank = savedBank.bankProvider!;
          }
          if (savedBank.accountNumber != null) {
            _accountNumberController.text = savedBank.accountNumber!;
          }
          if (savedBank.accountName != null) {
            _accountNameController.text = savedBank.accountName!;
            _isValidated = true;
          }
        });
      }
    } catch (e, stackTrace) {
      // Log error but allow user to enter bank details manually
      logger.w(
        '[MerchantWalletWithdrawScreen] Failed to load saved bank account',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoadingSavedBank = false);
      }
    }
  }

  Future<void> _validateBankAccount() async {
    final accountNumber = _accountNumberController.text.trim();
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

    setState(() => _isValidating = true);

    try {
      final cubit = context.read<MerchantWalletCubit>();
      final result = await cubit.validateBankAccount(
        bankProvider: _selectedBank,
        accountNumber: accountNumber,
      );

      if (result.data.isValid && result.data.accountName != null) {
        setState(() {
          _accountNameController.text = result.data.accountName!;
          _isValidated = true;
          _isValidating = false;
        });
        if (mounted) {
          context.showMyToast(
            context.l10n.toast_bank_account_verified,
            type: ToastType.success,
          );
        }
      } else {
        setState(() => _isValidating = false);
        if (mounted) {
          context.showMyToast(
            context.l10n.toast_failed_verify_bank,
            type: ToastType.failed,
          );
        }
      }
    } catch (e) {
      setState(() => _isValidating = false);
      if (mounted) {
        context.showMyToast(
          context.l10n.toast_failed_verify_bank,
          type: ToastType.failed,
        );
      }
    }
  }

  Future<void> _processWithdrawal() async {
    final merchantId = _merchantId;
    if (merchantId == null) {
      context.showMyToast("Merchant not found", type: ToastType.failed);
      return;
    }

    final amountText = _amountController.text.trim();
    final accountNumber = _accountNumberController.text.trim();
    final accountName = _accountNameController.text.trim();

    if (amountText.isEmpty) {
      context.showMyToast(
        context.l10n.enter_withdrawal_amount,
        type: ToastType.failed,
      );
      return;
    }

    final amount = num.tryParse(amountText);
    if (amount == null || amount <= 0) {
      context.showMyToast(context.l10n.invalid_amount, type: ToastType.failed);
      return;
    }

    final wallet = context.read<MerchantWalletCubit>().state.wallet.value;
    final balance = wallet?.balance ?? 0;
    if (amount > balance) {
      context.showMyToast(
        context.l10n.insufficient_balance,
        type: ToastType.failed,
      );
      return;
    }

    if (accountNumber.isEmpty) {
      context.showMyToast(
        context.l10n.please_enter_bank_account_number,
        type: ToastType.failed,
      );
      return;
    }

    setState(() => _isWithdrawing = true);

    try {
      final request = WithdrawRequest(
        amount: amount,
        bankProvider: _selectedBank,
        accountNumber: accountNumber,
        accountName: accountName.isEmpty ? null : accountName,
        saveBank: _saveBank,
      );

      final cubit = context.read<MerchantWalletCubit>();
      final result = await cubit.withdraw(
        merchantId: merchantId,
        request: request,
      );

      if (mounted) {
        setState(() => _isWithdrawing = false);
        context.showMyToast(result.message, type: ToastType.success);
        await cubit.init(merchantId);
        if (mounted) {
          context.pop();
        }
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

  Future<void> _onRefresh() async {
    final merchantId = _merchantId;
    if (merchantId != null) {
      await context.read<MerchantWalletCubit>().init(merchantId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          title: Text(
            context.l10n.withdraw,
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          leading: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
        ),
      ],
      child: SafeRefreshTrigger(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.dg),
            child: BlocBuilder<MerchantWalletCubit, MerchantWalletState>(
              builder: (context, state) {
                final wallet = state.wallet.value;
                final isLoading = state.wallet.isLoading || _isLoadingSavedBank;

                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  spacing: 16.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Balance info card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.dg),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: context.colorScheme.primary),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.h,
                        children: [
                          Row(
                            spacing: 8.w,
                            children: [
                              Icon(
                                LucideIcons.wallet,
                                size: 20.sp,
                                color: context.colorScheme.primary,
                              ),
                              Text(
                                context.l10n.available_balance,
                                style: context.typography.small.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            context.formatCurrency(wallet?.balance ?? 0),
                            style: context.typography.h2.copyWith(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Amount input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.h,
                      children: [
                        Text(
                          context.l10n.amount,
                          style: context.typography.small.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          controller: _amountController,
                          placeholder: Text(
                            context.l10n.enter_withdrawal_amount,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),

                    // Bank selection
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.h,
                      children: [
                        Text(
                          context.l10n.select_bank,
                          style: context.typography.small.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Select<BankProvider>(
                          value: _selectedBank,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedBank = value;
                                _isValidated = false;
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
                      ],
                    ),

                    // Account number input with validation
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.h,
                      children: [
                        Text(
                          context.l10n.bank_account,
                          style: context.typography.small.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          spacing: 8.w,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _accountNumberController,
                                placeholder: Text(
                                  context.l10n.hint_bank_account_number,
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (_) {
                                  if (_isValidated) {
                                    setState(() => _isValidated = false);
                                  }
                                },
                              ),
                            ),
                            Button(
                              onPressed:
                                  _isValidating ||
                                      _isValidated ||
                                      _accountNumberController.text
                                              .trim()
                                              .length <
                                          5
                                  ? null
                                  : _validateBankAccount,
                              style: _isValidated
                                  ? ButtonStyle.outline(
                                      density: ButtonDensity.compact,
                                    )
                                  : ButtonStyle.secondary(
                                      density: ButtonDensity.compact,
                                    ),
                              child: _isValidating
                                  ? SizedBox(
                                      width: 16.sp,
                                      height: 16.sp,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : _isValidated
                                  ? Icon(
                                      LucideIcons.check,
                                      size: 16.sp,
                                      color: const Color(0xFF4CAF50),
                                    )
                                  : Text(context.l10n.confirm),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Account name input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.h,
                      children: [
                        Text(
                          context.l10n.account_name,
                          style: context.typography.small.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          controller: _accountNameController,
                          placeholder: Text(context.l10n.hint_account_name),
                          readOnly: _isValidated,
                        ),
                        if (_isValidated &&
                            _accountNameController.text.isNotEmpty)
                          Text(
                            _accountNameController.text,
                            style: context.typography.small.copyWith(
                              fontSize: 12.sp,
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                      ],
                    ),

                    // Save bank checkbox
                    Row(
                      spacing: 8.w,
                      children: [
                        Checkbox(
                          state: _saveBank
                              ? CheckboxState.checked
                              : CheckboxState.unchecked,
                          onChanged: (state) {
                            setState(
                              () => _saveBank = state == CheckboxState.checked,
                            );
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _saveBank = !_saveBank),
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

                    Gap(16.h),

                    // Withdraw button
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        onPressed: _isWithdrawing || _isValidating
                            ? null
                            : _processWithdrawal,
                        child: _isWithdrawing
                            ? SizedBox(
                                width: 20.sp,
                                height: 20.sp,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 8.w,
                                children: [
                                  const Icon(LucideIcons.banknote),
                                  Text(context.l10n.withdraw),
                                ],
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
