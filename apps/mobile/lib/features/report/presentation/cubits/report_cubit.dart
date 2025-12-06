import 'package:akademove/core/_export.dart';
import 'package:akademove/features/report/_export.dart';
import 'package:api_client/api_client.dart';

class ReportCubit extends BaseCubit<ReportState> {
  ReportCubit({required ReportRepository repository})
    : _repository = repository,
      super(ReportState());

  final ReportRepository _repository;

  Future<void> init() async {
    emit(ReportState());
  }

  void reset() {
    emit(ReportState());
  }

  /// Submit a report for a user (driver or rider)
  Future<void> submitReport({
    required String targetUserId,
    required ReportCategory category,
    required String description,
    String? orderId,
    String? evidenceUrl,
  }) async => await taskManager.execute('RC-sr1-$targetUserId', () async {
    try {
      emit(state.toLoading());

      final res = await _repository.submitReport(
        targetUserId: targetUserId,
        category: category,
        description: description,
        orderId: orderId,
        evidenceUrl: evidenceUrl,
      );

      emit(state.toSuccess(submittedReport: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[ReportCubit] Failed to submit report',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  });

  /// Get a single report by ID
  Future<void> getReport(
    String id,
  ) async => await taskManager.execute('RC-gr2-$id', () async {
    try {
      emit(state.toLoading());

      final res = await _repository.getReport(id);

      emit(state.toSuccess(submittedReport: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e('[ReportCubit] Failed to get report', error: e, stackTrace: st);
      emit(state.toFailure(e));
    }
  });

  /// Load list of user's reports
  Future<void> loadMyReports({int? page, int? limit}) async =>
      await taskManager.execute('RC-lmr3', () async {
        try {
          emit(state.toLoading());

          final res = await _repository.getMyReports(page: page, limit: limit);

          emit(state.toSuccess(reports: res.data, message: res.message));
        } on BaseError catch (e, st) {
          logger.e(
            '[ReportCubit] Failed to load reports',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });
}
