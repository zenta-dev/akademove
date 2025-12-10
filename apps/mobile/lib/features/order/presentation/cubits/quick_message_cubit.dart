import 'package:akademove/core/_export.dart';
import 'package:akademove/features/order/data/repositories/quick_message_repository.dart';
import 'package:api_client/api_client.dart';

class QuickMessageCubit
    extends BaseCubit<OperationResult<List<QuickMessageTemplate>>> {
  QuickMessageCubit({required QuickMessageRepository quickMessageRepository})
    : _quickMessageRepository = quickMessageRepository,
      super(const OperationResult.idle());

  final QuickMessageRepository _quickMessageRepository;

  /// Fetch quick message templates filtered by role, orderType, and locale
  Future<void> fetchTemplates({
    required String role,
    String? orderType,
    String? locale,
  }) async =>
      await taskManager.execute('QMC-fT-$role-$orderType-$locale', () async {
        try {
          emit(const OperationResult.loading());

          final res = await _quickMessageRepository.listTemplates(
            role: role,
            orderType: orderType,
            locale: locale ?? 'en',
            isActive: true,
          );

          emit(OperationResult.success(res.data));
        } on BaseError catch (e, st) {
          logger.e(
            '[QuickMessageCubit] - Error fetching templates: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(OperationResult.failed(e));
        }
      });

  void reset() {
    emit(const OperationResult.idle());
  }
}
