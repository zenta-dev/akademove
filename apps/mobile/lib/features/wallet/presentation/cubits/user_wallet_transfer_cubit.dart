import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class UserWalletTransferCubit extends BaseCubit<UserWalletTransferState> {
  UserWalletTransferCubit({required WalletRepository walletRepository})
    : _walletRepository = walletRepository,
      super(const UserWalletTransferState());

  final WalletRepository _walletRepository;

  void reset() {
    emit(const UserWalletTransferState());
  }

  Future<void> transfer({
    required String recipientUserId,
    required int amount,
    String? note,
  }) async => await taskManager.execute('UWTC-t1', () async {
    try {
      emit(state.copyWith(transfer: const OperationResult.loading()));
      final res = await _walletRepository.transfer(
        recipientUserId: recipientUserId,
        amount: amount,
        note: note,
      );

      emit(
        state.copyWith(
          transfer: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserWalletTransferCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(transfer: OperationResult.failed(e)));
    }
  });
}
