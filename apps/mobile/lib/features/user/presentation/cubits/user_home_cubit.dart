import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class UserHomeCubit extends BaseCubit<UserHomeState> {
  UserHomeCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(const UserHomeState());
  final MerchantRepository _merchantRepository;

  Future<void> getPopulars() async => await taskManager.execute(
    'UHC-gP1',
    () async {
      try {
        emit(state.copyWith(popularMerchants: const OperationResult.loading()));
        final res = await _merchantRepository.getPopulars();
        emit(
          state.copyWith(
            popularMerchants: OperationResult.success(
              res.data,
              message: res.message,
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[MerchantCubit] - Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(popularMerchants: OperationResult.failed(e)));
      }
    },
  );

  void reset() => emit(const UserHomeState());
}
