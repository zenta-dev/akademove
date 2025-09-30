import 'dart:developer';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:auth_client/auth_client.dart' as auth;

class SignInCubit extends BaseCubit<SignInState> {
  SignInCubit(this._authRepository) : super(SignInState.initial());
  final AuthRepository _authRepository;

  @override
  Future<void> init() async {}

  Future<void> signIn(String email, String password) async {
    try {
      final res = await _authRepository.signIn(
        auth.SignInEmailPostRequest(
          (b) => b
            ..email = email
            ..password = password
            ..rememberMe = true,
        ),
      );

      emit(SignInState.success(res));
    } on BaseError catch (e, st) {
      log('[SignInCubit] - Error: ${e.message}', stackTrace: st);
      emit(SignInState.failure(e));
    }
  }
}
