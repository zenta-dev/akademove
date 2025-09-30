import 'package:akademove/core/state.dart';
import 'package:akademove/features/features.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'sign_up_state.mapper.dart';

@MappableClass()
class SignUpState extends BaseState<UserEntity> with SignUpStateMappable {
  const SignUpState({super.data, super.error, super.state});

  factory SignUpState.initial() => const SignUpState();
  factory SignUpState.loading() => const SignUpState(state: CubitState.loading);
  factory SignUpState.success(UserEntity user) =>
      SignUpState(data: user, state: CubitState.success);
  factory SignUpState.failure(Exception error) =>
      SignUpState(error: error, state: CubitState.failure);
}
