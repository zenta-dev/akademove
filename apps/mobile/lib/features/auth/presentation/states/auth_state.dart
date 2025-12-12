// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState({
    this.user = const OperationResult.idle(),
    this.driver = const OperationResult.idle(),
    this.merchant = const OperationResult.idle(),
    this.merchantOperatingHours = const OperationResult.idle(),
    this.resetPasswordResult = const OperationResult.idle(),
    this.forgotPasswordResult = const OperationResult.idle(),
  });

  final OperationResult<User> user;
  final OperationResult<Driver?> driver;
  final OperationResult<Merchant?> merchant;
  final OperationResult<List<MerchantOperatingHours>?> merchantOperatingHours;

  final OperationResult<bool> resetPasswordResult;
  final OperationResult<bool> forgotPasswordResult;

  /// Check if merchant has completed outlet setup
  /// Outlet is considered setup if merchant has an image and at least one operating hour configured
  bool get isMerchantOutletSetup {
    final merchantData = merchant.value;
    final operatingHours = merchantOperatingHours.value;

    if (merchantData == null) return false;

    // Check if merchant has an image (outlet photo)
    final hasImage =
        merchantData.image != null && merchantData.image!.isNotEmpty;

    // Check if merchant has at least one operating hour with isOpen = true
    final hasOperatingHours =
        operatingHours != null &&
        operatingHours.isNotEmpty &&
        operatingHours.any((oh) => oh.isOpen);

    return hasImage && hasOperatingHours;
  }

  @override
  List<Object> get props => [
    user,
    driver,
    merchant,
    merchantOperatingHours,
    resetPasswordResult,
    forgotPasswordResult,
  ];

  AuthState copyWith({
    OperationResult<User>? user,
    OperationResult<Driver?>? driver,
    OperationResult<Merchant?>? merchant,
    OperationResult<List<MerchantOperatingHours>?>? merchantOperatingHours,
    OperationResult<bool>? resetPasswordResult,
    OperationResult<bool>? forgotPasswordResult,
  }) {
    return AuthState(
      user: user ?? this.user,
      driver: driver ?? this.driver,
      merchant: merchant ?? this.merchant,
      merchantOperatingHours:
          merchantOperatingHours ?? this.merchantOperatingHours,
      resetPasswordResult: resetPasswordResult ?? this.resetPasswordResult,
      forgotPasswordResult: forgotPasswordResult ?? this.forgotPasswordResult,
    );
  }

  @override
  bool get stringify => true;
}
