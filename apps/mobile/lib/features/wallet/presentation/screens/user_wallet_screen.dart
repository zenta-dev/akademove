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

class UserWalletScreen extends StatelessWidget {
  const UserWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scrollable: true,
      headers: [
        AppBar(
          title: Text(
            context.l10n.e_wallet,
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          leading: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
          trailing: [
            IconButton(
              icon: const Icon(LucideIcons.bell),
              variance: ButtonVariance.ghost,
              onPressed: () {
                context.pushNamed(Routes.userNotifications.name);
              },
            ),
            // BlocBuilder<AuthCubit, AuthState>(
            //   builder: (context, state) {
            //     return IconButton(
            //       icon: UserAvatarWidget(
            //         name: state.user.data?.value.name ?? AppConstants.name,
            //         image: state.user.data?.value.image,
            //       ),
            //       variance: ButtonVariance.ghost,
            //       onPressed: () {
            //         context.popUntilRoot();
            //         context.read<BottomNavBarCubit>().setIndex(2);
            //         context.pushNamed(Routes.userProfile.name);
            //       },
            //     ).asSkeleton(enabled: state.user.isLoading);
            //   },
            // ),
          ],
        ),
      ],
      onRefresh: () async {
        context.read<UserWalletCubit>().getMine();
      },
      body: Column(
        spacing: 16.h,
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              return BlocBuilder<UserWalletCubit, UserWalletState>(
                builder: (context, state) {
                  return WalletBalanceCardWidget(
                    balance: (state.myWallet.value?.balance ?? 0).toDouble(),
                    userId: authState.user.data?.value.id,
                  ).asSkeleton(enabled: state.myWallet.isLoading);
                },
              );
            },
          ),
          Card(
            padding: EdgeInsets.all(8.dg),
            child: Column(
              spacing: 8.h,
              children: [
                // BlocBuilder<UserWalletCubit, UserWalletState>(
                //   builder: (context, state) {
                //     return WalletMonthlySummaryCardWidget(
                //       summary:
                //           state.thisMonthSummary.value ?? dummyWalletSummary,
                //     ).asSkeleton(enabled: state.myWallet.isLoading);
                //   },
                // ),
                // const Divider(),
                SizedBox(
                  height: context.mediaQuerySize.height * 0.4,
                  child: BlocBuilder<UserWalletCubit, UserWalletState>(
                    builder: (context, state) {
                      return WalletListTransactionWidget(
                        transactions: state.myWallet.isLoading
                            ? List.generate(10, (_) => dummyTransaction)
                            : state.myTransactions.value ?? [],
                      ).asSkeleton(enabled: state.myWallet.isLoading);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WalletBalanceCardWidget extends StatelessWidget {
  const WalletBalanceCardWidget({
    required this.balance,
    this.userId,
    super.key,
  });
  final double balance;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        spacing: 8.h,
        children: [
          if (userId != null)
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: userId!));
                context.showMyToast(
                  context.l10n.copied_to_clipboard,
                  type: ToastType.success,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6.w,
                  children: [
                    Icon(
                      LucideIcons.fingerprint,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                    Text(
                      '${context.l10n.label_user_id}: ${userId!.length > 8 ? '${userId!.substring(0, 8)}...' : userId!}',
                      style: context.typography.small.copyWith(
                        fontSize: 11.sp,
                        color: Colors.white,
                      ),
                    ),
                    Icon(LucideIcons.copy, size: 12.sp, color: Colors.white),
                  ],
                ),
              ),
            ),
          DefaultText(
            context.l10n.available_balance,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          DefaultText(
            context.formatCurrency(balance),
            fontSize: 24.sp,
            color: Colors.white,
          ),
          Button(
            style: const ButtonStyle.primary().copyWith(
              decoration: (context, states, value) =>
                  value.copyWithIfBoxDecoration(color: Colors.white),
            ),
            onPressed: () {
              context.read<UserWalletTopUpCubit>().reset();
              context.pushNamed(Routes.userWalletTopUp.name);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.w,
              children: [
                const Icon(LucideIcons.plus, color: Colors.black),
                Text(
                  context.l10n.top_up,
                  // color: Colors.black,
                  style: context.typography.small.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          Gap(8.h),
          Button(
            style: const ButtonStyle.outline().copyWith(
              decoration: (context, states, value) =>
                  value.copyWithIfBoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white),
                  ),
            ),
            onPressed: () {
              context.pushNamed(Routes.userWalletTransfer.name);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.w,
              children: [
                const Icon(LucideIcons.send, color: Colors.white),
                Text(
                  context.l10n.transfer,
                  style: context.typography.small.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Gap(8.h),
          Button(
            style: const ButtonStyle.outline().copyWith(
              decoration: (context, states, value) =>
                  value.copyWithIfBoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white),
                  ),
            ),
            onPressed: () {
              context.pushNamed(Routes.userWalletWithdraw.name);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.w,
              children: [
                const Icon(LucideIcons.banknote, color: Colors.white),
                Text(
                  context.l10n.withdraw,
                  style: context.typography.small.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Gap(8.h),
          Button(
            style: const ButtonStyle.outline().copyWith(
              decoration: (context, states, value) =>
                  value.copyWithIfBoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white),
                  ),
            ),
            onPressed: () {
              context.pushNamed(Routes.userWalletMyQr.name);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.w,
              children: [
                const Icon(LucideIcons.qrCode, color: Colors.white),
                Text(
                  context.l10n.my_qr_code,
                  style: context.typography.small.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WalletMonthlySummaryCardWidget extends StatelessWidget {
  const WalletMonthlySummaryCardWidget({required this.summary, super.key});
  final WalletMonthlySummaryResponse summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      children: [
        _buildContainer(
          context,
          context.l10n.expenses,
          summary.totalExpense.toDouble(),
        ),
        _buildContainer(
          context,
          context.l10n.income,
          summary.totalIncome.toDouble(),
        ),
      ],
    );
  }

  Widget _buildContainer(BuildContext context, String title, double amount) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        spacing: 8.h,
        children: [
          Row(
            spacing: 4.w,
            children: [
              const Icon(LucideIcons.coins),
              DefaultText(title, fontSize: 12.sp, fontWeight: FontWeight.w600),
            ],
          ),
          DefaultText(context.formatCurrency(amount), fontSize: 20.sp),
          DefaultText(context.l10n.this_month, fontSize: 12.sp),
        ],
      ),
    );
  }
}

class WalletListTransactionWidget extends StatelessWidget {
  const WalletListTransactionWidget({required this.transactions, super.key});
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: transactions.length,
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: const Divider(),
      ),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return Button(
          style: const ButtonStyle.ghost(density: ButtonDensity.compact),
          child: Row(
            children: [
              Icon(_determineTransactionIcon(tx.type)),
              Gap(4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            tx.description ?? 'Unknown',
                            style: context.typography.small,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Gap(4.w),
                        Icon(
                          _determineStatusIcon(tx.status),
                          size: 12.sp,
                          color: _determineColor(tx.status),
                        ),
                      ],
                    ),
                    DefaultText(tx.createdAt.orderFormat),
                  ],
                ),
              ),
              Gap(8.w),
              Text(
                '${_determinePlusMinus(tx.type, tx.status)} ${context.formatCurrency(tx.amount)}',
                style: context.typography.small.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color? _determineColor(TransactionStatus status) {
    return switch (status) {
      TransactionStatus.PENDING => null,
      TransactionStatus.SUCCESS => Colors.green,
      TransactionStatus.REFUNDED => Colors.green,
      TransactionStatus.FAILED => Colors.red,
      TransactionStatus.CANCELLED => Colors.red,
      TransactionStatus.EXPIRED => Colors.red,
    };
  }

  IconData _determineTransactionIcon(TransactionType type) {
    switch (type) {
      case TransactionType.TOPUP:
      case TransactionType.REFUND:
      case TransactionType.EARNING:
        return LucideIcons.arrowDown;
      case TransactionType.PAYMENT:
      case TransactionType.WITHDRAW:
      case TransactionType.COMMISSION:
        return LucideIcons.arrowUp;
      case TransactionType.ADJUSTMENT:
        return LucideIcons.circle;
    }
  }

  IconData _determineStatusIcon(TransactionStatus status) {
    return switch (status) {
      TransactionStatus.PENDING => LucideIcons.circle,
      TransactionStatus.SUCCESS => LucideIcons.check,
      TransactionStatus.REFUNDED => LucideIcons.check,
      TransactionStatus.FAILED => LucideIcons.x,
      TransactionStatus.CANCELLED => LucideIcons.x,
      TransactionStatus.EXPIRED => LucideIcons.x,
    };
  }

  String _determinePlusMinus(TransactionType type, TransactionStatus status) {
    if (status == TransactionStatus.SUCCESS) {
      switch (type) {
        case TransactionType.TOPUP:
        case TransactionType.REFUND:
        case TransactionType.EARNING:
          return '+';
        case TransactionType.PAYMENT:
        case TransactionType.WITHDRAW:
        case TransactionType.COMMISSION:
          return '-';
        case TransactionType.ADJUSTMENT:
          return '';
      }
    } else {
      return '';
    }
  }
}
