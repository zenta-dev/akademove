import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for UserApi
void main() {
  final instance = ApiClient().getUserApi();

  group(UserApi, () {
    //Future<ContactSubmit201Response> contactSubmit(InsertContact insertContact) async
    test('test contactSubmit', () async {
      // TODO
    });

    //Future<AuthHasPermission200Response> userMeChangePassword(UpdateUserPassword updateUserPassword) async
    test('test userMeChangePassword', () async {
      // TODO
    });

    //Future<UserAdminCreate200Response> userMeUpdate({ String name, String email, MultipartFile photo, String phoneCountryCode, int phoneNumber }) async
    test('test userMeUpdate', () async {
      // TODO
    });
  });
}
