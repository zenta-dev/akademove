import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantState extends Equatable {
  const MerchantState({
    this.mine = const OperationResult.idle(),
    this.fetchProfileResult = const OperationResult.idle(),
    this.updateProfile = const OperationResult.idle(),
    this.updatePasswordResult = const OperationResult.idle(),
    this.setupOutlet = const OperationResult.idle(),
    this.setupOperatingHours = const OperationResult.idle(),
    this.merchant,
  });

  /// The current merchant profile (cached)
  final Merchant? merchant;

  /// Operation result for getMine (legacy, kept for backward compatibility)
  final OperationResult<Merchant> mine;

  /// Operation result for fetching profile with loading/error states
  final OperationResult<Merchant> fetchProfileResult;

  /// Operation result for profile update
  final OperationResult<Merchant> updateProfile;

  /// Operation result for password update
  final OperationResult<bool> updatePasswordResult;

  /// Operation result for outlet setup
  final OperationResult<Merchant> setupOutlet;

  /// Operation result for operating hours setup
  final OperationResult<List<MerchantOperatingHours>> setupOperatingHours;

  @override
  List<Object?> get props => [
    mine,
    fetchProfileResult,
    updateProfile,
    updatePasswordResult,
    setupOutlet,
    setupOperatingHours,
    merchant,
  ];

  MerchantState copyWith({
    OperationResult<Merchant>? mine,
    OperationResult<Merchant>? fetchProfileResult,
    OperationResult<Merchant>? updateProfile,
    OperationResult<bool>? updatePasswordResult,
    OperationResult<Merchant>? setupOutlet,
    OperationResult<List<MerchantOperatingHours>>? setupOperatingHours,
    Merchant? merchant,
  }) {
    return MerchantState(
      mine: mine ?? this.mine,
      fetchProfileResult: fetchProfileResult ?? this.fetchProfileResult,
      updateProfile: updateProfile ?? this.updateProfile,
      updatePasswordResult: updatePasswordResult ?? this.updatePasswordResult,
      setupOutlet: setupOutlet ?? this.setupOutlet,
      setupOperatingHours: setupOperatingHours ?? this.setupOperatingHours,
      merchant: merchant ?? this.merchant,
    );
  }

  @override
  bool get stringify => true;
}
