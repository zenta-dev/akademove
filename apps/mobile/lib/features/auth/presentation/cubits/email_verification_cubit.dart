import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';

enum EmailVerificationStep { requestCode, verifyCode }

typedef _EmailState = ({EmailVerificationStep step, String? email});
typedef EmailVerificationState = OperationResult<_EmailState>;

class EmailVerificationCubit extends BaseCubit<EmailVerificationState> {
  EmailVerificationCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(OperationResult.idle());

  String? email;

  final AuthRepository _authRepository;

  void reset() => emit(OperationResult.idle());

  void setEmail(String email) => this.email = email;

  Future<void> sendVerificationEmail(String email) async =>
      await taskManager.execute('EVC-sVE-$email', () async {
        try {
          emit(OperationResult.loading());
          final res = await _authRepository.sendEmailVerification(email: email);
          emit(
            OperationResult.success((
              step: EmailVerificationStep.requestCode,
              email: email,
            ), message: res.message),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[EmailVerificationCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(OperationResult.failed(e));
        }
      });

  Future<void> verifyEmail({
    required String email,
    required String code,
  }) async => await taskManager.execute('EVC-vE-$email', () async {
    try {
      emit(OperationResult.loading());
      final res = await _authRepository.verifyEmail(email: email, code: code);
      emit(
        OperationResult.success((
          step: EmailVerificationStep.verifyCode,
          email: email,
        ), message: res.message),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[EmailVerificationCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(OperationResult.failed(e));
    }
  });
}
