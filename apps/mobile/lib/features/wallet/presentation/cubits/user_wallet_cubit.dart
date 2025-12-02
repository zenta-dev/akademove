import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class UserWalletCubit extends BaseCubit<UserWalletState> {
  UserWalletCubit({
    required WalletRepository walletRepository,
    required TransactionRepository transactionRepository,
  }) : _walletRepository = walletRepository,
       _transactionRepository = transactionRepository,
       super(UserWalletState());

  final WalletRepository _walletRepository;
  final TransactionRepository _transactionRepository;

  Future<void> init() async {
    await Future.wait([getMine(), getTransactionsMine(), getMonthlySummary()]);
  }

  void reset() {}

  Future<void> getMine() async {
    await taskManager.execute('getMine', () async {
      try {
        emit(state.toLoading());
        final res = await _walletRepository.getWallet();
        emit(state.toSuccess(myWallet: res.data));
      } on BaseError catch (e, st) {
        logger.e(
          '[UserWalletCubit] - Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
      }
    });
  }

  Future<void> getTransactionsMine() async {
    await taskManager.execute('getTransactionsMine', () async {
      try {
        emit(state.toLoading());
        final res = await _transactionRepository.list();
        emit(state.toSuccess(myTransactions: res.data));
      } on BaseError catch (e, st) {
        logger.e(
          '[UserRideCubit] - Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
      }
    });
  }

  Future<void> getMonthlySummary() async {
    await taskManager.execute('getMonthlySummary', () async {
      try {
        emit(state.toLoading());
        final now = DateTime.now();
        final res = await _walletRepository.getMonthlySummary(
          month: now.month,
          year: now.year,
        );
        emit(state.toSuccess(thisMonthSummary: res.data));
      } on BaseError catch (e, st) {
        logger.e(
          '[UserRideCubit] - Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
      }
    });
  }
}
