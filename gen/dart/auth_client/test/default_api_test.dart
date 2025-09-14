import 'package:test/test.dart';
import 'package:auth_client/auth_client.dart';


/// tests for DefaultApi
void main() {
  final instance = AuthClient().getDefaultApi();

  group(DefaultApi, () {
    // Get the account info provided by the provider
    //
    //Future<AccountInfoPost200Response> accountInfoPost(AccountInfoPostRequest accountInfoPostRequest) async
    test('test accountInfoPost', () async {
      // TODO
    });

    //Future<ChangeEmailPost200Response> changeEmailPost(ChangeEmailPostRequest changeEmailPostRequest) async
    test('test changeEmailPost', () async {
      // TODO
    });

    // Change the password of the user
    //
    //Future<ChangePasswordPost200Response> changePasswordPost(ChangePasswordPostRequest changePasswordPostRequest) async
    test('test changePasswordPost', () async {
      // TODO
    });

    // Callback to complete user deletion with verification token
    //
    //Future<DeleteUserCallbackGet200Response> deleteUserCallbackGet({ String token, String callbackURL }) async
    test('test deleteUserCallbackGet', () async {
      // TODO
    });

    // Delete the user
    //
    //Future<DeleteUserPost200Response> deleteUserPost(DeleteUserPostRequest deleteUserPostRequest) async
    test('test deleteUserPost', () async {
      // TODO
    });

    // Displays an error page
    //
    //Future<String> errorGet() async
    test('test errorGet', () async {
      // TODO
    });

    // Send a password reset email to the user
    //
    //Future<ForgetPasswordPost200Response> forgetPasswordPost(ForgetPasswordPostRequest forgetPasswordPostRequest) async
    test('test forgetPasswordPost', () async {
      // TODO
    });

    // Get a valid access token, doing a refresh if needed
    //
    //Future<RefreshTokenPost200Response> getAccessTokenPost(RefreshTokenPostRequest refreshTokenPostRequest) async
    test('test getAccessTokenPost', () async {
      // TODO
    });

    // Get the current session
    //
    //Future<GetSessionGet200Response> getSessionGet() async
    test('test getSessionGet', () async {
      // TODO
    });

    // Link a social account to the user
    //
    //Future<LinkSocialPost200Response> linkSocialPost(LinkSocialPostRequest linkSocialPostRequest) async
    test('test linkSocialPost', () async {
      // TODO
    });

    // List all accounts linked to the user
    //
    //Future<BuiltList<ListAccountsGet200ResponseInner>> listAccountsGet() async
    test('test listAccountsGet', () async {
      // TODO
    });

    // List all active sessions for the user
    //
    //Future<BuiltList<Session>> listSessionsGet() async
    test('test listSessionsGet', () async {
      // TODO
    });

    // Check if the API is working
    //
    //Future<OkGet200Response> okGet() async
    test('test okGet', () async {
      // TODO
    });

    // Refresh the access token using a refresh token
    //
    //Future<RefreshTokenPost200Response> refreshTokenPost(RefreshTokenPostRequest refreshTokenPostRequest) async
    test('test refreshTokenPost', () async {
      // TODO
    });

    // Send a password reset email to the user
    //
    //Future<ForgetPasswordPost200Response> requestPasswordResetPost(ForgetPasswordPostRequest forgetPasswordPostRequest) async
    test('test requestPasswordResetPost', () async {
      // TODO
    });

    // Reset the password for a user
    //
    //Future<ResetPasswordPost200Response> resetPasswordPost(ResetPasswordPostRequest resetPasswordPostRequest) async
    test('test resetPasswordPost', () async {
      // TODO
    });

    // Redirects the user to the callback URL with the token
    //
    //Future<ResetPasswordTokenGet200Response> resetPasswordTokenGet(String token, { String callbackURL }) async
    test('test resetPasswordTokenGet', () async {
      // TODO
    });

    // Revoke all other sessions for the user except the current one
    //
    //Future<RevokeOtherSessionsPost200Response> revokeOtherSessionsPost({ JsonObject body }) async
    test('test revokeOtherSessionsPost', () async {
      // TODO
    });

    // Revoke a single session
    //
    //Future<RevokeSessionPost200Response> revokeSessionPost({ RevokeSessionPostRequest revokeSessionPostRequest }) async
    test('test revokeSessionPost', () async {
      // TODO
    });

    // Revoke all sessions for the user
    //
    //Future<RevokeSessionsPost200Response> revokeSessionsPost({ JsonObject body }) async
    test('test revokeSessionsPost', () async {
      // TODO
    });

    // Send a verification email to the user
    //
    //Future<SendVerificationEmailPost200Response> sendVerificationEmailPost({ SendVerificationEmailPostRequest sendVerificationEmailPostRequest }) async
    test('test sendVerificationEmailPost', () async {
      // TODO
    });

    // Sign in with email and password
    //
    //Future<SignInEmailPost200Response> signInEmailPost(SignInEmailPostRequest signInEmailPostRequest) async
    test('test signInEmailPost', () async {
      // TODO
    });

    // Sign out the current user
    //
    //Future<SignOutPost200Response> signOutPost({ JsonObject body }) async
    test('test signOutPost', () async {
      // TODO
    });

    // Sign up a user using email and password
    //
    //Future<SignUpEmailPost200Response> signUpEmailPost({ SignUpEmailPostRequest signUpEmailPostRequest }) async
    test('test signUpEmailPost', () async {
      // TODO
    });

    // Sign in with a social provider
    //
    //Future<SocialSignIn200Response> socialSignIn(SocialSignInRequest socialSignInRequest) async
    test('test socialSignIn', () async {
      // TODO
    });

    // Unlink an account
    //
    //Future<ResetPasswordPost200Response> unlinkAccountPost(UnlinkAccountPostRequest unlinkAccountPostRequest) async
    test('test unlinkAccountPost', () async {
      // TODO
    });

    // Update the current user
    //
    //Future<UpdateUserPost200Response> updateUserPost({ UpdateUserPostRequest updateUserPostRequest }) async
    test('test updateUserPost', () async {
      // TODO
    });

    // Verify the email of the user
    //
    //Future<VerifyEmailGet200Response> verifyEmailGet(String token, { String callbackURL }) async
    test('test verifyEmailGet', () async {
      // TODO
    });

  });
}
