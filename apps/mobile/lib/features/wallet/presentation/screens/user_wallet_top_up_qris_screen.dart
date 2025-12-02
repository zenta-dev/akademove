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
    return MyScaffold(
      headers: const [DefaultAppBar(title: 'Top Up QRIS')],
      body: Column(
        spacing: 16.h,
        children: [
          BlocConsumer<UserWalletTopUpCubit, UserWalletTopUpState>(
            listener: (context, state) async {
              if (state.isSuccess &&
                  state.transactionResult != null &&
                  state.transactionResult?.status ==
                      TransactionStatus.SUCCESS) {
                context.showMyToast(
                  context.l10n.top_up_success,
                  type: ToastType.success,
                );
                await Future.delayed(const Duration(seconds: 3), () {
                  if (!context.mounted) return;
                  context.read<UserWalletTopUpCubit>().teardownWebsocket();
                  context
                    ..pop()
                    ..pop()
                    ..pop();
                });
              }
              if (state.isFailure && context.mounted) {
                context.showMyToast(
                  state.error?.message ?? context.l10n.payment_expired,
                  type: ToastType.failed,
                );
              }
            },
            builder: (context, state) {
              return QRISPaymentWidget(
                payment: state.paymentResult ?? dummyPayment,
                transactionType: TransactionType.TOPUP,
                onExpired: () async {
                  context.showMyToast(
                    context.l10n.qr_code_expired,
                    type: ToastType.failed,
                  );
                  await Future.delayed(const Duration(seconds: 3), () {
                    if (!context.mounted) return;
                    context.read<UserWalletTopUpCubit>().teardownWebsocket();
                    context.pop();
                  });
                },
              ).asSkeleton(enabled: state.isLoading);
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
                          'Rp ${state.paymentResult?.amount ?? 50_000}',
                        ).asSkeleton(enabled: state.isLoading);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
