import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for AuthApi
void main() {
  final instance = ApiClient().getAuthApi();

  group(AuthApi, () {
    //Future<AuthExchangeToken200Response> authExchangeToken() async
    test('test authExchangeToken', () async {
      // TODO
    });

    //Future<AuthSignOut200Response> authForgotPassword(AuthForgotPasswordRequest authForgotPasswordRequest) async
    test('test authForgotPassword', () async {
      // TODO
    });

    //Future<AuthGetSession200Response> authGetSession() async
    test('test authGetSession', () async {
      // TODO
    });

    //Future<AuthSignOut200Response> authHasAccess(AuthHasAccessRequest authHasAccessRequest) async
    test('test authHasAccess', () async {
      // TODO
    });

    //Future<AuthSignOut200Response> authResetPassword(ResetPassword resetPassword) async
    test('test authResetPassword', () async {
      // TODO
    });

    //Future<AuthSignOut200Response> authSendEmailVerification(SendEmailVerification sendEmailVerification) async
    test('test authSendEmailVerification', () async {
      // TODO
    });

    //Future<AuthSignIn200Response> authSignIn(SignInRequest signInRequest) async
    test('test authSignIn', () async {
      // TODO
    });

    //Future<AuthSignOut200Response> authSignOut() async
    test('test authSignOut', () async {
      // TODO
    });

    //Future<AuthSignUpUser201Response> authSignUpDriver(String name, String email, String phoneCountryCode, int phoneNumber, String password, String confirmPassword, MultipartFile photo, num detailStudentId, String detailLicensePlate, String detailBankProvider, num detailBankNumber, MultipartFile detailStudentCard, MultipartFile detailDriverLicense, MultipartFile detailVehicleCertificate, { String gender, String detailBankAccountName }) async
    test('test authSignUpDriver', () async {
      // TODO
    });

    //Future<AuthSignUpUser201Response> authSignUpMerchant(String name, String email, String phoneCountryCode, int phoneNumber, String password, String confirmPassword, String detailName, String detailEmail, String detailPhoneCountryCode, int detailPhoneNumber, String detailAddress, num detailLocationX, num detailLocationY, String detailCategory, String detailBankProvider, num detailBankNumber, { MultipartFile photo, String gender, String detailBankAccountName, MultipartFile detailDocument, MultipartFile detailImage }) async
    test('test authSignUpMerchant', () async {
      // TODO
    });

    //Future<AuthSignUpUser201Response> authSignUpUser(String name, String email, String phoneCountryCode, int phoneNumber, String password, String confirmPassword, { MultipartFile photo, String gender }) async
    test('test authSignUpUser', () async {
      // TODO
    });

    //Future<AuthVerifyEmail200Response> authVerifyEmail(VerifyEmail verifyEmail) async
    test('test authVerifyEmail', () async {
      // TODO
    });
  });
}
