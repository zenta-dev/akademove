import 'package:akademove/app/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserRidePayQrisScreen extends StatelessWidget {
  const UserRidePayQrisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: const [DefaultAppBar(title: 'Ride Payment')],
      body: Column(
        spacing: 8.h,
        children: [
          const Text('Total Fare'),
          BlocBuilder<UserOrderCubit, UserOrderState>(
            builder: (context, state) {
              return Text(
                    context.formatCurrency(
                      state.placeOrderResult?.payment.amount ?? dummyAmount,
                    ),
                  )
                  .large(color: context.colorScheme.primary)
                  .asSkeleton(enabled: state.isLoading);
            },
          ),
          BlocConsumer<UserOrderCubit, UserOrderState>(
            listener: (context, state) {
              if (state.isSuccess &&
                  state.placeOrderResult?.payment.status ==
                      TransactionStatus.success) {
                context
                  ..pop()
                  ..pop()
                  ..pushReplacementNamed(Routes.userRidePayOnTrip.name);
              }
            },
            builder: (context, state) {
              return QRISPaymentWidget(
                payment: state.placeOrderResult?.payment ?? dummyPayment,
                transactionType: TransactionType.payment,
                onExpired: () {
                  context.pop();
                },
              ).asSkeleton(enabled: state.isLoading);
            },
          ),
        ],
      ),
    );
  }
}
