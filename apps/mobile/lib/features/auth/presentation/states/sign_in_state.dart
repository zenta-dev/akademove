import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'sign_in_state.mapper.dart';

@MappableClass()
class SignInState extends BaseState<User> with SignInStateMappable {
  const SignInState({super.data, super.error, super.state, super.message});

  factory SignInState.initial() => const SignInState();
  factory SignInState.loading() => const SignInState(state: CubitState.loading);
  factory SignInState.success(User user, {String? message}) =>
      SignInState(data: user, state: CubitState.success, message: message);
  factory SignInState.failure(BaseError error) =>
      SignInState(error: error, state: CubitState.failure);
}
