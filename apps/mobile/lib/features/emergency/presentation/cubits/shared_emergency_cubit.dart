import 'package:akademove/core/_export.dart';
import 'package:akademove/features/emergency/_export.dart';
import 'package:api_client/api_client.dart';

class SharedEmergencyCubit extends BaseCubit<SharedEmergencyState> {
  SharedEmergencyCubit({required EmergencyRepository repository})
    : _repository = repository,
      super(const SharedEmergencyState());

  final EmergencyRepository _repository;

  Future<void> init() async {
    emit(const SharedEmergencyState());
  }

  void reset() {
    emit(const SharedEmergencyState());
  }

  Future<void> trigger({
    required String orderId,
    required String userId,
    required EmergencyType type,
    required String description,
    EmergencyLocation? location,
    List<String>? contactedAuthorities,
  }) async => await taskManager.execute('SEC-t1-$orderId', () async {
    try {
      emit(state.copyWith(triggerEmergency: const OperationResult.loading()));

      final res = await _repository.trigger(
        TriggerEmergencyQuery(
          orderId: orderId,
          userId: userId,
          type: type,
          description: description,
          location: location,
          contactedAuthorities: contactedAuthorities,
        ),
      );

      emit(
        state.copyWith(
          triggerEmergency: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[SharedEmergencyCubit] Failed to trigger emergency',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(triggerEmergency: OperationResult.failed(e)));
    }
  });

  Future<void> loadByOrder(String orderId) async =>
      await taskManager.execute('SEC-lBO2-$orderId', () async {
        try {
          emit(state.copyWith(emergencies: const OperationResult.loading()));

          final res = await _repository.listByOrder(orderId);

          emit(
            state.copyWith(
              emergencies: OperationResult.success(
                res.data,
                message: res.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[SharedEmergencyCubit] Failed to load emergencies',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(emergencies: OperationResult.failed(e)));
        }
      });

  Future<void> get(String id) async => taskManager.execute(
    'SEC-g3-$id',
    () async {
      try {
        emit(state.copyWith(triggerEmergency: const OperationResult.loading()));

        final res = await _repository.get(id);

        emit(
          state.copyWith(
            triggerEmergency: OperationResult.success(
              res.data,
              message: res.message,
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[SharedEmergencyCubit] Failed to get emergency',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(triggerEmergency: OperationResult.failed(e)));
      }
    },
  );
}
