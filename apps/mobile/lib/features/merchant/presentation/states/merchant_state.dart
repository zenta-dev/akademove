import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'merchant_state.mapper.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class MerchantState extends BaseState3<Merchant> with MerchantStateMappable {
  const MerchantState({
    super.state,
    super.message,
    super.error,
    super.list,
    super.selected,
  });

  MerchantState toInitial() => copyWith(
    state: CubitState.initial,
    message: null,
    error: null,
  );

  MerchantState toLoading() => copyWith(
    state: CubitState.loading,
    list: list,
    selected: selected,
    message: null,
    error: null,
  );

  MerchantState toSuccess({
    List<Merchant>? list,
    Merchant? selected,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    list: list ?? this.list,
    selected: selected ?? this.selected,
    message: message,
    error: null,
  );

  MerchantState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message,
  );
}
