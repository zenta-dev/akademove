import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class AuthRepository extends BaseRepository {
  const AuthRepository({
    required ApiClient apiClient,
    required KeyValueService localKV,
    required WebSocketService ws,
  }) : _apiClient = apiClient,
       _localKV = localKV,
       _ws = ws;

  final ApiClient _apiClient;
  final KeyValueService _localKV;
  final WebSocketService _ws;

  Future<BaseResponse<User>> signIn(SignInRequest request) async {
    return guard(() async {
      final result = await _apiClient.getAuthApi().authSignIn(
        signInRequest: request,
      );

      final data =
          result.data ??
          (throw const RepositoryError(
            'Failed to sign in',
            code: ErrorCode.unknown,
          ));

      _apiClient.setBearerAuth('bearer_auth', data.data.token);
      _ws.sessionToken = data.data.token;
      await _localKV.set(KeyValueKeys.token, data.data.token);

      return SuccessResponse(message: data.message, data: data.data.user);
    });
  }

  Future<BaseResponse<User>> signUpUser({
    required String name,
    required String email,
    required Phone phone,
    required UserGender gender,
    required String password,
    required String confirmPassword,
    required MultipartFile? photo,
  }) async {
    return guard(() async {
      final result = await _apiClient.getAuthApi().authSignUpUser(
        name: name.trim(),
        email: email.trim(),
        gender: gender.value.trim(),
        phoneCountryCode: phone.countryCode.value,
        phoneNumber: phone.number,
        password: password.trim(),
        confirmPassword: confirmPassword.trim(),
        photo: photo,
      );

      final data =
          result.data ??
          (throw const RepositoryError(
            'An error occured',
            code: ErrorCode.internalServerError,
          ));

      return SuccessResponse(message: data.message, data: data.data.user);
    });
  }

  Future<BaseResponse<User>> signUpDriver({
    required String name,
    required String email,
    required Phone phone,
    required UserGender gender,
    required String password,
    required String confirmPassword,
    required MultipartFile photo,
    required int studentId,
    required String licensePlate,
    required MultipartFile studentCard,
    required MultipartFile driverLicense,
    required MultipartFile vehicleCertificate,
    required Bank bank,
  }) async {
    return guard(() async {
      final result = await _apiClient.getAuthApi().authSignUpDriver(
        name: name.trim(),
        email: email.trim(),
        gender: gender.value,
        phoneCountryCode: phone.countryCode.value,
        phoneNumber: phone.number,
        password: password.trim(),
        confirmPassword: confirmPassword.trim(),
        photo: photo,
        detailStudentId: studentId,
        detailLicensePlate: licensePlate.trim(),
        detailStudentCard: studentCard,
        detailDriverLicense: driverLicense,
        detailVehicleCertificate: vehicleCertificate,
        detailBankProvider: bank.provider.value,
        detailBankNumber: bank.number,
      );

      final data =
          result.data ??
          (throw const RepositoryError(
            'An error occured',
            code: ErrorCode.internalServerError,
          ));

      return SuccessResponse(message: data.message, data: data.data.user);
    });
  }

  Future<BaseResponse<User>> signUpMerchant({
    required String ownerName,
    required String ownerEmail,
    required Phone ownerPhone,
    required String ownerPassword,
    required String ownerConfirmPassword,

    required String outletName,
    required String outletEmail,
    required Phone outletPhone,
    required Coordinate outletLocation,
    required String outletAddress,

    required Bank bank,

    required MultipartFile? photo,
    required MultipartFile? document,
  }) async {
    return guard(() async {
      final result = await _apiClient.getAuthApi().authSignUpMerchant(
        name: ownerName.trim(),
        email: ownerEmail.trim(),
        phoneCountryCode: ownerPhone.countryCode.value,
        phoneNumber: ownerPhone.number,
        password: ownerPassword.trim(),
        confirmPassword: ownerConfirmPassword.trim(),
        detailName: outletName.trim(),
        detailEmail: outletEmail.trim(),
        detailPhoneCountryCode: outletPhone.countryCode.value,
        detailPhoneNumber: outletPhone.number,
        detailAddress: outletAddress.trim(),
        detailLocationX: outletLocation.x,
        detailLocationY: outletLocation.y,
        detailBankProvider: bank.provider.value,
        detailBankNumber: bank.number,
        photo: photo,
        detailDocument: document,
      );

      final data =
          result.data ??
          (throw const RepositoryError(
            'An error occured',
            code: ErrorCode.internalServerError,
          ));

      return SuccessResponse(message: data.message, data: data.data.user);
    });
  }

  Future<BaseResponse<bool>> signOut() async {
    return guard(() async {
      final result = await _apiClient.getAuthApi().authSignOut();
      await _localKV.remove(KeyValueKeys.token);
      _apiClient.setBearerAuth('bearer_auth', '');

      final data =
          result.data ??
          (throw const RepositoryError(
            'An error occured',
            code: ErrorCode.internalServerError,
          ));
      return SuccessResponse(message: data.message, data: true);
    });
  }

  Future<BaseResponse<User>> authenticate() async {
    return guard(() async {
      final localToken = await _localKV.get<String>(KeyValueKeys.token);
      if (localToken == null) {
        await delay(const Duration(seconds: 1));
        throw const RepositoryError(
          'Session expired',
          code: ErrorCode.badRequest,
        );
      }
      _apiClient.setBearerAuth('bearer_auth', localToken);
      _ws.sessionToken = localToken;
      final result = await _apiClient.getAuthApi().authGetSession();

      final data =
          result.data ??
          (throw const RepositoryError(
            'User not found',
            code: ErrorCode.unknown,
          ));

      final remoteToken = data.data?.token;
      if (remoteToken != null) {
        await _localKV.set(KeyValueKeys.token, remoteToken);
        _apiClient.setBearerAuth('bearer_auth', remoteToken);
        _ws.sessionToken = remoteToken;
      }

      final remoteUser = data.data?.user;
      if (remoteUser == null) {
        await _localKV.remove(KeyValueKeys.token);
        _apiClient.setBearerAuth('bearer_auth', '');

        throw const RepositoryError(
          'Session expired',
          code: ErrorCode.unathorized,
        );
      }

      return SuccessResponse(message: data.message, data: remoteUser);
    });
  }
}
