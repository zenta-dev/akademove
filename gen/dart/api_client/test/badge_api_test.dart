import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for BadgeApi
void main() {
  final instance = ApiClient().getBadgeApi();

  group(BadgeApi, () {
    //Future<BadgeCreate200Response> badgeCreate(BadgeCreateRequest badgeCreateRequest) async
    test('test badgeCreate', () async {
      // TODO
    });

    //Future<BadgeCreate200Response> badgeGet(String id) async
    test('test badgeGet', () async {
      // TODO
    });

    //Future<BadgeList200Response> badgeList({ String cursor, Object limit, Object page, String query, String sortBy, String order }) async
    test('test badgeList', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> badgeRemove(String id) async
    test('test badgeRemove', () async {
      // TODO
    });

    //Future<BadgeCreate200Response> badgeUpdate(String id, BadgeUpdateRequest badgeUpdateRequest) async
    test('test badgeUpdate', () async {
      // TODO
    });

    //Future<BadgeUserCreate200Response> badgeUserCreate(BadgeUserCreateRequest badgeUserCreateRequest) async
    test('test badgeUserCreate', () async {
      // TODO
    });

    //Future<BadgeUserCreate200Response> badgeUserGet(String id) async
    test('test badgeUserGet', () async {
      // TODO
    });

    //Future<BadgeUserList200Response> badgeUserList({ String cursor, Object limit, Object page, String query, String sortBy, String order }) async
    test('test badgeUserList', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> badgeUserRemove(String id) async
    test('test badgeUserRemove', () async {
      // TODO
    });

    //Future<BadgeUserCreate200Response> badgeUserUpdate(String id, BadgeUserUpdateRequest badgeUserUpdateRequest) async
    test('test badgeUserUpdate', () async {
      // TODO
    });
  });
}
