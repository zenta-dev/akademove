import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthState.initial());

  final AuthRepository _authRepository;

  Future<void> init() async {
    await authenticate();
  }

  Future<void> authenticate() async => await taskManager.execute(
    'AC-a1',
    () async {
      try {
        emit(AuthState.loading());
        final res = await _authRepository.authenticate();
        emit(AuthState.success(res.data, message: res.message));
      } on BaseError catch (e, st) {
        logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
        emit(AuthState.failure(e));
      }
    },
  );

  Future<void> signOut() async => await taskManager.execute('AC-sO1', () async {
    try {
      emit(AuthState.loading());
      final res = await _authRepository.signOut();
      emit(AuthState.success(null, message: res.message));
    } on BaseError catch (e, st) {
      logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(AuthState.failure(e));
    }
  });

  Future<void> forgotPassword(String email) async => await taskManager.execute(
    'AC-fP1',
    () async {
      try {
        emit(AuthState.loading());
        final res = await _authRepository.forgotPassword(email: email);
        emit(AuthState.success(null, message: res.message));
      } on BaseError catch (e, st) {
        logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
        emit(AuthState.failure(e));
      }
    },
  );

  Future<void> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async => await taskManager.execute('AC-rP1', () async {
    try {
      emit(AuthState.loading());
      final res = await _authRepository.resetPassword(
        token: token,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      emit(AuthState.success(null, message: res.message));
    } on BaseError catch (e, st) {
      logger.e('[AuthCubit] - Error: ${e.message}', error: e, stackTrace: st);
      emit(AuthState.failure(e));
    }
  });

  void reset() => emit(AuthState.initial());
}
