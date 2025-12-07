part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class DriverProfileState extends BaseState2 with DriverProfileStateMappable {
  DriverProfileState({super.state, super.message, super.error, this.myDriver});

  final Driver? myDriver;

  @override
  DriverProfileState toInitial() => DriverProfileState();

  @override
  DriverProfileState toLoading() => copyWith(state: CubitState.loading);

  @override
  DriverProfileState toSuccess({String? message, Driver? myDriver}) => copyWith(
    state: CubitState.success,
    message: message,
    myDriver: myDriver ?? this.myDriver,
  );

  @override
  DriverProfileState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message ?? error.message,
  );
}
