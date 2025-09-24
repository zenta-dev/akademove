import 'package:test/test.dart';
import 'package:auth_client/auth_client.dart';


/// tests for AdminApi
void main() {
  final instance = AuthClient().getAdminApi();

  group(AdminApi, () {
    // Check if the user has permission
    //
    //Future<AdminHasPermissionPost200Response> adminHasPermissionPost({ AdminHasPermissionPostRequest adminHasPermissionPostRequest }) async
    test('test adminHasPermissionPost', () async {
      // TODO
    });

    //Future adminStopImpersonatingPost() async
    test('test adminStopImpersonatingPost', () async {
      // TODO
    });

    // Ban a user
    //
    //Future<SetRole200Response> banUser(BanUserRequest banUserRequest) async
    test('test banUser', () async {
      // TODO
    });

    // Create a new user
    //
    //Future<SetRole200Response> createUser(CreateUserRequest createUserRequest) async
    test('test createUser', () async {
      // TODO
    });

    // Get an existing user
    //
    //Future<SetRole200Response> getUser({ String id }) async
    test('test getUser', () async {
      // TODO
    });

    // Impersonate a user
    //
    //Future<ImpersonateUser200Response> impersonateUser(ListUserSessionsRequest listUserSessionsRequest) async
    test('test impersonateUser', () async {
      // TODO
    });

    // List user sessions
    //
    //Future<ListUserSessions200Response> listUserSessions(ListUserSessionsRequest listUserSessionsRequest) async
    test('test listUserSessions', () async {
      // TODO
    });

    // List users
    //
    //Future<ListUsers200Response> listUsers({ String searchValue, String searchField, String searchOperator, String limit, String offset, String sortBy, String sortDirection, String filterField, String filterValue, String filterOperator }) async
    test('test listUsers', () async {
      // TODO
    });

    // Delete a user and all their sessions and accounts. Cannot be undone.
    //
    //Future<SignOutPost200Response> removeUser(ListUserSessionsRequest listUserSessionsRequest) async
    test('test removeUser', () async {
      // TODO
    });

    // Revoke a user session
    //
    //Future<SignOutPost200Response> revokeUserSession(RevokeUserSessionRequest revokeUserSessionRequest) async
    test('test revokeUserSession', () async {
      // TODO
    });

    // Revoke all user sessions
    //
    //Future<SignOutPost200Response> revokeUserSessions(ListUserSessionsRequest listUserSessionsRequest) async
    test('test revokeUserSessions', () async {
      // TODO
    });

    // Set the role of a user
    //
    //Future<SetRole200Response> setRole(SetRoleRequest setRoleRequest) async
    test('test setRole', () async {
      // TODO
    });

    // Set a user's password
    //
    //Future<ResetPasswordPost200Response> setUserPassword(SetUserPasswordRequest setUserPasswordRequest) async
    test('test setUserPassword', () async {
      // TODO
    });

    // Unban a user
    //
    //Future<SetRole200Response> unbanUser(ListUserSessionsRequest listUserSessionsRequest) async
    test('test unbanUser', () async {
      // TODO
    });

    // Update a user's details
    //
    //Future<SetRole200Response> updateUser(UpdateUserRequest updateUserRequest) async
    test('test updateUser', () async {
      // TODO
    });

  });
}
