import 'package:akademove/core/_export.dart';
import 'package:akademove/features/emergency/data/emergency_repository.dart';
import 'package:akademove/features/emergency/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';

class EmergencyCubit extends BaseCubit<EmergencyState> {
  EmergencyCubit({required EmergencyRepository repository})
    : _repository = repository,
      super(EmergencyState());

  final EmergencyRepository _repository;

  Future<void> init() async {
    emit(EmergencyState());
  }

  void reset() {
    emit(EmergencyState());
  }

  /// Trigger emergency during active trip
  Future<void> trigger({
    required String orderId,
    required String userId,
    required EmergencyType type,
    required String description,
    EmergencyLocation? location,
    List<String>? contactedAuthorities,
  }) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;

      emit(state.toLoading());

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

      state.unAssignOperation(methodName);
      emit(state.toSuccess(triggered: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[EmergencyCubit] Failed to trigger emergency',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  /// Load emergencies for an order
  Future<void> loadByOrder(String orderId) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;

      emit(state.toLoading());

      final res = await _repository.listByOrder(orderId);

      state.unAssignOperation(methodName);
      emit(state.toSuccess(list: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[EmergencyCubit] Failed to load emergencies',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  /// Get single emergency details
  Future<void> get(String id) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;

      emit(state.toLoading());

      final res = await _repository.get(id);

      state.unAssignOperation(methodName);
      emit(state.toSuccess(triggered: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[EmergencyCubit] Failed to get emergency',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }
}
