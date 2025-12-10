import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class ConfigurationCubit extends BaseCubit<ConfigurationState> {
  ConfigurationCubit({required this.configurationRepository})
    : super(const ConfigurationState());

  final ConfigurationRepository configurationRepository;

  /// Fetch public banners from the API for a specific placement
  Future<void> getBanners({String? placement}) async =>
      await taskManager.execute('CC-getBanners', () async {
        try {
          emit(state.copyWith(banners: const OperationResult.loading()));
          final response = await configurationRepository.getPublicBanners(
            placement: placement,
          );
          emit(
            state.copyWith(
              banners: OperationResult.success(
                response.data,
                message: response.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[ConfigurationCubit] - Error fetching banners: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(banners: OperationResult.failed(e)));
        }
      });

  Future<void> getConfigurations() async =>
      await taskManager.execute('CC2-lC1', () async {
        try {
          emit(state.copyWith(configurations: const OperationResult.loading()));
          final response = await configurationRepository.list();
          emit(
            state.copyWith(
              configurations: OperationResult.success(
                response.data,
                message: response.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[ConfigurationCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(configurations: OperationResult.failed(e)));
        }
      });

  void reset() => emit(const ConfigurationState());
}
