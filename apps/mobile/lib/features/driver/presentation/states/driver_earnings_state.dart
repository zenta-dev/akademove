part of '_export.dart';

enum EarningsPeriod { daily, weekly, monthly }

class DriverEarningsState extends Equatable {
  const DriverEarningsState({
    this.fetchWalletResult = const OperationResult.idle(),
    this.fetchTransactionsResult = const OperationResult.idle(),
    this.wallet,
    this.transactions = const [],
    this.monthlySummary,
    this.selectedPeriod = EarningsPeriod.daily,
  });

  final OperationResult<Wallet> fetchWalletResult;
  final OperationResult<List<Transaction>> fetchTransactionsResult;

  final Wallet? wallet;
  final List<Transaction> transactions;
  final Object? monthlySummary;
  final EarningsPeriod selectedPeriod;

  @override
  List<Object?> get props => [
    fetchWalletResult,
    fetchTransactionsResult,
    wallet,
    transactions,
    monthlySummary,
    selectedPeriod,
  ];

  @override
  bool get stringify => true;

  DriverEarningsState copyWith({
    OperationResult<Wallet>? fetchWalletResult,
    OperationResult<List<Transaction>>? fetchTransactionsResult,
    Wallet? wallet,
    List<Transaction>? transactions,
    Object? monthlySummary,
    EarningsPeriod? selectedPeriod,
  }) {
    return DriverEarningsState(
      fetchWalletResult: fetchWalletResult ?? this.fetchWalletResult,
      fetchTransactionsResult:
          fetchTransactionsResult ?? this.fetchTransactionsResult,
      wallet: wallet ?? this.wallet,
      transactions: transactions ?? this.transactions,
      monthlySummary: monthlySummary ?? this.monthlySummary,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }
}
