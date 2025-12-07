part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class DriverOrderState extends BaseState2 with DriverOrderStateMappable {
  DriverOrderState({
    super.state,
    super.message,
    super.error,
    this.currentOrder,
    this.customer,
    this.orderStatus,
  });

  final Order? currentOrder;
  final User? customer;
  final OrderStatus? orderStatus;

  @override
  DriverOrderState toInitial() => DriverOrderState();

  @override
  DriverOrderState toLoading() => copyWith(state: CubitState.loading);

  @override
  DriverOrderState toSuccess({
    String? message,
    Order? currentOrder,
    User? customer,
    OrderStatus? orderStatus,
  }) => copyWith(
    state: CubitState.success,
    message: message,
    currentOrder: currentOrder ?? this.currentOrder,
    customer: customer ?? this.customer,
    orderStatus: orderStatus ?? this.orderStatus,
  );

  @override
  DriverOrderState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message ?? error.message,
  );
}
