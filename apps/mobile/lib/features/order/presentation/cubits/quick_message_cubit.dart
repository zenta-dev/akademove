import 'package:akademove/core/_export.dart';
import 'package:akademove/features/order/data/repositories/quick_message_repository.dart';
import 'package:akademove/features/order/presentation/cubits/quick_message_state.dart';

class QuickMessageCubit extends BaseCubit<QuickMessageState> {
  QuickMessageCubit({required QuickMessageRepository quickMessageRepository})
    : _quickMessageRepository = quickMessageRepository,
      super(QuickMessageState());

  final QuickMessageRepository _quickMessageRepository;

  /// Fetch quick message templates filtered by role, orderType, and locale
  Future<void> fetchTemplates({
    required String role,
    String? orderType,
    String? locale,
  }) async =>
      await taskManager.execute('QMC-fT-$role-$orderType-$locale', () async {
        try {
          emit(state.toLoading());

          final res = await _quickMessageRepository.listTemplates(
            role: role,
            orderType: orderType,
            locale: locale ?? 'en',
            isActive: true,
          );

          emit(
            state.toSuccessWithTemplates(
              templates: res.data,
              message: res.message,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[QuickMessageCubit] - Error fetching templates: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  void reset() {
    emit(QuickMessageState());
  }
}
