import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'auth_state.mapper.dart';

@MappableClass()
class AuthState extends BaseState<User?> with AuthStateMappable {
  const AuthState({super.data, super.error, super.state, super.message});

  factory AuthState.initial() => const AuthState();
  factory AuthState.loading() => const AuthState(state: CubitState.loading);
  factory AuthState.success(User? user, {String? message}) =>
      AuthState(data: user, state: CubitState.success, message: message);
  factory AuthState.failure(BaseError error) =>
      AuthState(error: error, state: CubitState.failure);
}
