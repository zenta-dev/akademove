part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class DriverEarningsState extends BaseState2 with DriverEarningsStateMappable {
  DriverEarningsState({
    super.state,
    super.message,
    super.error,
    this.wallet,
    this.transactions = const [],
    this.monthlySummary,
    this.selectedPeriod = EarningsPeriod.daily,
  });

  final Wallet? wallet;
  final List<Transaction> transactions;
  final Object? monthlySummary;
  final EarningsPeriod selectedPeriod;

  @override
  DriverEarningsState toInitial() => DriverEarningsState();

  @override
  DriverEarningsState toLoading() => copyWith(state: CubitState.loading);

  @override
  DriverEarningsState toSuccess({
    String? message,
    Wallet? wallet,
    List<Transaction>? transactions,
    Object? monthlySummary,
    EarningsPeriod? selectedPeriod,
  }) => copyWith(
    state: CubitState.success,
    message: message,
    wallet: wallet ?? this.wallet,
    transactions: transactions ?? this.transactions,
    monthlySummary: monthlySummary ?? this.monthlySummary,
    selectedPeriod: selectedPeriod ?? this.selectedPeriod,
  );

  @override
  DriverEarningsState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message ?? error.message,
  );
}

enum EarningsPeriod { daily, weekly, monthly }
