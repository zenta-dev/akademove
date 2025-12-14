part of '_export.dart';

enum EarningsPeriod { daily, weekly, monthly }

class DriverWalletState extends Equatable {
  const DriverWalletState({
    this.fetchWalletResult = const OperationResult.idle(),
    this.fetchTransactionsResult = const OperationResult.idle(),
    this.fetchCommissionReportResult = const OperationResult.idle(),
    this.wallet,
    this.transactions = const [],
    this.commissionReport,
    this.monthlySummary,
    this.selectedPeriod = EarningsPeriod.daily,
  });

  final OperationResult<Wallet> fetchWalletResult;
  final OperationResult<List<Transaction>> fetchTransactionsResult;
  final OperationResult<CommissionReportResponse> fetchCommissionReportResult;

  final Wallet? wallet;
  final List<Transaction> transactions;
  final CommissionReportResponse? commissionReport;
  final Object? monthlySummary;
  final EarningsPeriod selectedPeriod;

  @override
  List<Object?> get props => [
    fetchWalletResult,
    fetchTransactionsResult,
    fetchCommissionReportResult,
    wallet,
    transactions,
    commissionReport,
    monthlySummary,
    selectedPeriod,
  ];

  @override
  bool get stringify => true;

  DriverWalletState copyWith({
    OperationResult<Wallet>? fetchWalletResult,
    OperationResult<List<Transaction>>? fetchTransactionsResult,
    OperationResult<CommissionReportResponse>? fetchCommissionReportResult,
    Wallet? wallet,
    List<Transaction>? transactions,
    CommissionReportResponse? commissionReport,
    Object? monthlySummary,
    EarningsPeriod? selectedPeriod,
  }) {
    return DriverWalletState(
      fetchWalletResult: fetchWalletResult ?? this.fetchWalletResult,
      fetchTransactionsResult:
          fetchTransactionsResult ?? this.fetchTransactionsResult,
      fetchCommissionReportResult:
          fetchCommissionReportResult ?? this.fetchCommissionReportResult,
      wallet: wallet ?? this.wallet,
      transactions: transactions ?? this.transactions,
      commissionReport: commissionReport ?? this.commissionReport,
      monthlySummary: monthlySummary ?? this.monthlySummary,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }
}
