import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'sign_up_state.mapper.dart';

@MappableClass()
class SignUpState extends BaseState<User> with SignUpStateMappable {
  const SignUpState({super.data, super.error, super.state, super.message});

  factory SignUpState.initial() => const SignUpState();
  factory SignUpState.loading() => const SignUpState(state: CubitState.loading);
  factory SignUpState.success(User user, {String? message}) =>
      SignUpState(data: user, state: CubitState.success, message: message);
  factory SignUpState.failure(BaseError error) =>
      SignUpState(error: error, state: CubitState.failure);
}
