import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class ConfigurationCubit extends BaseCubit<ConfigurationState> {
  ConfigurationCubit({required ConfigurationRepository configurationRepository})
    : super(const ConfigurationState());

  Future<void> init() async {}

  Future<void> getBanner() async {
    try {
      emit(state.toLoading());
      final now = DateTime.now();
      final dummmy = List.generate(
        5,
        (i) => BannerConfiguration(
          title: 'title-$i',
          description: '',
          imageUrl: '${UrlConstants.randomImageUrl}/seed/$this/512/512',
        ),
      );

      emit(
        state.toSuccess(
          list: [
            Configuration(
              key: 'user-home-banner',
              name: 'User Home Banner',
              value: dummmy,
              updatedById: '',
              updatedAt: now,
            ),
          ],
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[ConfigurationCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  void reset() => emit(const ConfigurationState());
}
