part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserWalletState extends BaseState2 with UserWalletStateMappable {
  UserWalletState({
    this.myWallet,
    this.myTransactions = const [],
    this.thisMonthSummary,
    super.state,
    super.message,
    super.error,
  });

  final Wallet? myWallet;
  final List<Transaction> myTransactions;
  final WalletMonthlySummaryResponse? thisMonthSummary;

  @override
  UserWalletState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  @override
  UserWalletState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  UserWalletState toSuccess({
    Wallet? myWallet,
    List<Transaction>? myTransactions,
    WalletMonthlySummaryResponse? thisMonthSummary,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    myWallet: myWallet ?? this.myWallet,
    myTransactions: myTransactions ?? this.myTransactions,
    thisMonthSummary: thisMonthSummary ?? this.thisMonthSummary,
    message: message,
    error: null,
  );

  @override
  UserWalletState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserWalletTopUpState extends BaseState2
    with UserWalletTopUpStateMappable {
  UserWalletTopUpState({
    this.paymentResult,
    this.transactionResult,
    this.walletResult,
    super.state,
    super.message,
    super.error,
  });

  final Payment? paymentResult;
  final Transaction? transactionResult;
  final Wallet? walletResult;

  @override
  UserWalletTopUpState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  @override
  UserWalletTopUpState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  UserWalletTopUpState toSuccess({
    Payment? paymentResult,
    Transaction? transactionResult,
    Wallet? walletResult,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    paymentResult: paymentResult ?? this.paymentResult,
    transactionResult: transactionResult ?? this.transactionResult,
    walletResult: walletResult ?? this.walletResult,
    message: message,
    error: null,
  );

  @override
  UserWalletTopUpState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
