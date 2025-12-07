import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class MerchantAvailabilityState extends BaseState<Merchant?> {
  const MerchantAvailabilityState({
    super.data,
    super.error,
    super.state,
    super.message,
  });

  factory MerchantAvailabilityState.initial() =>
      const MerchantAvailabilityState();

  factory MerchantAvailabilityState.loading() =>
      const MerchantAvailabilityState(state: CubitState.loading);

  factory MerchantAvailabilityState.success(
    Merchant merchant, {
    String? message,
  }) => MerchantAvailabilityState(
    data: merchant,
    state: CubitState.success,
    message: message,
  );

  factory MerchantAvailabilityState.failure(BaseError error) =>
      MerchantAvailabilityState(error: error, state: CubitState.failure);
}
