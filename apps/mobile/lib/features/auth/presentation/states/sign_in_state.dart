import 'package:akademove/core/state.dart';
import 'package:akademove/features/features.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'sign_in_state.mapper.dart';

@MappableClass()
class SignInState extends BaseState<UserEntity> with SignInStateMappable {
  const SignInState({super.data, super.error, super.state});

  factory SignInState.initial() => const SignInState();
  factory SignInState.loading() => const SignInState(state: CubitState.loading);
  factory SignInState.success(UserEntity user) =>
      SignInState(data: user, state: CubitState.success);
  factory SignInState.failure(Exception error) =>
      SignInState(error: error, state: CubitState.failure);
}
