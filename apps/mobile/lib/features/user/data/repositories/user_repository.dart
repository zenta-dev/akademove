import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class UpdateProfileRequest {
  const UpdateProfileRequest({
    this.name,
    this.email,
    this.photoPath,
    this.phone,
  });

  final String? name;
  final String? email;
  final String? photoPath;
  final Phone? phone;
}

class UserRepository extends BaseRepository {
  const UserRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<User>> updateProfile(UpdateProfileRequest req) =>
      guard(() async {
        final photoPath = req.photoPath;
        final photo = photoPath != null
            ? await MultipartFile.fromFile(photoPath)
            : null;
        final res = await _apiClient.getUserApi().userMeUpdate(
          name: req.name?.trim(),
          email: req.email?.trim(),
          photo: photo,
          phoneCountryCode: req.phone?.countryCode.value,
          phoneNumber: req.phone?.number,
        );
        final data =
            res.data ??
            (throw const RepositoryError(
              'An error occured',
              code: ErrorCode.internalServerError,
            ));

        return SuccessResponse(message: data.message, data: data.data);
      });

  Future<BaseResponse<bool>> updatePassword(UserMeChangePasswordRequest req) =>
      guard(() async {
        final res = await _apiClient.getUserApi().userMeChangePassword(
          userMeChangePasswordRequest: req,
        );
        final data =
            res.data ??
            (throw const RepositoryError(
              'An error occured',
              code: ErrorCode.internalServerError,
            ));

        return SuccessResponse(message: data.message, data: data.data);
      });
}
