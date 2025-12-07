import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class MerchantAvailabilityCubit extends BaseCubit<MerchantAvailabilityState> {
  MerchantAvailabilityCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(MerchantAvailabilityState.initial());

  final MerchantRepository _merchantRepository;

  /// Toggle merchant online status
  Future<void> setOnlineStatus(bool isOnline) async =>
      await taskManager.execute('MAC-sOS', () async {
        try {
          emit(MerchantAvailabilityState.loading());
          final response = await _merchantRepository.setOnlineStatus(isOnline);
          emit(
            MerchantAvailabilityState.success(
              response.data,
              message: isOnline ? 'You are now online' : 'You are now offline',
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[MerchantAvailabilityCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(MerchantAvailabilityState.failure(e));
        }
      });

  /// Toggle merchant order-taking status
  Future<void> setOrderTakingStatus(bool isTakingOrders) async =>
      await taskManager.execute('MAC-sOT', () async {
        try {
          emit(MerchantAvailabilityState.loading());
          final response = await _merchantRepository.setOrderTakingStatus(
            isTakingOrders,
          );
          emit(
            MerchantAvailabilityState.success(
              response.data,
              message: isTakingOrders
                  ? 'You are now taking orders'
                  : 'You have stopped taking orders',
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[MerchantAvailabilityCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(MerchantAvailabilityState.failure(e));
        }
      });

  /// Set merchant operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
  Future<void> setOperatingStatus(String operatingStatus) async =>
      await taskManager.execute('MAC-sStatus', () async {
        try {
          emit(MerchantAvailabilityState.loading());
          final response = await _merchantRepository.setOperatingStatus(
            operatingStatus,
          );
          emit(
            MerchantAvailabilityState.success(
              response.data,
              message: 'Store status updated to $operatingStatus',
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[MerchantAvailabilityCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(MerchantAvailabilityState.failure(e));
        }
      });

  /// Get current availability status
  Future<void> getAvailabilityStatus() async =>
      await taskManager.execute('MAC-gAS', () async {
        try {
          emit(MerchantAvailabilityState.loading());
          final response = await _merchantRepository.getAvailabilityStatus();
          emit(
            MerchantAvailabilityState.success(
              response.data,
              message: 'Availability status loaded',
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[MerchantAvailabilityCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(MerchantAvailabilityState.failure(e));
        }
      });

  void reset() => emit(MerchantAvailabilityState.initial());
}
