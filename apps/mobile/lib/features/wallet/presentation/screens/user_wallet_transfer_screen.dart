import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserWalletTransferScreen extends StatefulWidget {
  const UserWalletTransferScreen({super.key});

  @override
  State<UserWalletTransferScreen> createState() =>
      _UserWalletTransferScreenState();
}

class _UserWalletTransferScreenState extends State<UserWalletTransferScreen> {
  late TextEditingController recipientController;
  late TextEditingController amountController;
  late TextEditingController noteController;
  int amount = 0;

  @override
  void initState() {
    super.initState();
    recipientController = TextEditingController();
    amountController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    recipientController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [DefaultAppBar(title: context.l10n.transfer)],
      body: BlocConsumer<UserWalletTransferCubit, UserWalletTransferState>(
        listener: (context, state) {
          if (state.transfer.isSuccess) {
            context.showMyToast(
              context.l10n.transfer_success,
              type: ToastType.success,
            );
            // Refresh wallet balance
            context.read<UserWalletCubit>().getMine();
            context.pop(true);
          } else if (state.transfer.isFailed) {
            context.showMyToast(
              state.transfer.error?.message ?? context.l10n.transfer_failed,
              type: ToastType.failed,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.transfer.isLoading;
          return Column(
            spacing: 16.h,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Recipient User ID Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Label(
                    child: DefaultText(
                      context.l10n.recipient_user_id,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextField(
                    controller: recipientController,
                    enabled: !isLoading,
                    textInputAction: TextInputAction.next,
                    placeholder: Text(context.l10n.enter_recipient_user_id),
                    features: [
                      InputFeature.clear(
                        icon: IconButton(
                          density: ButtonDensity.compact,
                          onPressed: recipientController.text.isEmpty
                              ? null
                              : () {
                                  recipientController.clear();
                                  setState(() {});
                                },
                          icon: const Icon(LucideIcons.x),
                          variance: recipientController.text.isEmpty
                              ? const ButtonStyle.ghost()
                              : const ButtonStyle.textIcon(),
                        ),
                      ),
                    ],
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              ),
              // Amount quick templates
              Row(
                spacing: 16.w,
                children: [_buildTemplate(10000), _buildTemplate(20000)],
              ),
              Row(
                spacing: 16.w,
                children: [_buildTemplate(50000), _buildTemplate(100000)],
              ),
              // Amount Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Label(
                    child: DefaultText(context.l10n.amount, fontSize: 14.sp),
                  ),
                  TextField(
                    controller: amountController,
                    enabled: !isLoading,
                    onChanged: (value) {
                      final parsed = int.tryParse(value, radix: 10);
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
                    textInputAction: TextInputAction.next,
                    placeholder: Text(context.l10n.enter_amount),
                    features: [
                      InputFeature.clear(
                        icon: IconButton(
                          density: ButtonDensity.compact,
                          onPressed: amountController.text.isEmpty
                              ? null
                              : () {
                                  amountController.clear();
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
              // Note Input (optional)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Label(
                    child: DefaultText(
                      '${context.l10n.note} (${context.l10n.optional})',
                      fontSize: 14.sp,
                    ),
                  ),
                  TextField(
                    controller: noteController,
                    enabled: !isLoading,
                    textInputAction: TextInputAction.done,
                    placeholder: Text(context.l10n.enter_note),
                    maxLines: 2,
                  ),
                ],
              ),
              const Spacer(),
              // Transfer button
              SizedBox(
                width: double.infinity,
                child: Button.primary(
                  enabled: !isLoading,
                  onPressed: _canTransfer() && !isLoading
                      ? () => _handleTransfer(context)
                      : null,
                  child: isLoading
                      ? const Submiting()
                      : DefaultText(context.l10n.transfer),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool _canTransfer() {
    return recipientController.text.trim().isNotEmpty && amount >= 1000;
  }

  Future<void> _handleTransfer(BuildContext context) async {
    final recipientUserId = recipientController.text.trim();
    final note = noteController.text.trim();

    if (recipientUserId.isEmpty) {
      context.showMyToast(
        context.l10n.error_recipient_required,
        type: ToastType.failed,
      );
      return;
    }

    if (amount < 1000) {
      context.showMyToast(
        context.l10n.error_transfer_minimum,
        type: ToastType.failed,
      );
      return;
    }

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: DefaultText(context.l10n.confirm_transfer),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              '${context.l10n.recipient}: $recipientUserId',
              fontSize: 14.sp,
            ),
            SizedBox(height: 8.h),
            DefaultText(
              '${context.l10n.amount}: ${context.formatCurrency(amount)}',
              fontSize: 14.sp,
            ),
            if (note.isNotEmpty) ...[
              SizedBox(height: 8.h),
              DefaultText('${context.l10n.note} $note', fontSize: 14.sp),
            ],
          ],
        ),
        actions: [
          Button.outline(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: DefaultText(context.l10n.cancel),
          ),
          Button.primary(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: DefaultText(context.l10n.confirm),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await context.read<UserWalletTransferCubit>().transfer(
        recipientUserId: recipientUserId,
        amount: amount,
        note: note.isEmpty ? null : note,
      );
    }
  }

  String _formatPrice(int amount) {
    if (amount >= 1000000) {
      final juta = amount / 1000000;
      return 'Rp ${juta.toStringAsFixed(juta % 1 == 0 ? 0 : 1)} juta';
    } else if (amount >= 1000) {
      final ribu = amount / 1000;
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
        child: DefaultText(_formatPrice(val)),
      ),
    );
  }
}
