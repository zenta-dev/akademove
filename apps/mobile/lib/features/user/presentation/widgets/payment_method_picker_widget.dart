import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PaymentMethodPickerWidget extends StatelessWidget {
  const PaymentMethodPickerWidget({
    required this.value,
    required this.bankProvider,
    required this.onChanged,
    required this.totalCost,
    required this.walletBalance,
    super.key,
  });
  final PaymentMethod value;
  final BankProvider? bankProvider;
  final void Function(PaymentMethod val, {BankProvider? bankProvider})
  onChanged;
  final double totalCost;
  final double walletBalance;

  bool get iswalletSufficient => walletBalance >= totalCost;

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: EdgeInsets.all(8.dg),
      child: Column(
        spacing: 8.h,
        children: [
          OutlineButton(
            onPressed: iswalletSufficient
                ? () {
                    onChanged(PaymentMethod.wallet, bankProvider: null);
                  }
                : null,
            child: Row(
              spacing: 8.w,
              children: [
                Icon(LucideIcons.walletMinimal, size: 16.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DefaultText('wallet'),
                    DefaultText(
                      'Balance: ${context.formatCurrency(walletBalance)}',
                      fontSize: 12.sp,
                      color: iswalletSufficient
                          ? context.colorScheme.primary
                          : context.colorScheme.destructive,
                    ),
                  ],
                ),
                const Spacer(),
                if (iswalletSufficient)
                  ChecklistIndicatorWidget(
                    isSelected: value == PaymentMethod.wallet,
                  )
                else
                  Button(
                    style:
                        const ButtonStyle.outline(
                          density: ButtonDensity.dense,
                        ).copyWith(
                          decoration: (context, states, value) =>
                              value.copyWithIfBoxDecoration(
                                border: Border.all(
                                  color: context.colorScheme.destructive,
                                ),
                              ),
                        ),
                    child: DefaultText(
                      'Top Up',
                      fontSize: 12.sp,
                      color: context.colorScheme.destructive,
                    ),
                    onPressed: () {
                      context.pushNamed(Routes.userWalletTopUp.name);
                    },
                  ),
              ],
            ),
          ),
          OutlineButton(
            onPressed: () {
              onChanged(PaymentMethod.QRIS, bankProvider: null);
            },
            child: Row(
              spacing: 8.w,
              children: [
                Icon(LucideIcons.qrCode, size: 16.sp),
                const DefaultText('QRIS'),
                const Spacer(),
                ChecklistIndicatorWidget(
                  isSelected: value == PaymentMethod.QRIS,
                ),
              ],
            ),
          ),
          OutlineButton(
            onPressed: () async {
              await selectBankProvider(context);
            },
            child: Row(
              spacing: 8.w,
              children: [
                Icon(LucideIcons.arrowUpDown, size: 16.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DefaultText('Bank Transfer'),
                    Builder(
                      builder: (context) {
                        final provider = bankProvider;
                        if (provider == null) return const SizedBox.shrink();

                        return DefaultText(
                          provider.value,
                          fontSize: 12.sp,
                          color: context.colorScheme.mutedForeground,
                        );
                      },
                    ),
                  ],
                ),
                const Spacer(),
                ChecklistIndicatorWidget(
                  isSelected: value == PaymentMethod.BANK_TRANSFER,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectBankProvider(BuildContext context) async {
    await openSheet<BankProvider>(
      context: context,
      position: OverlayPosition.bottom,
      builder: (context) {
        return BankProviderSelectorWidget(
          onSelected: (provider) {
            onChanged(PaymentMethod.BANK_TRANSFER, bankProvider: provider);
          },
        );
      },
    );
  }
}
