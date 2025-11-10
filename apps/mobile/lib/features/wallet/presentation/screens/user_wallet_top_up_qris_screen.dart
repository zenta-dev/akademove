import 'dart:async';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
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
                      TransactionStatus.success) {
                context.showMyToast(
                  'Top up success',
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
                  state.error?.message ?? 'Payment expired',
                  type: ToastType.failed,
                );
              }
            },
            builder: (context, state) {
              return QRISPaymentWidget(
                payment: state.paymentResult ?? dummyPayment,
                transactionType: TransactionType.topup,
                onExpired: () async {
                  context.showMyToast(
                    'This QR code has expired. Please generate a new one.',
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
                    const DefaultText('Total'),
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
