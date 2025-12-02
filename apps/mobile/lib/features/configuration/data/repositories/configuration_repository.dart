import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class ConfigurationRepository extends BaseRepository {
  const ConfigurationRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<Configuration>> get(String key) {
    return guard(() async {
      final res = await _apiClient.getConfigurationApi().configurationGet(
        key: key,
      );

      final data = res.data?.data;
      if (data == null) {
        throw RepositoryError('Configuration not found for key: $key');
      }

      return SuccessResponse(
        message: res.data?.message ?? 'Configuration fetched',
        data: data,
      );
    });
  }

  Future<BaseResponse<List<Configuration>>> list() {
    return guard(() async {
      final res = await _apiClient.getConfigurationApi().configurationList();

      final data = res.data?.data;
      if (data == null) {
        throw RepositoryError('Failed to fetch configurations');
      }

      return SuccessResponse(
        message: res.data?.message ?? 'Configurations fetched',
        data: data,
      );
    });
  }
}
