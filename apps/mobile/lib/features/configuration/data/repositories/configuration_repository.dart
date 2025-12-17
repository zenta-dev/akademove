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

  /// Fetch business configuration from the server
  Future<BaseResponse<BusinessConfiguration>> getBusinessConfiguration() {
    return guard(() async {
      final res = await _apiClient
          .getConfigurationApi()
          .configurationGetBusinessConfig();

      final data = res.data?.data;
      if (data == null) {
        throw RepositoryError('Failed to fetch business configuration');
      }

      return SuccessResponse(
        message: res.data?.message ?? 'Business configuration fetched',
        data: data,
      );
    });
  }

  /// Fetch public banners for a specific placement (USER_HOME, DRIVER_HOME, MERCHANT_HOME)
  Future<BaseResponse<List<BannerListPublic200ResponseDataInner>>>
  getPublicBanners({String? placement}) {
    return guard(() async {
      final res = await _apiClient.getConfigurationApi().bannerListPublic(
        placement: placement,
      );

      final data = res.data?.data;
      if (data == null) {
        throw RepositoryError('Failed to fetch banners');
      }

      return SuccessResponse(
        message: res.data?.message ?? 'Banners fetched',
        data: data,
      );
    });
  }
}
