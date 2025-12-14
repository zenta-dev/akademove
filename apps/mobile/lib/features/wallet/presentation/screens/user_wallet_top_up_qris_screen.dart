import 'dart:async';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserWalletTopUpQRISScreen extends StatelessWidget {
  const UserWalletTopUpQRISScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.top_up_qris)],
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
                    // Teardown websocket immediately, don't wait for delay
                    context.read<UserWalletTopUpCubit>().teardownWebsocket();
                    // Refresh the main wallet cubit to show updated balance
                    context.read<UserWalletCubit>().getMine();
                    // Wait before navigating to let user see the success message
                    await Future.delayed(const Duration(seconds: 3), () {
                      if (!context.mounted) return;
                      context
                        ..pop(true)
                        ..pop(true)
                        ..pop(true);
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
                  return QRISPaymentWidget(
                    payment: state.payment.value ?? dummyPayment,
                    transactionType: TransactionType.TOPUP,
                    onExpired: () async {
                      context.showMyToast(
                        context.l10n.qr_code_expired,
                        type: ToastType.failed,
                      );
                      // Teardown websocket immediately, don't wait for delay
                      context.read<UserWalletTopUpCubit>().teardownWebsocket();
                      await Future.delayed(const Duration(seconds: 3), () {
                        if (!context.mounted) return;
                        context.pop(true);
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
