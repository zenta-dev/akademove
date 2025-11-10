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
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;

      emit(state.toLoading());
      final res = await _walletRepository.getWallet();

      state.unAssignOperation(methodName);

      emit(state.toSuccess(myWallet: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> getTransactionsMine() async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;

      emit(state.toLoading());
      final res = await _transactionRepository.list();

      state.unAssignOperation(methodName);

      emit(state.toSuccess(myTransactions: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> getMonthlySummary() async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());
      final now = DateTime.now();
      final res = await _walletRepository.getMonthlySummary(
        month: now.month,

        year: now.year,
      );

      state.unAssignOperation(methodName);

      emit(state.toSuccess(thisMonthSummary: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
    }
  }
}
