import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'splash_state.mapper.dart';

@MappableClass()
class SplashState extends BaseState<User> with SplashStateMappable {
  const SplashState({super.data, super.error, super.state, super.message});

  factory SplashState.initial() => const SplashState();
  factory SplashState.loading() => const SplashState(state: CubitState.loading);
  factory SplashState.success(User user, {String? message}) =>
      SplashState(data: user, state: CubitState.success, message: message);
  factory SplashState.failure(BaseError error) =>
      SplashState(error: error, state: CubitState.failure);
}
