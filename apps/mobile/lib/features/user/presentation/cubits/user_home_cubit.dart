import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class UserHomeCubit extends BaseCubit<UserHomeState> {
  UserHomeCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(UserHomeState());
  final MerchantRepository _merchantRepository;

  Future<void> getPopulars() async {
    try {
      emit(state.toLoading());
      final res = await _merchantRepository.getPopulars();
      emit(state.toSuccess(popularMerchants: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  void reset() => emit(UserHomeState());
}
