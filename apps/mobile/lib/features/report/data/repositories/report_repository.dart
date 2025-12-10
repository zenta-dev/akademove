import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class ReportRepository extends BaseRepository {
  const ReportRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Submit a report for a user (driver or rider)
  Future<BaseResponse<Report>> submitReport({
    required String targetUserId,
    required ReportCategory category,
    required String description,
    String? orderId,
    String? evidenceUrl,
  }) {
    return guard(() async {
      final res = await _apiClient.getReportApi().reportCreate(
        insertReport: InsertReport(
          reporterId: '', // Will be set by backend from auth context
          targetUserId: targetUserId,
          category: category,
          description: description,
          status: ReportStatus.PENDING,
          orderId: orderId,
          evidenceUrl: evidenceUrl,
        ),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to submit report',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Get a single report by ID
  Future<BaseResponse<Report>> getReport(String id) {
    return guard(() async {
      final res = await _apiClient.getReportApi().reportGet(id: id);

      final data =
          res.data ??
          (throw const RepositoryError(
            'Report not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Get list of user's reports
  Future<BaseResponse<List<Report>>> getMyReports({int? page, int? limit}) {
    return guard(() async {
      final res = await _apiClient.getReportApi().reportList(
        page: page,
        limit: limit,
        sortBy: 'reportedAt',
        order: PaginationOrder.desc,
        mode: PaginationMode.offset,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to fetch reports',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
