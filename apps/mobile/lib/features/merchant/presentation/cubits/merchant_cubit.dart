import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class MerchantCubit extends BaseCubit<MerchantState> {
  MerchantCubit({
    required MerchantRepository merchantRepository,
  }) : _merchantRepository = merchantRepository,
       super(MerchantState());
  final MerchantRepository _merchantRepository;

  Future<void> init() async {}

  Future<void> getMine() async {
    try {
      emit(state.toLoading());
      final res = await _merchantRepository.getMine();
      emit(state.toSuccess(mine: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  void reset() => emit(MerchantState());
}
