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

  bool get isLoading =>
      myWallet.isLoading ||
      myTransactions.isLoading ||
      thisMonthSummary.isLoading;

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

  // Helper methods for Cubit
  UserWalletState toLoading({
    bool wallet = false,
    bool transactions = false,
    bool summary = false,
  }) {
    return copyWith(
      myWallet: wallet ? const OperationResult.loading() : null,
      myTransactions: transactions ? const OperationResult.loading() : null,
      thisMonthSummary: summary ? const OperationResult.loading() : null,
    );
  }

  UserWalletState toSuccess({
    Wallet? wallet,
    List<Transaction>? transactions,
    WalletMonthlySummaryResponse? summary,
  }) {
    return copyWith(
      myWallet: wallet != null ? OperationResult.success(wallet) : null,
      myTransactions: transactions != null
          ? OperationResult.success(transactions)
          : null,
      thisMonthSummary: summary != null
          ? OperationResult.success(summary)
          : null,
    );
  }

  UserWalletState toFailure(
    BaseError error, {
    bool wallet = false,
    bool transactions = false,
    bool summary = false,
  }) {
    return copyWith(
      myWallet: wallet ? OperationResult.failed(error) : null,
      myTransactions: transactions ? OperationResult.failed(error) : null,
      thisMonthSummary: summary ? OperationResult.failed(error) : null,
    );
  }

  @override
  bool get stringify => true;
}

class UserWalletTopUpState extends Equatable {
  const UserWalletTopUpState({
    this.status = const OperationResult.idle(),
    this.payment,
    this.transaction,
    this.wallet,
  });

  final OperationResult<void> status;
  final Payment? payment;
  final Transaction? transaction;
  final Wallet? wallet;

  // Backwards compatibility getters
  Payment? get paymentResult => payment;
  Transaction? get transactionResult => transaction;
  Wallet? get walletResult => wallet;

  bool get isLoading => status.isLoading;
  bool get isSuccess => status.isSuccess;
  bool get isFailure => status.isFailure;
  BaseError? get error => status.error;

  @override
  List<Object?> get props => [status, payment, transaction, wallet];

  UserWalletTopUpState copyWith({
    OperationResult<void>? status,
    Payment? payment,
    Transaction? transaction,
    Wallet? wallet,
  }) {
    return UserWalletTopUpState(
      status: status ?? this.status,
      payment: payment ?? this.payment,
      transaction: transaction ?? this.transaction,
      wallet: wallet ?? this.wallet,
    );
  }

  // Helper methods for Cubit
  UserWalletTopUpState toLoading() {
    return copyWith(status: const OperationResult.loading());
  }

  UserWalletTopUpState toSuccess({
    Payment? paymentResult,
    Transaction? transactionResult,
    Wallet? walletResult,
  }) {
    return copyWith(
      status: OperationResult.success(null),
      payment: paymentResult ?? payment,
      transaction: transactionResult ?? transaction,
      wallet: walletResult ?? wallet,
    );
  }

  UserWalletTopUpState toFailure(BaseError error) {
    return copyWith(status: OperationResult.failed(error));
  }

  @override
  bool get stringify => true;
}
