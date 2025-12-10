import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserWalletTransferCubit extends BaseCubit<UserWalletTransferState> {
  UserWalletTransferCubit({
    required WalletRepository walletRepository,
    required UserRepository userRepository,
  }) : _walletRepository = walletRepository,
       _userRepository = userRepository,
       super(const UserWalletTransferState());

  final WalletRepository _walletRepository;
  final UserRepository _userRepository;

  void reset() {
    emit(const UserWalletTransferState());
  }

  /// Clear the selected recipient (when user changes input)
  void clearRecipient() {
    emit(
      state.copyWith(
        recipientLookup: const OperationResult.idle(),
        clearRecipient: true,
      ),
    );
  }

  /// Set recipient directly from QR code scan
  void setRecipientFromQr(UserLookupResult recipient) {
    emit(
      state.copyWith(
        recipientLookup: OperationResult.success(recipient),
        selectedRecipient: recipient,
      ),
    );
  }

  /// Lookup recipient by phone number
  Future<void> lookupRecipient(String phone) async =>
      await taskManager.execute('UWTC-lookup', () async {
        final trimmed = phone.trim();
        if (trimmed.isEmpty) {
          emit(
            state.copyWith(
              recipientLookup: const OperationResult.idle(),
              clearRecipient: true,
            ),
          );
          return;
        }

        try {
          emit(
            state.copyWith(
              recipientLookup: const OperationResult.loading(),
              clearRecipient: true,
            ),
          );

          final res = await _userRepository.lookupByPhone(trimmed);
          final user = res.data;

          if (user != null) {
            emit(
              state.copyWith(
                recipientLookup: OperationResult.success(
                  user,
                  message: res.message,
                ),
                selectedRecipient: user,
              ),
            );
          } else {
            // User not found - not an error, just no match
            emit(
              state.copyWith(
                recipientLookup: OperationResult.success(null),
                clearRecipient: true,
              ),
            );
          }
        } on BaseError catch (e, st) {
          logger.e(
            '[UserWalletTransferCubit] - Lookup error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(
            state.copyWith(
              recipientLookup: OperationResult.failed(e),
              clearRecipient: true,
            ),
          );
        }
      });

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
