import 'dart:async';

import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserRidePaymentScreen extends StatelessWidget {
  const UserRidePaymentScreen({
    required this.paymentMethod,
    this.bankProvider,
    super.key,
  });
  final PaymentMethod paymentMethod;
  final BankProvider? bankProvider;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [DefaultAppBar(title: context.l10n.title_ride_payment)],
      body: Column(
        spacing: 8.h,
        children: [
          Text(context.l10n.label_total_fare),
          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              return Text(
                    context.formatCurrency(
                      state.currentPayment?.amount ?? dummyAmount,
                    ),
                  )
                  .large(color: context.colorScheme.primary)
                  .asSkeleton(enabled: state.isLoading);
            },
          ),
          BlocConsumer<UserOrderCubit, UserOrderState>(
            listener: (context, state) {
              final payment = state.currentPayment;
              if (payment == null) return;

              if (state.isSuccess &&
                  payment.status == TransactionStatus.SUCCESS) {
                context
                  ..showMyToast(
                    context.l10n.text_payment_successful,
                    type: ToastType.success,
                  )
                  ..pushReplacementNamed(Routes.userRideOnTrip.name);
              } else if (state.isFailure ||
                  payment.status == TransactionStatus.FAILED) {
                context.showMyToast(
                  context.l10n.text_payment_failed,
                  type: ToastType.failed,
                );
              }
            },
            builder: (context, state) {
              if (paymentMethod == PaymentMethod.QRIS) {
                return QRISPaymentWidget(
                  payment: state.currentPayment ?? dummyPayment,
                  transactionType: TransactionType.PAYMENT,
                  onExpired: () {
                    context.pop();
                  },
                ).asSkeleton(enabled: state.isLoading);
              }
              if (paymentMethod == PaymentMethod.BANK_TRANSFER) {
                return BankTransferPaymentWidget(
                  payment: state.currentPayment ?? dummyPayment,
                  bankProvider: bankProvider,
                  onExpired: () {
                    context.pop();
                  },
                ).asSkeleton(enabled: state.isLoading);
              }
              return Alert.destructive(
                title: Text(context.l10n.text_unsupported_payment_method),
                content: Text(
                  context.l10n.text_unsupported_payment_method_description,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BankTransferPaymentWidget extends StatelessWidget {
  const BankTransferPaymentWidget({
    required this.onExpired,
    required this.payment,
    super.key,
    this.bankProvider,
  });
  final Payment payment;
  final BankProvider? bankProvider;
  final VoidCallback onExpired;

  Future<void> _copyVaNumber(BuildContext context, VANumber? vaNumber) async {
    if (vaNumber == null || vaNumber.vaNumber.isEmpty) {
      context.showMyToast(
        context.l10n.toast_va_number_not_available,
        type: ToastType.failed,
      );
      return;
    }

    await Clipboard.setData(ClipboardData(text: vaNumber.vaNumber));

    if (context.mounted) {
      context.showMyToast(
        context.l10n.toast_va_number_copied,
        type: ToastType.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final expiresAt = payment.expiresAt ?? DateTime.now();
    final dateStr = expiresAt.format('d MMM yyyy, HH:mm');
    final width = 0.9.sw.round();

    final prov = payment.vaNumber?.bank != null
        ? BankProvider.values.firstWhere(
            (e) =>
                e.value.toLowerCase() == payment.vaNumber?.bank.toLowerCase(),
          )
        : bankProvider;

    final dict = prov != null
        ? bankProviderDicts.firstWhere((e) => e.provider == prov)
        : null;

    return Column(
      spacing: 16.h,
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            padding: EdgeInsets.all(8.dg),
            child: Column(
              spacing: 8.h,
              children: [
                if (dict != null) ...[
                  Row(
                    spacing: 8.w,
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        context.l10n.text_provider_label,
                      ).muted(fontSize: 14.sp),
                      SizedBox(
                        width: 24.sp,
                        height: 24.sp,
                        child: dict.icon.svg(width: 24.sp, height: 24.sp),
                      ),
                      DefaultText(
                        dict.provider.value,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
                Text(context.l10n.text_va_number_label).muted(fontSize: 14.sp),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    payment.vaNumber?.vaNumber.format(4) ?? 'N/A',
                    style: context.typography.small.copyWith(
                      letterSpacing: 2.w,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          width: double.infinity,
          child: Card(
            padding: EdgeInsets.all(8.dg),
            child: Column(
              spacing: 8.h,
              children: [
                Text(
                  context.l10n.text_valid_until_with_date(dateStr),
                ).muted(fontSize: 14.sp),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4.w,
                  children: [
                    Text(
                      context.l10n.label_remaining_time,
                    ).muted(fontSize: 14.sp),
                    TimeTickerWidget(
                      expiresAt: expiresAt,
                      onExpired: onExpired,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: width.toDouble(),
          child: Button.primary(
            onPressed: () => _copyVaNumber(context, payment.vaNumber),
            child: Row(
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.copy, size: 16.sp),
                Text(context.l10n.button_copy_va_number).small,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
