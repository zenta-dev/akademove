part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserProfileState extends BaseState2 with UserProfileStateMappable {
  UserProfileState({
    this.updateProfileResult,
    this.updatePasswordResult,
    super.state,
    super.message,
    super.error,
  });

  final User? updateProfileResult;
  final bool? updatePasswordResult;

  @override
  UserProfileState toInitial() => copyWith(
    state: CubitState.initial,
    message: null,
    error: null,
  );

  @override
  UserProfileState toLoading() => copyWith(
    state: CubitState.loading,
    message: null,
    error: null,
  );

  @override
  UserProfileState toSuccess({
    User? updateProfileResult,
    bool? updatePasswordResult,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    message: message,
    error: null,
    updateProfileResult: updateProfileResult ?? this.updateProfileResult,
    updatePasswordResult: updatePasswordResult ?? this.updatePasswordResult,
  );

  @override
  UserProfileState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message,
  );
}
