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
    this.operatingHours = const OperationResult.idle(),
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
  final OperationResult<List<MerchantOperatingHours>> operatingHours;

  /// Check if merchant has completed outlet setup
  /// Outlet is considered setup if merchant has an image and at least one operating hour configured
  bool get isMerchantOutletSetup {
    final merchantData = mine.value;
    final operatingHours = this.operatingHours.value;

    if (merchantData == null) return false;

    // Check if merchant has an image (outlet photo)
    final hasImage =
        merchantData.image != null && merchantData.image!.isNotEmpty;

    // Check if merchant has at least one operating hour with isOpen = true
    final hasOperatingHours =
        operatingHours != null && operatingHours.isNotEmpty;

    return hasImage && hasOperatingHours;
  }

  @override
  List<Object?> get props => [
    mine,
    fetchProfileResult,
    updateProfile,
    updatePasswordResult,
    setupOutlet,
    operatingHours,
    merchant,
  ];

  MerchantState copyWith({
    OperationResult<Merchant>? mine,
    OperationResult<Merchant>? fetchProfileResult,
    OperationResult<Merchant>? updateProfile,
    OperationResult<bool>? updatePasswordResult,
    OperationResult<Merchant>? setupOutlet,
    OperationResult<List<MerchantOperatingHours>>? operatingHours,
    Merchant? merchant,
  }) {
    return MerchantState(
      mine: mine ?? this.mine,
      fetchProfileResult: fetchProfileResult ?? this.fetchProfileResult,
      updateProfile: updateProfile ?? this.updateProfile,
      updatePasswordResult: updatePasswordResult ?? this.updatePasswordResult,
      setupOutlet: setupOutlet ?? this.setupOutlet,
      operatingHours: operatingHours ?? this.operatingHours,
      merchant: merchant ?? this.merchant,
    );
  }

  @override
  bool get stringify => true;
}
