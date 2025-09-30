import 'package:akademove/core/_export.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'splash_state.mapper.dart';

@MappableClass()
class SplashState extends BaseState<int> with SplashStateMappable {
  const SplashState({super.data, super.error, super.state});

  factory SplashState.initial() => const SplashState();
  factory SplashState.loading() => const SplashState(state: CubitState.loading);
  factory SplashState.success() => const SplashState(state: CubitState.success);
  factory SplashState.failure(BaseError error) =>
      SplashState(error: error, state: CubitState.failure);
}
