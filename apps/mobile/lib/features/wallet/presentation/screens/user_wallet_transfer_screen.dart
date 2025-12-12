import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
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
  late TextEditingController phoneController;
  late TextEditingController userIdController;
  late TextEditingController amountController;
  late TextEditingController noteController;
  int amount = 0;
  bool useUserId = false;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    userIdController = TextEditingController();
    amountController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    userIdController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  bool _canTransfer(UserWalletTransferState state) {
    if (amount < 1000) return false;
    if (useUserId) {
      return userIdController.text.trim().isNotEmpty;
    } else {
      return state.selectedRecipient != null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        DefaultAppBar(
          title: context.l10n.transfer,
          trailing: [
            IconButton(
              variance: const ButtonStyle.ghost(),
              icon: const Icon(LucideIcons.scanLine),
              onPressed: () => _handleScanQr(context),
            ),
          ],
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: BlocConsumer<UserWalletTransferCubit, UserWalletTransferState>(
            listener: (context, state) {
              if (state.transfer.isSuccess) {
                context.showMyToast(
                  context.l10n.transfer_success,
                  type: ToastType.success,
                );
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
              final isLookupLoading = state.recipientLookup.isLoading;
              final selectedRecipient = state.selectedRecipient;

              return Column(
                spacing: 16.h,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Recipient Section
                  if (!useUserId) ...[
                    _buildPhoneInput(context, state, isLookupLoading),
                    if (selectedRecipient != null)
                      _buildRecipientPreview(context, selectedRecipient),
                    if (state.recipientLookup.isSuccess &&
                        selectedRecipient == null &&
                        phoneController.text.trim().isNotEmpty)
                      _buildRecipientNotFound(context),
                  ] else ...[
                    _buildUserIdInput(context, isLoading),
                  ],

                  // Toggle between phone and user ID
                  _buildToggleInputMode(context),

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
                  _buildAmountInput(context, isLoading),

                  // Note Input (optional)
                  _buildNoteInput(context, isLoading),

                  // Transfer button
                  SizedBox(
                    width: double.infinity,
                    child: Button.primary(
                      enabled: !isLoading,
                      onPressed: _canTransfer(state) && !isLoading
                          ? () => _handleTransfer(context, state)
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
        ),
      ),
    );
  }

  Widget _buildPhoneInput(
    BuildContext context,
    UserWalletTransferState state,
    bool isLookupLoading,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Label(
          child: DefaultText(context.l10n.recipient_phone, fontSize: 14.sp),
        ),
        Row(
          spacing: 8.w,
          children: [
            Expanded(
              child: TextField(
                controller: phoneController,
                enabled: !isLookupLoading,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.search,
                placeholder: Text(context.l10n.enter_recipient_phone),
                onSubmitted: (_) => _lookupRecipient(context),
                onChanged: (_) {
                  context.read<UserWalletTransferCubit>().clearRecipient();
                  setState(() {});
                },
                features: [
                  InputFeature.clear(
                    icon: IconButton(
                      density: ButtonDensity.compact,
                      onPressed: phoneController.text.isEmpty
                          ? null
                          : () {
                              phoneController.clear();
                              context
                                  .read<UserWalletTransferCubit>()
                                  .clearRecipient();
                              setState(() {});
                            },
                      icon: const Icon(LucideIcons.x),
                      variance: phoneController.text.isEmpty
                          ? const ButtonStyle.ghost()
                          : const ButtonStyle.textIcon(),
                    ),
                  ),
                ],
              ),
            ),
            Button.secondary(
              enabled:
                  !isLookupLoading && phoneController.text.trim().isNotEmpty,
              onPressed: () => _lookupRecipient(context),
              child: isLookupLoading
                  ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : DefaultText(context.l10n.lookup_recipient),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecipientPreview(
    BuildContext context,
    UserLookupResult recipient,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          UserAvatarWidget(
            name: recipient.name,
            image: recipient.image,
            size: 40.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  recipient.name,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
                if (recipient.phone != null)
                  DefaultText(
                    '${recipient.phone!.countryCode} ${recipient.phone!.maskedNumber}',
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
              ],
            ),
          ),
          Icon(
            LucideIcons.circleCheck,
            color: context.colorScheme.primary,
            size: 20.w,
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientNotFound(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.destructive.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: context.colorScheme.destructive.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            LucideIcons.userX,
            color: context.colorScheme.destructive,
            size: 20.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: DefaultText(
              context.l10n.recipient_not_found,
              fontSize: 13.sp,
              color: context.colorScheme.destructive,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserIdInput(BuildContext context, bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Label(
          child: DefaultText(context.l10n.recipient_user_id, fontSize: 14.sp),
        ),
        TextField(
          controller: userIdController,
          enabled: !isLoading,
          textInputAction: TextInputAction.next,
          placeholder: Text(context.l10n.enter_recipient_user_id),
          features: [
            InputFeature.clear(
              icon: IconButton(
                density: ButtonDensity.compact,
                onPressed: userIdController.text.isEmpty
                    ? null
                    : () {
                        userIdController.clear();
                        setState(() {});
                      },
                icon: const Icon(LucideIcons.x),
                variance: userIdController.text.isEmpty
                    ? const ButtonStyle.ghost()
                    : const ButtonStyle.textIcon(),
              ),
            ),
          ],
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }

  Widget _buildToggleInputMode(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          useUserId = !useUserId;
        });
        context.read<UserWalletTransferCubit>().clearRecipient();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4.w,
        children: [
          Icon(
            useUserId ? LucideIcons.phone : LucideIcons.hash,
            size: 14.w,
            color: context.colorScheme.primary,
          ),
          DefaultText(
            useUserId
                ? context.l10n.recipient_phone
                : context.l10n.use_user_id_instead,
            fontSize: 13.sp,
            color: context.colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput(BuildContext context, bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Label(child: DefaultText(context.l10n.amount, fontSize: 14.sp)),
        TextField(
          controller: amountController,
          enabled: !isLoading,
          onChanged: (value) {
            final parsed = int.tryParse(value, radix: 10);
            setState(() {
              amount = parsed ?? 0;
            });
          },
          keyboardType: const TextInputType.numberWithOptions(signed: true),
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
    );
  }

  Widget _buildNoteInput(BuildContext context, bool isLoading) {
    return Column(
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
    );
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

  void _lookupRecipient(BuildContext context) {
    final phone = phoneController.text.trim();
    if (phone.isEmpty) return;
    context.read<UserWalletTransferCubit>().lookupRecipient(phone);
  }

  Future<void> _handleScanQr(BuildContext context) async {
    final result = await context.push<UserLookupResult>(
      Routes.userWalletTransferScan.path,
    );
    if (result != null && context.mounted) {
      context.read<UserWalletTransferCubit>().setRecipientFromQr(result);
      setState(() {
        useUserId = false;
      });
    }
  }

  Future<void> _handleTransfer(
    BuildContext context,
    UserWalletTransferState state,
  ) async {
    final String recipientUserId;
    final String recipientDisplay;

    if (useUserId) {
      recipientUserId = userIdController.text.trim();
      recipientDisplay = recipientUserId;
    } else {
      final recipient = state.selectedRecipient;
      if (recipient == null) return;
      recipientUserId = recipient.id;
      recipientDisplay = recipient.name;
    }

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

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: DefaultText(context.l10n.confirm_transfer),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            DefaultText(
              '${context.l10n.recipient}: $recipientDisplay',
              fontSize: 14.sp,
            ),
            DefaultText(
              '${context.l10n.amount}: ${context.formatCurrency(amount)}',
              fontSize: 14.sp,
            ),
            if (note.isNotEmpty)
              DefaultText('${context.l10n.note}: $note', fontSize: 14.sp),
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
}
