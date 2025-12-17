import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class MerchantAnalyticsCubit extends BaseCubit<MerchantAnalyticsState> {
  MerchantAnalyticsCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(const MerchantAnalyticsState());

  final MerchantRepository _merchantRepository;

  /// Get merchant analytics with optional date filters
  Future<void> getAnalytics({
    required String merchantId,
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) async => await taskManager.execute('MAC-getAnalytics', () async {
    try {
      emit(state.copyWith(analytics: const OperationResult.loading()));
      final response = await _merchantRepository.getAnalytics(
        merchantId: merchantId,
        period: period,
        startDate: startDate,
        endDate: endDate,
      );
      emit(
        state.copyWith(
          analytics: OperationResult.success(
            response.data,
            message: response.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantAnalyticsCubit] - Get analytics error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(analytics: OperationResult.failed(e)));
    }
  });

  /// Get weekly analytics
  Future<void> getWeeklyAnalytics({required String merchantId}) async =>
      await getAnalytics(merchantId: merchantId, period: 'week');

  /// Get monthly analytics
  Future<void> getMonthlyAnalytics({required String merchantId}) async =>
      await getAnalytics(merchantId: merchantId, period: 'month');

  /// Get analytics for a custom date range
  Future<void> getAnalyticsForDateRange({
    required String merchantId,
    required DateTime startDate,
    required DateTime endDate,
  }) async => await getAnalytics(
    merchantId: merchantId,
    startDate: startDate,
    endDate: endDate,
  );

  /// Export merchant analytics to PDF/CSV
  Future<void> exportAnalytics({
    required String merchantId,
    required DateTime startDate,
    required DateTime endDate,
  }) async => await taskManager.execute('MAC-exportAnalytics', () async {
    try {
      emit(state.copyWith(exportResult: const OperationResult.loading()));
      final response = await _merchantRepository.exportAnalytics(
        merchantId: merchantId,
        startDate: startDate,
        endDate: endDate,
      );
      emit(
        state.copyWith(
          exportResult: OperationResult.success(
            response.data,
            message: response.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantAnalyticsCubit] - Export analytics error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(exportResult: OperationResult.failed(e)));
    }
  });

  /// Clear export result after processing
  void clearExportResult() {
    emit(state.copyWith(exportResult: const OperationResult.idle()));
  }

  void reset() => emit(const MerchantAnalyticsState());
}
