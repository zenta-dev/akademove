import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class ConfigurationCubit extends BaseCubit<ConfigurationState> {
  ConfigurationCubit({required ConfigurationRepository configurationRepository})
    : super(const ConfigurationState());

  Future<void> getBanner() async =>
      await taskManager.execute('CC-gB1', () async {
        try {
          emit(state.toLoading());
          final now = DateTime.now();
          final banners = [
            BannerConfiguration(
              title: 'title-0',
              description: '',
              imageUrl: 'https://akademove.com/banner/food.png',
            ),
            BannerConfiguration(
              title: 'title-0',
              description: '',
              imageUrl: 'https://akademove.com/banner/ride.png',
            ),
            BannerConfiguration(
              title: 'title-0',
              description: '',
              imageUrl: 'https://akademove.com/banner/package.png',
            ),
            BannerConfiguration(
              title: 'title-0',
              description: '',
              imageUrl: 'https://akademove.com/banner/atk.png',
            ),
          ];
          emit(
            state.toSuccess(
              list: [
                Configuration(
                  key: 'user-home-banner',
                  name: 'User Home Banner',
                  value: banners,
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
      });

  void reset() => emit(const ConfigurationState());
}
