import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'merchant_order_state.mapper.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class MerchantOrderState extends BaseState3<Order>
    with MerchantOrderStateMappable {
  const MerchantOrderState({
    super.state,
    super.message,
    super.error,
    super.list,
    super.selected,
  });

  MerchantOrderState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  MerchantOrderState toLoading() => copyWith(
    state: CubitState.loading,
    list: list,
    selected: selected,
    message: null,
    error: null,
  );

  MerchantOrderState toSuccess({
    List<Order>? list,
    Order? selected,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    list: list ?? this.list,
    selected: selected ?? this.selected,
    message: message,
    error: null,
  );

  MerchantOrderState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
