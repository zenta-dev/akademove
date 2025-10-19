import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class MerchantCubit extends BaseCubit<MerchantState> {
  MerchantCubit(this._merchantRepository) : super(const MerchantState());
  final MerchantRepository _merchantRepository;

  @override
  Future<void> init() async {
    await getMine();
  }

  Future<void> getMine() async {
    try {
      emit(state.toLoading());
      final res = await _merchantRepository.getMine();
      emit(state.toSuccess(selected: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  @override
  void reset() => emit(const MerchantState());
}
