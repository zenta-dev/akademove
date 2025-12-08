// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState({
    this.user = const OperationResult.idle(),
    this.driver = const OperationResult.idle(),
    this.merchant = const OperationResult.idle(),
    this.resetPasswordResult = const OperationResult.idle(),
    this.forgotPasswordResult = const OperationResult.idle(),
  });

  final OperationResult<User> user;
  final OperationResult<Driver?> driver;
  final OperationResult<Merchant?> merchant;

  final OperationResult<bool> resetPasswordResult;
  final OperationResult<bool> forgotPasswordResult;

  @override
  List<Object> get props => [
    user,
    driver,
    merchant,
    resetPasswordResult,
    forgotPasswordResult,
  ];

  AuthState copyWith({
    OperationResult<User>? user,
    OperationResult<Driver?>? driver,
    OperationResult<Merchant?>? merchant,
    OperationResult<bool>? resetPasswordResult,
    OperationResult<bool>? forgotPasswordResult,
  }) {
    return AuthState(
      user: user ?? this.user,
      driver: driver ?? this.driver,
      merchant: merchant ?? this.merchant,
      resetPasswordResult: resetPasswordResult ?? this.resetPasswordResult,
      forgotPasswordResult: forgotPasswordResult ?? this.forgotPasswordResult,
    );
  }

  @override
  bool get stringify => true;
}
