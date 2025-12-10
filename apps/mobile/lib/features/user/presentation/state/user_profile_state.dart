part of '_export.dart';

class UserProfileState extends Equatable {
  const UserProfileState({
    this.updateProfileResult = const OperationResult.idle(),
    this.updatePasswordResult = const OperationResult.idle(),
  });

  final OperationResult<User> updateProfileResult;
  final OperationResult<bool> updatePasswordResult;

  @override
  List<Object> get props => [updateProfileResult, updatePasswordResult];

  UserProfileState copyWith({
    OperationResult<User>? updateProfileResult,
    OperationResult<bool>? updatePasswordResult,
  }) {
    return UserProfileState(
      updateProfileResult: updateProfileResult ?? this.updateProfileResult,
      updatePasswordResult: updatePasswordResult ?? this.updatePasswordResult,
    );
  }

  @override
  bool get stringify => true;
}
