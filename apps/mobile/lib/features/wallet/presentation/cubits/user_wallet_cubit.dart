import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class UserWalletCubit extends BaseCubit<UserWalletState> {
  UserWalletCubit({
    required WalletRepository walletRepository,
    required TransactionRepository transactionRepository,
  }) : _walletRepository = walletRepository,
       _transactionRepository = transactionRepository,
       super(const UserWalletState());

  final WalletRepository _walletRepository;
  final TransactionRepository _transactionRepository;

  Future<void> init() async {
    await Future.wait([getMine(), getTransactionsMine(), getMonthlySummary()]);
  }

  void reset() {
    emit(const UserWalletState());
  }

  Future<void> getMine() async {
    await taskManager.execute('getMine', () async {
      try {
        emit(state.copyWith(myWallet: const OperationResult.loading()));
        final res = await _walletRepository.getWallet();
        emit(
          state.copyWith(
            myWallet: OperationResult.success(res.data, message: res.message),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[UserWalletCubit] - Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(myWallet: OperationResult.failed(e)));
      }
    });
  }

  Future<void> getTransactionsMine() async {
    await taskManager.execute('getTransactionsMine', () async {
      try {
        emit(state.copyWith(myTransactions: const OperationResult.loading()));
        final res = await _transactionRepository.list();
        emit(
          state.copyWith(
            myTransactions: OperationResult.success(
              res.data,
              message: res.message,
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[UserWalletCubit] - Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(myTransactions: OperationResult.failed(e)));
      }
    });
  }

  Future<void> getMonthlySummary() async {
    await taskManager.execute('getMonthlySummary', () async {
      try {
        emit(state.copyWith(thisMonthSummary: const OperationResult.loading()));
        final now = DateTime.now();
        final res = await _walletRepository.getMonthlySummary(
          month: now.month,
          year: now.year,
        );
        emit(
          state.copyWith(
            thisMonthSummary: OperationResult.success(
              res.data,
              message: res.message,
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[UserWalletCubit] - Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(thisMonthSummary: OperationResult.failed(e)));
      }
    });
  }
}
