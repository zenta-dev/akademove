import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for AdminApi
void main() {
  final instance = ApiClient().getAdminApi();

  group(AdminApi, () {
    //Future<String> analyticsExportOperatorAnalytics(DateTime startDate, DateTime endDate) async
    test('test analyticsExportOperatorAnalytics', () async {
      // TODO
    });

    //Future<AuthSignOut200Response> contactDelete(String id) async
    test('test contactDelete', () async {
      // TODO
    });

    //Future<ContactSubmit201Response> contactGetById(String id) async
    test('test contactGetById', () async {
      // TODO
    });

    //Future<ContactList200Response> contactList({ int page, int limit, String status, String search }) async
    test('test contactList', () async {
      // TODO
    });

    //Future<ContactSubmit201Response> contactRespond(String id, ContactRespondRequest contactRespondRequest) async
    test('test contactRespond', () async {
      // TODO
    });

    //Future<ContactSubmit201Response> contactUpdate(String id, UpdateContact updateContact) async
    test('test contactUpdate', () async {
      // TODO
    });

    //Future<DriverGetMine200ResponseBody> driverActivate(String id) async
    test('test driverActivate', () async {
      // TODO
    });

    //Future<DriverGetMine200ResponseBody> driverApprove(String id) async
    test('test driverApprove', () async {
      // TODO
    });

    //Future<DriverGetMine200ResponseBody> driverReject(String id, DriverRejectRequest driverRejectRequest) async
    test('test driverReject', () async {
      // TODO
    });

    //Future<DriverGetMine200ResponseBody> driverSuspend(String id, DriverSuspendRequest driverSuspendRequest) async
    test('test driverSuspend', () async {
      // TODO
    });

    //Future<UserAdminCreate200Response> userAdminCreate(InsertUser insertUser) async
    test('test userAdminCreate', () async {
      // TODO
    });

    //Future<UserAdminDashboardStats200Response> userAdminDashboardStats({ DateTime startDate, DateTime endDate, String period }) async
    test('test userAdminDashboardStats', () async {
      // TODO
    });

    //Future<UserAdminCreate200Response> userAdminGet(String id) async
    test('test userAdminGet', () async {
      // TODO
    });

    //Future<UserAdminList200Response> userAdminList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test userAdminList', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> userAdminRemove(String id) async
    test('test userAdminRemove', () async {
      // TODO
    });

    //Future<UserAdminCreate200Response> userAdminUpdate(String id, AdminUpdateUser adminUpdateUser) async
    test('test userAdminUpdate', () async {
      // TODO
    });
  });
}
