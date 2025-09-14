import 'package:test/test.dart';
import 'package:auth_client/auth_client.dart';

// tests for SocialSignInRequest
void main() {
  final instance = SocialSignInRequestBuilder();
  // TODO add properties to the builder and call build()

  group(SocialSignInRequest, () {
    // Callback URL to redirect to after the user has signed in
    // String callbackURL
    test('to test the property `callbackURL`', () async {
      // TODO
    });

    // String newUserCallbackURL
    test('to test the property `newUserCallbackURL`', () async {
      // TODO
    });

    // Callback URL to redirect to if an error happens
    // String errorCallbackURL
    test('to test the property `errorCallbackURL`', () async {
      // TODO
    });

    // String provider
    test('to test the property `provider`', () async {
      // TODO
    });

    // Disable automatic redirection to the provider. Useful for handling the redirection yourself
    // bool disableRedirect
    test('to test the property `disableRedirect`', () async {
      // TODO
    });

    // SocialSignInRequestIdToken idToken
    test('to test the property `idToken`', () async {
      // TODO
    });

    // Array of scopes to request from the provider. This will override the default scopes passed.
    // BuiltList<JsonObject> scopes
    test('to test the property `scopes`', () async {
      // TODO
    });

    // Explicitly request sign-up. Useful when disableImplicitSignUp is true for this provider
    // bool requestSignUp
    test('to test the property `requestSignUp`', () async {
      // TODO
    });

    // The login hint to use for the authorization code request
    // String loginHint
    test('to test the property `loginHint`', () async {
      // TODO
    });

  });
}
