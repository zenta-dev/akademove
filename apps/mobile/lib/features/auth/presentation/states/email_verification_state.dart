import 'package:akademove/core/_export.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'email_verification_state.mapper.dart';

@MappableClass()
class EmailVerificationState extends BaseState<bool>
    with EmailVerificationStateMappable {
  const EmailVerificationState({
    super.data,
    super.error,
    super.state,
    super.message,
    this.email,
  });

  final String? email;

  factory EmailVerificationState.initial() => const EmailVerificationState();
  factory EmailVerificationState.loading({String? email}) =>
      EmailVerificationState(state: CubitState.loading, email: email);
  factory EmailVerificationState.success({String? message, String? email}) =>
      EmailVerificationState(
        data: true,
        state: CubitState.success,
        message: message,
        email: email,
      );
  factory EmailVerificationState.failure(BaseError error, {String? email}) =>
      EmailVerificationState(
        error: error,
        state: CubitState.failure,
        email: email,
      );
}
