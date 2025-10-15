import 'package:akademove/core/base.dart';
import 'package:akademove/core/errors.dart';
import 'package:akademove/core/helpers.dart';
import 'package:akademove/core/response.dart';
import 'package:akademove/core/services/kv_service.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class AuthRepository extends BaseRepository {
  const AuthRepository({
    required this.apiClient,
    required this.localKV,
  });

  final ApiClient apiClient;
  final KeyValueService localKV;

  Future<BaseResponse<User>> signIn(AuthSignInRequest request) async {
    return guard(() async {
      final result = await apiClient.getAuthApi().authSignIn(
        authSignInRequest: request,
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
    required String phone,
    required UserGenderEnum gender,
    required String password,
    required String confirmPassword,
    required MultipartFile? photo,
  }) async {
    return guard(() async {
      final result = await apiClient.getAuthApi().authSignUpUser(
        name: name,
        email: email,
        gender: gender.value,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
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

  Future<bool> signOut() async {
    return guard(() async {
      await Future.wait([
        apiClient.getAuthApi().authSignOut(),
        localKV.remove(KeyValueKeys.token),
      ]);
      apiClient.setBearerAuth('bearer_auth', '');
      return true;
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
