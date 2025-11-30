// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_export.dart';

class UserOrderStateMapper extends ClassMapperBase<UserOrderState> {
  UserOrderStateMapper._();

  static UserOrderStateMapper? _instance;
  static UserOrderStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserOrderStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserOrderState';

  static EstimateOrderResult? _$estimateOrder(UserOrderState v) =>
      v.estimateOrder;
  static const Field<UserOrderState, EstimateOrderResult> _f$estimateOrder =
      Field('estimateOrder', _$estimateOrder, opt: true);
  static List<Order>? _$orderHistories(UserOrderState v) => v.orderHistories;
  static const Field<UserOrderState, List<Order>> _f$orderHistories = Field(
    'orderHistories',
    _$orderHistories,
    opt: true,
  );
  static Order? _$selectedOrder(UserOrderState v) => v.selectedOrder;
  static const Field<UserOrderState, Order> _f$selectedOrder = Field(
    'selectedOrder',
    _$selectedOrder,
    opt: true,
  );
  static Order? _$currentOrder(UserOrderState v) => v.currentOrder;
  static const Field<UserOrderState, Order> _f$currentOrder = Field(
    'currentOrder',
    _$currentOrder,
    opt: true,
  );
  static Payment? _$currentPayment(UserOrderState v) => v.currentPayment;
  static const Field<UserOrderState, Payment> _f$currentPayment = Field(
    'currentPayment',
    _$currentPayment,
    opt: true,
  );
  static Transaction? _$currentTransaction(UserOrderState v) =>
      v.currentTransaction;
  static const Field<UserOrderState, Transaction> _f$currentTransaction = Field(
    'currentTransaction',
    _$currentTransaction,
    opt: true,
  );
  static Driver? _$currentAssignedDriver(UserOrderState v) =>
      v.currentAssignedDriver;
  static const Field<UserOrderState, Driver> _f$currentAssignedDriver = Field(
    'currentAssignedDriver',
    _$currentAssignedDriver,
    opt: true,
  );
  static CubitState _$state(UserOrderState v) => v.state;
  static const Field<UserOrderState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(UserOrderState v) => v.message;
  static const Field<UserOrderState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(UserOrderState v) => v.error;
  static const Field<UserOrderState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<UserOrderState> fields = const {
    #estimateOrder: _f$estimateOrder,
    #orderHistories: _f$orderHistories,
    #selectedOrder: _f$selectedOrder,
    #currentOrder: _f$currentOrder,
    #currentPayment: _f$currentPayment,
    #currentTransaction: _f$currentTransaction,
    #currentAssignedDriver: _f$currentAssignedDriver,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static UserOrderState _instantiate(DecodingData data) {
    return UserOrderState(
      estimateOrder: data.dec(_f$estimateOrder),
      orderHistories: data.dec(_f$orderHistories),
      selectedOrder: data.dec(_f$selectedOrder),
      currentOrder: data.dec(_f$currentOrder),
      currentPayment: data.dec(_f$currentPayment),
      currentTransaction: data.dec(_f$currentTransaction),
      currentAssignedDriver: data.dec(_f$currentAssignedDriver),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin UserOrderStateMappable {
  UserOrderStateCopyWith<UserOrderState, UserOrderState, UserOrderState>
  get copyWith => _UserOrderStateCopyWithImpl<UserOrderState, UserOrderState>(
    this as UserOrderState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return UserOrderStateMapper.ensureInitialized().stringifyValue(
      this as UserOrderState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserOrderStateMapper.ensureInitialized().equalsValue(
      this as UserOrderState,
      other,
    );
  }

  @override
  int get hashCode {
    return UserOrderStateMapper.ensureInitialized().hashValue(
      this as UserOrderState,
    );
  }
}

extension UserOrderStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserOrderState, $Out> {
  UserOrderStateCopyWith<$R, UserOrderState, $Out> get $asUserOrderState =>
      $base.as((v, t, t2) => _UserOrderStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserOrderStateCopyWith<$R, $In extends UserOrderState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Order, ObjectCopyWith<$R, Order, Order>>? get orderHistories;
  $R call({
    EstimateOrderResult? estimateOrder,
    List<Order>? orderHistories,
    Order? selectedOrder,
    Order? currentOrder,
    Payment? currentPayment,
    Transaction? currentTransaction,
    Driver? currentAssignedDriver,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  UserOrderStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserOrderStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserOrderState, $Out>
    implements UserOrderStateCopyWith<$R, UserOrderState, $Out> {
  _UserOrderStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserOrderState> $mapper =
      UserOrderStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Order, ObjectCopyWith<$R, Order, Order>>?
  get orderHistories => $value.orderHistories != null
      ? ListCopyWith(
          $value.orderHistories!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(orderHistories: v),
        )
      : null;
  @override
  $R call({
    Object? estimateOrder = $none,
    Object? orderHistories = $none,
    Object? selectedOrder = $none,
    Object? currentOrder = $none,
    Object? currentPayment = $none,
    Object? currentTransaction = $none,
    Object? currentAssignedDriver = $none,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (estimateOrder != $none) #estimateOrder: estimateOrder,
      if (orderHistories != $none) #orderHistories: orderHistories,
      if (selectedOrder != $none) #selectedOrder: selectedOrder,
      if (currentOrder != $none) #currentOrder: currentOrder,
      if (currentPayment != $none) #currentPayment: currentPayment,
      if (currentTransaction != $none) #currentTransaction: currentTransaction,
      if (currentAssignedDriver != $none)
        #currentAssignedDriver: currentAssignedDriver,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  UserOrderState $make(CopyWithData data) => UserOrderState(
    estimateOrder: data.get(#estimateOrder, or: $value.estimateOrder),
    orderHistories: data.get(#orderHistories, or: $value.orderHistories),
    selectedOrder: data.get(#selectedOrder, or: $value.selectedOrder),
    currentOrder: data.get(#currentOrder, or: $value.currentOrder),
    currentPayment: data.get(#currentPayment, or: $value.currentPayment),
    currentTransaction: data.get(
      #currentTransaction,
      or: $value.currentTransaction,
    ),
    currentAssignedDriver: data.get(
      #currentAssignedDriver,
      or: $value.currentAssignedDriver,
    ),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  UserOrderStateCopyWith<$R2, UserOrderState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserOrderStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

