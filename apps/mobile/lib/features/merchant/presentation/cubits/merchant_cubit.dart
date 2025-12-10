import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class MerchantCubit extends BaseCubit<MerchantState> {
  MerchantCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(const MerchantState());
  final MerchantRepository _merchantRepository;

  Future<void> getMine() async => await taskManager.execute('MC-gM1', () async {
    try {
      emit(state.copyWith(mine: const OperationResult.loading()));
      final res = await _merchantRepository.getMine();
      emit(
        state.copyWith(
          mine: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(mine: OperationResult.failed(e)));
    }
  });

  void reset() => emit(const MerchantState());
}
