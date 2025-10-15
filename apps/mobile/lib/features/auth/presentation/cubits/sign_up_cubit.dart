import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class SignUpCubit extends BaseCubit<SignUpState> {
  SignUpCubit(this._authRepository) : super(SignUpState.initial());

  final AuthRepository _authRepository;

  @override
  Future<void> init() async {}

  @override
  void reset() => emit(SignUpState.initial());

  Future<void> signUpUser({
    required String name,
    required String email,
    required String phone,
    required UserGenderEnum gender,
    required String password,
    required String confirmPassword,
    required String? photoPath,
  }) async {
    try {
      emit(SignUpState.initial());
      final photo = photoPath != null
          ? await MultipartFile.fromFile(photoPath)
          : null;
      final res = await _authRepository.signUpUser(
        name: name,
        email: email,
        phone: phone,
        gender: gender,
        password: password,
        confirmPassword: confirmPassword,
        photo: photo,
      );
      emit(SignUpState.success(res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e('[SignUpCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(SignUpState.failure(e));
    }
  }
}
