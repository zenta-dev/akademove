import 'dart:developer';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class SignInCubit extends BaseCubit<SignInState> {
  SignInCubit(this._authRepository) : super(SignInState.initial());
  final AuthRepository _authRepository;

  @override
  Future<void> init() async {}

  Future<void> signIn(String email, String password) async {
    try {
      emit(SignInState.loading());
      final res = await _authRepository.signIn(
        AuthSignInRequest(email: email, password: password),
      );
      emit(SignInState.success(res.data, message: res.message));
    } on BaseError catch (e, st) {
      log('[SignInCubit] - Error: ${e.message}', stackTrace: st);
      emit(SignInState.failure(e));
    }
  }

  @override
  void reset() => emit(SignInState.initial());
}
