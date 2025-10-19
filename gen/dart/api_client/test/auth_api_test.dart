import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for AuthApi
void main() {
  final instance = ApiClient().getAuthApi();

  group(AuthApi, () {
    //Future<AuthSignOut200Response> authForgotPassword(AuthForgotPasswordRequest authForgotPasswordRequest) async
    test('test authForgotPassword', () async {
      // TODO
    });

    //Future<AuthGetSession200Response> authGetSession() async
    test('test authGetSession', () async {
      // TODO
    });

    //Future<AuthHasPermission200Response> authHasPermission(AuthHasPermissionRequest authHasPermissionRequest) async
    test('test authHasPermission', () async {
      // TODO
    });

    //Future<AuthSignOut200Response> authResetPassword(AuthResetPasswordRequest authResetPasswordRequest) async
    test('test authResetPassword', () async {
      // TODO
    });

    //Future<AuthSignIn200Response> authSignIn(AuthSignInRequest authSignInRequest) async
    test('test authSignIn', () async {
      // TODO
    });

    //Future<AuthSignOut200Response> authSignOut() async
    test('test authSignOut', () async {
      // TODO
    });

    //Future<AuthSignUpUser201Response> authSignUpDriver(String name, String email, String phoneCountryCode, num phoneNumber, String password, String confirmPassword, MultipartFile photo, num detailStudentId, String detailLicensePlate, MultipartFile detailStudentCard, MultipartFile detailDriverLicense, MultipartFile detailVehicleCertificate, String detailBankProvider, num detailBankNumber, { String gender }) async
    test('test authSignUpDriver', () async {
      // TODO
    });

    //Future<AuthSignUpUser201Response> authSignUpMerchant(String name, String email, String phoneCountryCode, num phoneNumber, String password, String confirmPassword, String detailName, String detailEmail, String detailPhoneCountryCode, num detailPhoneNumber, String detailAddress, num detailLocationLat, num detailLocationLng, String detailBankProvider, num detailBankNumber, { MultipartFile photo, String gender, MultipartFile detailDocument }) async
    test('test authSignUpMerchant', () async {
      // TODO
    });

    //Future<AuthSignUpUser201Response> authSignUpUser(String name, String email, String phoneCountryCode, num phoneNumber, String password, String confirmPassword, { MultipartFile photo, String gender }) async
    test('test authSignUpUser', () async {
      // TODO
    });
  });
}
