import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
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
                      state.currentPayment.value?.amount ?? dummyAmount,
                    ),
                  )
                  .large(color: context.colorScheme.primary)
                  .asSkeleton(enabled: state.currentOrder.isLoading);
            },
          ),
          BlocConsumer<UserOrderCubit, UserOrderState>(
            listener: (context, state) {
              final payment = state.currentPayment.value;
              if (payment == null) return;

              if (state.currentPayment.isSuccess &&
                  payment.status == TransactionStatus.SUCCESS) {
                context
                  ..showMyToast(
                    context.l10n.text_payment_successful,
                    type: ToastType.success,
                  )
                  ..pushReplacementNamed(Routes.userRideOnTrip.name);
              } else if (state.currentOrder.isFailure ||
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
                  payment: state.currentPayment.value ?? dummyPayment,
                  transactionType: TransactionType.PAYMENT,
                  onExpired: () {
                    context.pop();
                  },
                ).asSkeleton(enabled: state.currentOrder.isLoading);
              }
              if (paymentMethod == PaymentMethod.BANK_TRANSFER) {
                return BankTransferPaymentWidget(
                  payment: state.currentPayment.value ?? dummyPayment,
                  bankProvider: bankProvider,
                  onExpired: () {
                    context.pop();
                  },
                ).asSkeleton(enabled: state.currentOrder.isLoading);
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
