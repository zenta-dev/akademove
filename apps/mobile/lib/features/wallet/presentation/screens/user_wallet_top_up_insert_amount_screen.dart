import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserWalletTopUpInsertAmountScreen extends StatefulWidget {
  const UserWalletTopUpInsertAmountScreen({required this.method, super.key});

  final TopUpRequestMethodEnum method;

  @override
  State<UserWalletTopUpInsertAmountScreen> createState() =>
      _UserWalletTopUpInsertAmountScreenState();
}

class _UserWalletTopUpInsertAmountScreenState
    extends State<UserWalletTopUpInsertAmountScreen> {
  late TextEditingController amountController;
  int amount = 0;
  BankProvider? selectedBankProvider;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  bool get _isBankTransfer =>
      widget.method == TopUpRequestMethodEnum.BANK_TRANSFER;

  bool get _canSubmit {
    if (amount <= 0) return false;
    if (_isBankTransfer && selectedBankProvider == null) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        DefaultAppBar(
          title: _isBankTransfer
              ? context.l10n.payment_method_bank_transfer
              : context.l10n.top_up_qris,
        ),
      ],
      body: Column(
        spacing: 16.h,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 16.w,
            children: [_buildTemplate(10_000), _buildTemplate(20_000)],
          ),
          Row(
            spacing: 16.w,
            children: [_buildTemplate(50_000), _buildTemplate(100_000)],
          ),
          Row(
            spacing: 16.w,
            children: [_buildTemplate(500_000), _buildTemplate(1_000_000)],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Label(child: DefaultText(context.l10n.amount, fontSize: 14.sp)),
              TextField(
                controller: amountController,
                onChanged: (value) {
                  final parsed = int.tryParse(value, radix: 10);
                  amountController.text = '$parsed';
                  setState(() {
                    if (parsed != null) {
                      amount = parsed;
                    } else {
                      amount = 0;
                    }
                  });
                },
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                textInputAction: TextInputAction.done,
                features: [
                  InputFeature.clear(
                    icon: IconButton(
                      density: ButtonDensity.compact,
                      onPressed: amountController.text.isEmpty
                          ? null
                          : () {
                              amountController.text = '';
                              setState(() {
                                amount = 0;
                              });
                            },
                      icon: const Icon(LucideIcons.x),
                      variance: amountController.text.isEmpty
                          ? const ButtonStyle.ghost()
                          : const ButtonStyle.textIcon(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (_isBankTransfer) _buildBankProviderSelector(context),
          BlocBuilder<UserWalletTopUpCubit, UserWalletTopUpState>(
            builder: (context, state) {
              final isLoading = state.payment.isLoading;
              return SizedBox(
                width: double.infinity,
                child: Button.primary(
                  enabled: !isLoading,
                  onPressed: !_canSubmit || isLoading
                      ? null
                      : () async {
                          final parsed = int.tryParse(
                            amountController.text,
                            radix: 10,
                          );
                          setState(() {
                            if (parsed != null) {
                              amount = parsed;
                            } else {
                              amount = 0;
                            }
                          });
                          if (parsed == null || amount < 10_000) {
                            context.showMyToast(
                              context.l10n.error_top_up_minimum,
                              type: ToastType.failed,
                            );
                            return;
                          }

                          context.read<UserWalletTopUpCubit>().reset();
                          await context.read<UserWalletTopUpCubit>().topUp(
                            parsed,
                            widget.method,
                            bankProvider: selectedBankProvider,
                          );

                          if (mounted && context.mounted) {
                            switch (widget.method) {
                              case TopUpRequestMethodEnum.QRIS:
                                await context.pushNamed(
                                  Routes.userWalletTopUpQRIS.name,
                                );
                              case TopUpRequestMethodEnum.BANK_TRANSFER:
                                await context.pushNamed(
                                  Routes.userWalletTopUpBankTransfer.name,
                                );
                            }
                          }
                        },
                  child: isLoading
                      ? const Submiting()
                      : DefaultText(context.l10n.next),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBankProviderSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Label(child: DefaultText(context.l10n.bank_provider, fontSize: 14.sp)),
        OutlineButton(
          onPressed: () async {
            await openSheet<BankProvider>(
              context: context,
              position: OverlayPosition.bottom,
              builder: (context) {
                return BankProviderSelectorWidget(
                  onSelected: (provider) {
                    setState(() {
                      selectedBankProvider = provider;
                    });
                  },
                );
              },
            );
          },
          child: Row(
            children: [
              if (selectedBankProvider != null) ...[
                Builder(
                  builder: (context) {
                    final bankDict = bankProviderDicts.firstWhere(
                      (e) => e.provider == selectedBankProvider,
                      orElse: () => bankProviderDicts.first,
                    );
                    return Row(
                      spacing: 8.w,
                      children: [
                        SizedBox(
                          width: 24.sp,
                          height: 24.sp,
                          child: bankDict.icon.svg(width: 24.sp, height: 24.sp),
                        ),
                        DefaultText(selectedBankProvider!.value),
                      ],
                    );
                  },
                ),
              ] else
                DefaultText(
                  context.l10n.placeholder_select_bank_provider,
                  color: context.colorScheme.mutedForeground,
                ),
              const Spacer(),
              Icon(LucideIcons.chevronDown, size: 16.sp),
            ],
          ),
        ),
      ],
    );
  }

  String formatPrice(int amount) {
    if (amount >= 1_000_000) {
      final juta = amount / 1_000_000;
      return 'Rp ${juta.toStringAsFixed(juta % 1 == 0 ? 0 : 1)} juta';
    } else if (amount >= 1_000) {
      final ribu = amount / 1_000;
      return 'Rp ${ribu.toStringAsFixed(ribu % 1 == 0 ? 0 : 1)} ribu';
    } else {
      return 'Rp $amount';
    }
  }

  Widget _buildTemplate(int val) {
    return Expanded(
      child: Button(
        style: const ButtonStyle.secondary(density: ButtonDensity.comfortable),
        onPressed: () {
          amountController.text = '$val';
          setState(() {
            amount = val;
          });
        },
        child: DefaultText(formatPrice(val)),
      ),
    );
  }
}
