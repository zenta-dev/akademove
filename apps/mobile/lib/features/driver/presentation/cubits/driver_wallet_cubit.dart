import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class DriverWalletCubit extends BaseCubit<DriverWalletState> {
  DriverWalletCubit({
    required WalletRepository walletRepository,
    required TransactionRepository transactionRepository,
  }) : _walletRepository = walletRepository,
       _transactionRepository = transactionRepository,
       super(const DriverWalletState());

  final WalletRepository _walletRepository;
  final TransactionRepository _transactionRepository;

  Future<void> init({int? month, int? year}) async {
    await Future.wait([
      getWallet(),
      getTransactions(),
      getMonthlySummary(month: month, year: year),
    ]);
  }

  void reset() {
    emit(const DriverWalletState());
  }

  Future<void> getWallet() async {
    await taskManager.execute("DWC-gW1", () async {
      try {
        emit(
          state.copyWith(fetchWalletResult: const OperationResult.loading()),
        );
        final res = await _walletRepository.getWallet();
        emit(
          state.copyWith(
            fetchWalletResult: OperationResult.success(
              res.data,
              message: res.message,
            ),
            wallet: res.data,
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          "[DriverWalletCubit] - Error: ${e.message}",
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(fetchWalletResult: OperationResult.failed(e)));
      }
    });
  }

  Future<void> getTransactions() async {
    await taskManager.execute("DWC-gT1", () async {
      try {
        emit(
          state.copyWith(
            fetchTransactionsResult: const OperationResult.loading(),
          ),
        );
        final res = await _transactionRepository.list();
        emit(
          state.copyWith(
            fetchTransactionsResult: OperationResult.success(
              res.data,
              message: res.message,
            ),
            transactions: res.data,
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          "[DriverWalletCubit] - Error: ${e.message}",
          error: e,
          stackTrace: st,
        );
        emit(
          state.copyWith(fetchTransactionsResult: OperationResult.failed(e)),
        );
      }
    });
  }

  Future<void> getMonthlySummary({int? month, int? year}) async {
    await taskManager.execute("DWC-gMS1", () async {
      try {
        final now = DateTime.now();
        final res = await _walletRepository.getMonthlySummary(
          month: month ?? now.month,
          year: year ?? now.year,
        );
        emit(state.copyWith(monthlySummary: res.data));
      } on BaseError catch (e, st) {
        logger.e(
          "[DriverWalletCubit] - Error getting monthly summary: ${e.message}",
          error: e,
          stackTrace: st,
        );
      }
    });
  }

  Future<BaseResponse<Payment>> withdraw(WithdrawRequest request) async {
    return _walletRepository.withdraw(request);
  }

  Future<
    BaseResponse<
      ({
        bool hasSavedBank,
        BankProvider? bankProvider,
        String? accountNumber,
        String? accountName,
      })
    >
  >
  getSavedBankAccount() {
    return _walletRepository.getSavedBankAccount();
  }

  Future<
    BaseResponse<
      ({
        bool isValid,
        String? accountName,
        String bankCode,
        String accountNumber,
      })
    >
  >
  validateBankAccount({
    required BankProvider bankProvider,
    required String accountNumber,
  }) {
    return _walletRepository.validateBankAccount(
      bankProvider: bankProvider,
      accountNumber: accountNumber,
    );
  }

  void setSelectedPeriod(EarningsPeriod period) {
    emit(state.copyWith(selectedPeriod: period));
  }
}
