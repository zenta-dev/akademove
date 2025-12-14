import 'package:akademove/core/_export.dart';
import 'package:akademove/features/report/_export.dart';
import 'package:api_client/api_client.dart';

class SharedReportCubit extends BaseCubit<SharedReportState> {
  SharedReportCubit({required ReportRepository repository})
    : _repository = repository,
      super(const SharedReportState());

  final ReportRepository _repository;

  Future<void> init() async {
    emit(const SharedReportState());
  }

  void reset() {
    emit(const SharedReportState());
  }

  /// Submit a report for a user (driver or rider)
  Future<void> submitReport({
    required String targetUserId,
    required ReportCategory category,
    required String description,
    String? orderId,
    String? evidenceUrl,
  }) async => await taskManager.execute('RC-sr1-', () async {
    try {
      emit(state.copyWith(status: const OperationResult.loading()));

      await _repository.submitReport(
        targetUserId: targetUserId,
        category: category,
        description: description,
        orderId: orderId,
        evidenceUrl: evidenceUrl,
      );

      emit(state.copyWith(status: OperationResult.success(null)));
    } on BaseError catch (e, st) {
      logger.e(
        '[SharedReportCubit] Failed to submit report',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(status: OperationResult.failed(e)));
    }
  });
}
