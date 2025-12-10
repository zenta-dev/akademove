import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class QuickMessageRepository extends BaseRepository {
  QuickMessageRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<List<QuickMessageTemplate>>> listTemplates({
    String? role,
    String? orderType,
    String? locale,
    bool? isActive,
  }) {
    return guard(() async {
      final chatApi = _apiClient.getChatApi();
      final response = await chatApi.quickMessageList(
        role: role,
        orderType: orderType,
        locale: locale,
        isActive: isActive,
      );

      final responseData = response.data;
      if (responseData == null) {
        throw const RepositoryError(
          'Failed to load quick message templates',
          code: ErrorCode.internalServerError,
        );
      }

      final templates = responseData.data.rows;

      return SuccessResponse(data: templates, message: responseData.message);
    });
  }
}
