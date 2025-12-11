part of '_export.dart';

class DriverProfileState extends Equatable {
  const DriverProfileState({
    this.fetchProfileResult = const OperationResult.idle(),
    this.updateProfileResult = const OperationResult.idle(),
    this.updatePasswordResult = const OperationResult.idle(),
    this.myDriver,
  });

  final OperationResult<Driver> fetchProfileResult;
  final OperationResult<Driver> updateProfileResult;
  final OperationResult<bool> updatePasswordResult;

  final Driver? myDriver;

  @override
  List<Object?> get props => [
    fetchProfileResult,
    updateProfileResult,
    updatePasswordResult,
    myDriver,
  ];

  @override
  bool get stringify => true;

  DriverProfileState copyWith({
    OperationResult<Driver>? fetchProfileResult,
    OperationResult<Driver>? updateProfileResult,
    OperationResult<bool>? updatePasswordResult,
    Driver? myDriver,
  }) {
    return DriverProfileState(
      fetchProfileResult: fetchProfileResult ?? this.fetchProfileResult,
      updateProfileResult: updateProfileResult ?? this.updateProfileResult,
      updatePasswordResult: updatePasswordResult ?? this.updatePasswordResult,
      myDriver: myDriver ?? this.myDriver,
    );
  }
}
