import 'dart:async';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserWalletTopUpBankTransferScreen extends StatelessWidget {
  const UserWalletTopUpBankTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.top_up)],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: Column(
            spacing: 16.h,
            children: [
              BlocConsumer<UserWalletTopUpCubit, UserWalletTopUpState>(
                listener: (context, state) async {
                  final transaction = state.transaction.value;
                  final wallet = state.wallet.value;

                  // Check for success via WebSocket (transaction available)
                  // OR via polling fallback (wallet updated without transaction)
                  final isSuccessViaWebSocket =
                      state.payment.isSuccess &&
                      transaction != null &&
                      transaction.status == TransactionStatus.SUCCESS;
                  final isSuccessViaPolling =
                      state.payment.isSuccess &&
                      wallet != null &&
                      transaction == null;

                  if (isSuccessViaWebSocket || isSuccessViaPolling) {
                    context.showMyToast(
                      context.l10n.top_up_success,
                      type: ToastType.success,
                    );
                    // Refresh the main wallet cubit to show updated balance
                    context.read<UserWalletCubit>().getMine();
                    await Future.delayed(const Duration(seconds: 3), () {
                      if (!context.mounted) return;
                      context.read<UserWalletTopUpCubit>().teardownWebsocket();
                      context
                        ..pop()
                        ..pop()
                        ..pop();
                    });
                  }
                  if (state.payment.isFailure && context.mounted) {
                    context.showMyToast(
                      state.payment.error?.message ??
                          context.l10n.payment_expired,
                      type: ToastType.failed,
                    );
                  }
                },
                builder: (context, state) {
                  return BankTransferPaymentWidget(
                    payment: state.payment.value ?? dummyPayment,
                    onExpired: () async {
                      context.showMyToast(
                        context.l10n.payment_expired,
                        type: ToastType.failed,
                      );
                      await Future.delayed(const Duration(seconds: 3), () {
                        if (!context.mounted) return;
                        context
                            .read<UserWalletTopUpCubit>()
                            .teardownWebsocket();
                        context.pop();
                      });
                    },
                  ).asSkeleton(enabled: state.payment.isLoading);
                },
              ),
              Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultText(context.l10n.total),
                        BlocBuilder<UserWalletTopUpCubit, UserWalletTopUpState>(
                          builder: (context, state) {
                            return DefaultText(
                              'Rp ${state.payment.value?.amount ?? 50_000}',
                            ).asSkeleton(enabled: state.payment.isLoading);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
