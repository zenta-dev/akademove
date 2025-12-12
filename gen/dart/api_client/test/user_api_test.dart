import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for UserApi
void main() {
  final instance = ApiClient().getUserApi();

  group(UserApi, () {
    //Future<AccountDeletionSubmit201Response> accountDeletionSubmit(InsertAccountDeletion insertAccountDeletion) async
    test('test accountDeletionSubmit', () async {
      // TODO
    });

    //Future<ContactSubmit201Response> contactSubmit(InsertContact insertContact) async
    test('test contactSubmit', () async {
      // TODO
    });

    // Lookup user by phone number for wallet transfer. Returns minimal user info with masked phone number for privacy.
    //
    //Future<UserLookupByPhone200Response> userLookupByPhone(String phone) async
    test('test userLookupByPhone', () async {
      // TODO
    });

    //Future<AuthSignOut200Response> userMeChangePassword(UserMeChangePasswordRequest userMeChangePasswordRequest) async
    test('test userMeChangePassword', () async {
      // TODO
    });

    //Future<UserAdminCreate200Response> userMeUpdate({ String name, String email, MultipartFile photo, String phoneCountryCode, int phoneNumber }) async
    test('test userMeUpdate', () async {
      // TODO
    });
  });
}
