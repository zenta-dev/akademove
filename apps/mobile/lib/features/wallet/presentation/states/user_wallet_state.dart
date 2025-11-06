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
  final List<WalletTransaction> myTransactions;
  final WalletMonthlySummaryResponse? thisMonthSummary;

  @override
  UserWalletState toInitial() => copyWith(
    state: CubitState.initial,
    message: null,
    error: null,
  );

  @override
  UserWalletState toLoading() => copyWith(
    state: CubitState.loading,
    message: null,
    error: null,
  );

  @override
  UserWalletState toSuccess({
    Wallet? myWallet,
    List<WalletTransaction>? myTransactions,
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
  UserWalletState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message,
  );
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
    super.state,
    super.message,
    super.error,
  });

  final Payment? paymentResult;
  final WalletTransaction? transactionResult;

  @override
  UserWalletTopUpState toInitial() => copyWith(
    state: CubitState.initial,
    message: null,
    error: null,
  );

  @override
  UserWalletTopUpState toLoading() => copyWith(
    state: CubitState.loading,
    message: null,
    error: null,
  );

  @override
  UserWalletTopUpState toSuccess({
    Payment? paymentResult,
    WalletTransaction? transactionResult,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    paymentResult: paymentResult ?? this.paymentResult,
    transactionResult: transactionResult ?? this.transactionResult,
    message: message,
    error: null,
  );

  @override
  UserWalletTopUpState toFailure(BaseError error, {String? message}) =>
      copyWith(
        state: CubitState.failure,
        error: error,
        message: message,
      );
}
