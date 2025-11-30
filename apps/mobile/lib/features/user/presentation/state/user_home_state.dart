part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserHomeState extends BaseState2 with UserHomeStateMappable {
  UserHomeState({
    this.popularMerchants = const [],
    super.state,
    super.message,
    super.error,
  });

  final List<Merchant> popularMerchants;

  @override
  UserHomeState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  @override
  UserHomeState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  UserHomeState toSuccess({
    List<Merchant>? popularMerchants,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    popularMerchants: popularMerchants ?? this.popularMerchants,
    message: message,
    error: null,
  );

  @override
  UserHomeState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
