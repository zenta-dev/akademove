import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'merchant_state.mapper.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class MerchantState extends BaseState2 with MerchantStateMappable {
  MerchantState({
    this.mine,
    super.state,
    super.message,
    super.error,
  });

  final Merchant? mine;

  @override
  MerchantState toInitial() => copyWith(
    state: CubitState.initial,
    message: null,
    error: null,
  );

  @override
  MerchantState toLoading() => copyWith(
    state: CubitState.loading,
    message: null,
    error: null,
  );

  @override
  MerchantState toSuccess({
    Merchant? mine,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    mine: mine ?? this.mine,
    message: message,
    error: null,
  );

  @override
  MerchantState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message,
  );
}
