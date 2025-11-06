import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class ConfigurationRepository extends BaseRepository {
  const ConfigurationRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;
}
