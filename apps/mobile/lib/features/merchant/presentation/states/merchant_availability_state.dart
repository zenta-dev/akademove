import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantAvailabilityState extends Equatable {
  const MerchantAvailabilityState({
    this.availability = const OperationResult.idle(),
  });

  final OperationResult<Merchant> availability;

  @override
  List<Object> get props => [availability];

  MerchantAvailabilityState copyWith({
    OperationResult<Merchant>? availability,
  }) {
    return MerchantAvailabilityState(
      availability: availability ?? this.availability,
    );
  }

  @override
  bool get stringify => true;
}
