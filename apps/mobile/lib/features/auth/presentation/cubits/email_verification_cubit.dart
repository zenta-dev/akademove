import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

class EmailVerificationCubit extends BaseCubit<EmailVerificationState> {
  EmailVerificationCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(EmailVerificationState.initial());

  final AuthRepository _authRepository;

  void reset() => emit(EmailVerificationState.initial());

  void setEmail(String email) =>
      emit(const EmailVerificationState().copyWith(email: email));

  Future<void> sendVerificationEmail(String email) async =>
      await taskManager.execute('EVC-sVE-$email', () async {
        try {
          emit(EmailVerificationState.loading(email: email));
          final res = await _authRepository.sendEmailVerification(email: email);
          emit(
            EmailVerificationState.success(message: res.message, email: email),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[EmailVerificationCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(EmailVerificationState.failure(e, email: email));
        }
      });

  Future<void> verifyEmail(String token) async =>
      await taskManager.execute('EVC-vE-$token', () async {
        try {
          emit(EmailVerificationState.loading());
          final res = await _authRepository.verifyEmail(token: token);
          emit(EmailVerificationState.success(message: res.message));
        } on BaseError catch (e, st) {
          logger.e(
            '[EmailVerificationCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(EmailVerificationState.failure(e));
        }
      });
}
