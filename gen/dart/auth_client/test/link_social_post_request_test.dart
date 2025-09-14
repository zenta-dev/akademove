import 'package:test/test.dart';
import 'package:auth_client/auth_client.dart';

// tests for LinkSocialPostRequest
void main() {
  final instance = LinkSocialPostRequestBuilder();
  // TODO add properties to the builder and call build()

  group(LinkSocialPostRequest, () {
    // The URL to redirect to after the user has signed in
    // String callbackURL
    test('to test the property `callbackURL`', () async {
      // TODO
    });

    // String provider
    test('to test the property `provider`', () async {
      // TODO
    });

    // LinkSocialPostRequestIdToken idToken
    test('to test the property `idToken`', () async {
      // TODO
    });

    // bool requestSignUp
    test('to test the property `requestSignUp`', () async {
      // TODO
    });

    // Additional scopes to request from the provider
    // BuiltList<JsonObject> scopes
    test('to test the property `scopes`', () async {
      // TODO
    });

    // The URL to redirect to if there is an error during the link process
    // String errorCallbackURL
    test('to test the property `errorCallbackURL`', () async {
      // TODO
    });

    // Disable automatic redirection to the provider. Useful for handling the redirection yourself
    // bool disableRedirect
    test('to test the property `disableRedirect`', () async {
      // TODO
    });

  });
}
