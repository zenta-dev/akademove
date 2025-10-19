import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class AuthRepository extends BaseRepository {
  const AuthRepository({
    required this.apiClient,
    required this.localKV,
  });

  final ApiClient apiClient;
  final KeyValueService localKV;

  Future<BaseResponse<User>> signIn(SignInRequest request) async {
    return guard(() async {
      final result = await apiClient.getAuthApi().authSignIn(
        signInRequest: request,
      );

      final data =
          result.data ??
          (throw const RepositoryError(
            'User not found',
            code: ErrorCode.UNKNOWN,
          ));

      apiClient.setBearerAuth('bearer_auth', data.data.token);
      await localKV.set(KeyValueKeys.token, data.data.token);

      return SuccessResponse(message: data.message, data: data.data.user);
    });
  }

  Future<BaseResponse<User>> signUpUser({
    required String name,
    required String email,
    required Phone phone,
    required UserGenderEnum gender,
    required String password,
    required String confirmPassword,
    required MultipartFile? photo,
  }) async {
    return guard(() async {
      final result = await apiClient.getAuthApi().authSignUpUser(
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
            code: ErrorCode.INTERNAL_SERVER_ERROR,
          ));

      return SuccessResponse(message: data.message, data: data.data.user);
    });
  }

  Future<BaseResponse<User>> signUpDriver({
    required String name,
    required String email,
    required Phone phone,
    required UserGenderEnum gender,
    required String password,
    required String confirmPassword,
    required MultipartFile photo,
    required int studentId,
    required String licensePlate,
    required MultipartFile studentCard,
    required MultipartFile driverLicense,
    required MultipartFile vehicleCertificate,
    required BankProviderEnum bankProvider,
    required int bankNumber,
  }) async {
    return guard(() async {
      final result = await apiClient.getAuthApi().authSignUpDriver(
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
        detailBankProvider: bankProvider.value,
        detailBankNumber: bankNumber,
      );

      final data =
          result.data ??
          (throw const RepositoryError(
            'An error occured',
            code: ErrorCode.INTERNAL_SERVER_ERROR,
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
    required Location outletLocation,
    required String outletAddress,

    required BankProviderEnum bankProvider,
    required int bankNumber,

    required MultipartFile? photo,
    required MultipartFile? document,
  }) async {
    return guard(() async {
      final result = await apiClient.getAuthApi().authSignUpMerchant(
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
        detailLocationLat: outletLocation.lat,
        detailLocationLng: outletLocation.lng,
        detailBankProvider: bankProvider.value,
        detailBankNumber: bankNumber,
      );

      final data =
          result.data ??
          (throw const RepositoryError(
            'An error occured',
            code: ErrorCode.INTERNAL_SERVER_ERROR,
          ));

      return SuccessResponse(message: data.message, data: data.data.user);
    });
  }

  Future<BaseResponse<bool>> signOut() async {
    return guard(() async {
      final result = await apiClient.getAuthApi().authSignOut();
      await localKV.remove(KeyValueKeys.token);
      apiClient.setBearerAuth('bearer_auth', '');

      final data =
          result.data ??
          (throw const RepositoryError(
            'An error occured',
            code: ErrorCode.INTERNAL_SERVER_ERROR,
          ));
      return SuccessResponse(message: data.message, data: true);
    });
  }

  Future<BaseResponse<User>> authenticate() async {
    return guard(() async {
      final localToken = await localKV.get<String>(KeyValueKeys.token);
      if (localToken == null) {
        await delay(const Duration(seconds: 1));
        throw const RepositoryError(
          'Session expired',
          code: ErrorCode.BAD_REQUEST,
        );
      }
      apiClient.setBearerAuth('bearer_auth', localToken);
      final result = await apiClient.getAuthApi().authGetSession();

      final data =
          result.data ??
          (throw const RepositoryError(
            'User not found',
            code: ErrorCode.UNKNOWN,
          ));

      final remoteToken = data.data?.token;
      if (remoteToken != null) {
        await localKV.set(KeyValueKeys.token, remoteToken);
        apiClient.setBearerAuth('bearer_auth', remoteToken);
      }

      final remoteUser = data.data?.user;
      if (remoteUser == null) {
        await localKV.remove(KeyValueKeys.token);
        apiClient.setBearerAuth('bearer_auth', '');
        throw const RepositoryError(
          'Session expired',
          code: ErrorCode.UNAUTHORIZED,
        );
      }

      return SuccessResponse(message: data.message, data: remoteUser);
    });
  }
}
