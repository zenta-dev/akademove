part of '_export.dart';

class UserWalletState extends Equatable {
  const UserWalletState({
    this.myWallet = const OperationResult.idle(),
    this.myTransactions = const OperationResult.idle(),
    this.thisMonthSummary = const OperationResult.idle(),
  });

  final OperationResult<Wallet> myWallet;
  final OperationResult<List<Transaction>> myTransactions;
  final OperationResult<WalletMonthlySummaryResponse> thisMonthSummary;

  @override
  List<Object> get props => [myWallet, myTransactions, thisMonthSummary];

  UserWalletState copyWith({
    OperationResult<Wallet>? myWallet,
    OperationResult<List<Transaction>>? myTransactions,
    OperationResult<WalletMonthlySummaryResponse>? thisMonthSummary,
  }) {
    return UserWalletState(
      myWallet: myWallet ?? this.myWallet,
      myTransactions: myTransactions ?? this.myTransactions,
      thisMonthSummary: thisMonthSummary ?? this.thisMonthSummary,
    );
  }

  @override
  bool get stringify => true;
}

class UserWalletTopUpState extends Equatable {
  const UserWalletTopUpState({
    this.payment = const OperationResult.idle(),
    this.transaction = const OperationResult.idle(),
    this.wallet = const OperationResult.idle(),
  });

  final OperationResult<Payment> payment;
  final OperationResult<Transaction?> transaction;
  final OperationResult<Wallet?> wallet;

  @override
  List<Object?> get props => [payment, transaction, wallet];

  UserWalletTopUpState copyWith({
    OperationResult<Payment>? payment,
    OperationResult<Transaction?>? transaction,
    OperationResult<Wallet?>? wallet,
  }) {
    return UserWalletTopUpState(
      payment: payment ?? this.payment,
      transaction: transaction ?? this.transaction,
      wallet: wallet ?? this.wallet,
    );
  }

  @override
  bool get stringify => true;
}
