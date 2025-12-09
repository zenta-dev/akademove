import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for DriverApi
void main() {
  final instance = ApiClient().getDriverApi();

  group(DriverApi, () {
    //Future<String> analyticsExportDriverAnalytics(String driverId, DateTime startDate, DateTime endDate) async
    test('test analyticsExportDriverAnalytics', () async {
      // TODO
    });

    //Future<DriverGetMine200ResponseBody> driverGet(String id) async
    test('test driverGet', () async {
      // TODO
    });

    //Future<DriverGetAnalytics200Response> driverGetAnalytics(String id, { String period, DateTime startDate, DateTime endDate }) async
    test('test driverGetAnalytics', () async {
      // TODO
    });

    //Future<DriverGetMine200Response> driverGetMine() async
    test('test driverGetMine', () async {
      // TODO
    });

    //Future<DriverGetReview200Response> driverGetReview(String id) async
    test('test driverGetReview', () async {
      // TODO
    });

    //Future<DriverList200Response> driverList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode, Object statuses, Object isOnline, num minRating, num maxRating }) async
    test('test driverList', () async {
      // TODO
    });

    //Future<DriverList200Response> driverNearby(num x, num y, num radiusKm, num limit, { UserGender gender }) async
    test('test driverNearby', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> driverRemove(String id) async
    test('test driverRemove', () async {
      // TODO
    });

    //Future<DriverScheduleCreate200Response> driverScheduleCreate(String driverId, DriverScheduleCreateRequest driverScheduleCreateRequest) async
    test('test driverScheduleCreate', () async {
      // TODO
    });

    //Future<DriverScheduleCreate200Response> driverScheduleGet(String driverId, String id) async
    test('test driverScheduleGet', () async {
      // TODO
    });

    //Future<DriverScheduleList200Response> driverScheduleList(String driverId, { String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test driverScheduleList', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> driverScheduleRemove(String driverId, String id) async
    test('test driverScheduleRemove', () async {
      // TODO
    });

    //Future<DriverScheduleCreate200Response> driverScheduleUpdate(String driverId, String id, DriverScheduleUpdateRequest driverScheduleUpdateRequest) async
    test('test driverScheduleUpdate', () async {
      // TODO
    });

    //Future<DriverGetReview200Response> driverSubmitApproval(String id, DriverSubmitApprovalRequest driverSubmitApprovalRequest) async
    test('test driverSubmitApproval', () async {
      // TODO
    });

    //Future<DriverGetReview200Response> driverSubmitRejection(String id, DriverSubmitRejectionRequest driverSubmitRejectionRequest) async
    test('test driverSubmitRejection', () async {
      // TODO
    });

    //Future<DriverGetMine200ResponseBody> driverUpdate(String id, { num studentId, String licensePlate, String bankProvider, num bankNumber, bool isTakingOrder, num currentLocationX, num currentLocationY, MultipartFile studentCard, MultipartFile driverLicense, MultipartFile vehicleCertificate }) async
    test('test driverUpdate', () async {
      // TODO
    });

    //Future<DriverGetReview200Response> driverUpdateDocumentStatus(String id, DriverUpdateDocumentStatusRequest driverUpdateDocumentStatusRequest) async
    test('test driverUpdateDocumentStatus', () async {
      // TODO
    });

    //Future<DriverGetMine200ResponseBody> driverUpdateLocation(String id, CoordinateWithMeta coordinateWithMeta) async
    test('test driverUpdateLocation', () async {
      // TODO
    });

    //Future<DriverGetMine200ResponseBody> driverUpdateOnlineStatus(String id, DriverUpdateOnlineStatusRequest driverUpdateOnlineStatusRequest) async
    test('test driverUpdateOnlineStatus', () async {
      // TODO
    });

    //Future<DriverGetMine200ResponseBody> driverUpdateTakingOrderStatus(String id, DriverUpdateTakingOrderStatusRequest driverUpdateTakingOrderStatusRequest) async
    test('test driverUpdateTakingOrderStatus', () async {
      // TODO
    });

    //Future<DriverGetReview200Response> driverVerifyQuiz(String id, DriverVerifyQuizRequest driverVerifyQuizRequest) async
    test('test driverVerifyQuiz', () async {
      // TODO
    });
  });
}
