import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class SignInCubit extends BaseCubit<SignInState> {
  SignInCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(SignInState.initial());
  final AuthRepository _authRepository;

  Future<void> signIn(String email, String password) async {
    try {
      emit(SignInState.loading());
      final res = await _authRepository.signIn(
        SignInRequest(email: email, password: password),
      );
      emit(SignInState.success(res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e('[SignInCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(SignInState.failure(e));
    }
  }

  void reset() => emit(SignInState.initial());
}
