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
        final dummmy = List.generate(
          5,
          (i) => BannerConfiguration(
            title: 'title-$i',
            description: '',
            imageUrl: '${UrlConstants.randomImageUrl}/seed/$this/512/512',
          ),
        );

        final configs = [
          Configuration(
            key: 'user-home-banner',
            name: 'User Home Banner',
            value: dummmy,
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
