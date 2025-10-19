import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for UserApi
void main() {
  final instance = ApiClient().getUserApi();

  group(UserApi, () {
    //Future<UserCreate200Response> userCreate(InsertUserRequest insertUserRequest) async
    test('test userCreate', () async {
      // TODO
    });

    //Future<UserCreate200Response> userGet(String id) async
    test('test userGet', () async {
      // TODO
    });

    //Future<UserList200Response> userList({ String cursor, Object limit, Object page, String query, String sortBy, String order }) async
    test('test userList', () async {
      // TODO
    });

    //Future<DriverRemove200Response> userRemove(String id) async
    test('test userRemove', () async {
      // TODO
    });

    //Future<UserCreate200Response> userUpdate(String id, UserUpdateRequest userUpdateRequest) async
    test('test userUpdate', () async {
      // TODO
    });
  });
}
