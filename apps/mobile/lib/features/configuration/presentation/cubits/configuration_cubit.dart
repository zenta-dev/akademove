import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class ConfigurationCubit extends BaseCubit<ConfigurationState> {
  ConfigurationCubit({required this.configurationRepository})
    : super(const ConfigurationState());

  final ConfigurationRepository configurationRepository;

  Future<void> getConfigurations() async => await taskManager.execute(
    'CC2-lC1',
    () async {
      try {
        emit(state.copyWith(configurations: OperationResult.loading()));
        final now = DateTime.now();

        final banners = [
          BannerConfiguration(
            title: "atk",
            description: '',
            imageUrl: 'https://akademove.com/banner/atk.png',
          ),
          BannerConfiguration(
            title: "food",
            description: '',
            imageUrl: 'https://akademove.com/banner/food.png',
          ),
          BannerConfiguration(
            title: "package",
            description: '',
            imageUrl: 'https://akademove.com/banner/package.png',
          ),
          BannerConfiguration(
            title: "ride",
            description: '',
            imageUrl: 'https://akademove.com/banner/ride.png',
          ),
        ];

        final configs = [
          Configuration(
            key: 'user-home-banner',
            name: 'User Home Banner',
            value: banners,
            updatedById: '',
            updatedAt: now,
          ),
        ];
        emit(state.copyWith(configurations: OperationResult.success(configs)));
      } on BaseError catch (e, st) {
        logger.e(
          '[ConfigurationCubit] - Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(configurations: OperationResult.failed(e)));
      }
    },
  );

  void reset() => emit(const ConfigurationState());
}
