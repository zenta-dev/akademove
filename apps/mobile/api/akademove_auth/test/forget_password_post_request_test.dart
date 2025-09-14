import 'package:test/test.dart';
import 'package:akademove_auth/akademove_auth.dart';

// tests for ForgetPasswordPostRequest
void main() {
  final instance = ForgetPasswordPostRequestBuilder();
  // TODO add properties to the builder and call build()

  group(ForgetPasswordPostRequest, () {
    // The email address of the user to send a password reset email to
    // String email
    test('to test the property `email`', () async {
      // TODO
    });

    // The URL to redirect the user to reset their password. If the token isn't valid or expired, it'll be redirected with a query parameter `?error=INVALID_TOKEN`. If the token is valid, it'll be redirected with a query parameter `?token=VALID_TOKEN
    // String redirectTo
    test('to test the property `redirectTo`', () async {
      // TODO
    });
  });
}
