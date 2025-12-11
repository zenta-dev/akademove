import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class MerchantAvailabilityCubit extends BaseCubit<MerchantAvailabilityState> {
  MerchantAvailabilityCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(const MerchantAvailabilityState());

  final MerchantRepository _merchantRepository;

  /// Toggle merchant online status
  Future<void> setOnlineStatus(
    bool isOnline,
  ) async => await taskManager.execute('MAC-sOS', () async {
    try {
      emit(state.copyWith(setOnlineStatus: const OperationResult.loading()));
      final response = await _merchantRepository.setOnlineStatus(isOnline);
      emit(
        state.copyWith(
          setOnlineStatus: OperationResult.success(
            response.data,
            message: isOnline ? 'You are now online' : 'You are now offline',
          ),
        ),
      );
      // Refresh availability status after changing online status
      await getAvailabilityStatus();
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantAvailabilityCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(setOnlineStatus: OperationResult.failed(e)));
    }
  });

  /// Set merchant operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
  Future<void> setOperatingStatus(
    MerchantSetOperatingStatusRequestOperatingStatusEnum operatingStatus,
  ) async => await taskManager.execute('MAC-sStatus', () async {
    try {
      emit(state.copyWith(setOperatingStatus: const OperationResult.loading()));
      final response = await _merchantRepository.setOperatingStatus(
        operatingStatus,
      );
      emit(
        state.copyWith(
          setOperatingStatus: OperationResult.success(
            response.data,
            message: 'Store status updated to ${operatingStatus.value}',
          ),
        ),
      );
      // Refresh availability status after changing operating status
      await getAvailabilityStatus();
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantAvailabilityCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(setOperatingStatus: OperationResult.failed(e)));
    }
  });

  /// Get current availability status
  Future<void> getAvailabilityStatus() async =>
      await taskManager.execute('MAC-gAS', () async {
        try {
          emit(
            state.copyWith(availabilityStatus: const OperationResult.loading()),
          );
          final response = await _merchantRepository.getAvailabilityStatus();
          emit(
            state.copyWith(
              availabilityStatus: OperationResult.success(
                response.data,
                message: 'Availability status loaded',
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[MerchantAvailabilityCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(availabilityStatus: OperationResult.failed(e)));
        }
      });

  void reset() => emit(const MerchantAvailabilityState());
}
