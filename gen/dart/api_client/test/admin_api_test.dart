import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for AdminApi
void main() {
  final instance = ApiClient().getAdminApi();

  group(AdminApi, () {
    //Future<UserAdminCreate200Response> userAdminCreate(InsertUser insertUser) async
    test('test userAdminCreate', () async {
      // TODO
    });

    //Future<UserAdminCreate200Response> userAdminGet(String id) async
    test('test userAdminGet', () async {
      // TODO
    });

    //Future<UserAdminList200Response> userAdminList({ String cursor, Object limit, Object page, String query, String sortBy, String order }) async
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
