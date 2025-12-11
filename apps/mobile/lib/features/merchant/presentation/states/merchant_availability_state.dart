import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantAvailabilityState extends Equatable {
  const MerchantAvailabilityState({
    this.availabilityStatus = const OperationResult.idle(),
    this.setOnlineStatus = const OperationResult.idle(),
    this.setOperatingStatus = const OperationResult.idle(),
  });

  /// Current availability status from getAvailabilityStatus API
  final OperationResult<MerchantGetAvailabilityStatus200ResponseData>
  availabilityStatus;

  /// Result of setOnlineStatus operation (returns Merchant)
  final OperationResult<Merchant> setOnlineStatus;

  /// Result of setOperatingStatus operation (returns Merchant)
  final OperationResult<Merchant> setOperatingStatus;

  @override
  List<Object> get props => [
    availabilityStatus,
    setOnlineStatus,
    setOperatingStatus,
  ];

  MerchantAvailabilityState copyWith({
    OperationResult<MerchantGetAvailabilityStatus200ResponseData>?
    availabilityStatus,
    OperationResult<Merchant>? setOnlineStatus,
    OperationResult<Merchant>? setOperatingStatus,
  }) {
    return MerchantAvailabilityState(
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      setOnlineStatus: setOnlineStatus ?? this.setOnlineStatus,
      setOperatingStatus: setOperatingStatus ?? this.setOperatingStatus,
    );
  }

  /// Helper to check if merchant is currently online
  bool get isOnline {
    return availabilityStatus.value?.isOnline ?? false;
  }

  /// Helper to get current operating status
  MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum?
  get operatingStatus {
    return availabilityStatus.value?.operatingStatus;
  }

  /// Helper to get active order count
  num get activeOrderCount {
    return availabilityStatus.value?.activeOrderCount ?? 0;
  }

  @override
  bool get stringify => true;
}
