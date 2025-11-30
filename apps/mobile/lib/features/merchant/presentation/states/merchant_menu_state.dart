import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'merchant_menu_state.mapper.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class MerchantMenuState extends BaseState3<MerchantMenu>
    with MerchantMenuStateMappable {
  const MerchantMenuState({
    super.state,
    super.message,
    super.error,
    super.list,
    super.selected,
  });

  MerchantMenuState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  MerchantMenuState toLoading() => copyWith(
    state: CubitState.loading,
    list: list,
    selected: selected,
    message: null,
    error: null,
  );

  MerchantMenuState toSuccess({
    List<MerchantMenu>? list,
    MerchantMenu? selected,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    list: list ?? this.list,
    selected: selected ?? this.selected,
    message: message,
    error: null,
  );

  MerchantMenuState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
