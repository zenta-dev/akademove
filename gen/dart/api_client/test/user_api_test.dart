import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for UserApi
void main() {
  final instance = ApiClient().getUserApi();

  group(UserApi, () {
    //Future<AuthHasPermission200Response> userMeChangePassword(UpdateUserPassword updateUserPassword) async
    test('test userMeChangePassword', () async {
      // TODO
    });

    //Future<UserAdminCreate200Response> userMeUpdate(String phoneCountryCode, num phoneNumber, { String name, String email, MultipartFile photo }) async
    test('test userMeUpdate', () async {
      // TODO
    });
  });
}
