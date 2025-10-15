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

    //Future<AuthSignUpUser200Response> authSignUpDriver(String name, String email, String gender, String phone, String password, String confirmPassword, MultipartFile photo, String detailStudentId, String detailLicenseNumber, MultipartFile detailStudentCard, MultipartFile detailDriverLicense, MultipartFile detailVehicleCertificate) async
    test('test authSignUpDriver', () async {
      // TODO
    });

    //Future<AuthSignUpUser200Response> authSignUpMerchant(String name, String email, String gender, String phone, String password, String confirmPassword, String detailType, String detailName, String detailEmail, String detailPhone, String detailAddress, num detailLocationLat, num detailLocationLng, String detailBankProvider, String detailBankNumber, { MultipartFile photo, MultipartFile detailDocument }) async
    test('test authSignUpMerchant', () async {
      // TODO
    });

    //Future<AuthSignUpUser200Response> authSignUpUser(String name, String email, String gender, String phone, String password, String confirmPassword, { MultipartFile photo }) async
    test('test authSignUpUser', () async {
      // TODO
    });
  });
}
