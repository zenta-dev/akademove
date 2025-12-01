// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_export.dart';

class OrderChatStateMapper extends ClassMapperBase<OrderChatState> {
  OrderChatStateMapper._();

  static OrderChatStateMapper? _instance;
  static OrderChatStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OrderChatStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'OrderChatState';

  static List<OrderChatMessage>? _$messages(OrderChatState v) => v.messages;
  static const Field<OrderChatState, List<OrderChatMessage>> _f$messages =
      Field('messages', _$messages, opt: true);
  static bool _$hasMore(OrderChatState v) => v.hasMore;
  static const Field<OrderChatState, bool> _f$hasMore = Field(
    'hasMore',
    _$hasMore,
    opt: true,
    def: false,
  );
  static String? _$nextCursor(OrderChatState v) => v.nextCursor;
  static const Field<OrderChatState, String> _f$nextCursor = Field(
    'nextCursor',
    _$nextCursor,
    opt: true,
  );
  static CubitState _$state(OrderChatState v) => v.state;
  static const Field<OrderChatState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(OrderChatState v) => v.message;
  static const Field<OrderChatState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(OrderChatState v) => v.error;
  static const Field<OrderChatState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<OrderChatState> fields = const {
    #messages: _f$messages,
    #hasMore: _f$hasMore,
    #nextCursor: _f$nextCursor,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static OrderChatState _instantiate(DecodingData data) {
    return OrderChatState(
      messages: data.dec(_f$messages),
      hasMore: data.dec(_f$hasMore),
      nextCursor: data.dec(_f$nextCursor),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin OrderChatStateMappable {
  OrderChatStateCopyWith<OrderChatState, OrderChatState, OrderChatState>
  get copyWith => _OrderChatStateCopyWithImpl<OrderChatState, OrderChatState>(
    this as OrderChatState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return OrderChatStateMapper.ensureInitialized().stringifyValue(
      this as OrderChatState,
    );
  }

  @override
  bool operator ==(Object other) {
    return OrderChatStateMapper.ensureInitialized().equalsValue(
      this as OrderChatState,
      other,
    );
  }

  @override
  int get hashCode {
    return OrderChatStateMapper.ensureInitialized().hashValue(
      this as OrderChatState,
    );
  }
}

extension OrderChatStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OrderChatState, $Out> {
  OrderChatStateCopyWith<$R, OrderChatState, $Out> get $asOrderChatState =>
      $base.as((v, t, t2) => _OrderChatStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OrderChatStateCopyWith<$R, $In extends OrderChatState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    OrderChatMessage,
    ObjectCopyWith<$R, OrderChatMessage, OrderChatMessage>
  >?
  get messages;
  $R call({
    List<OrderChatMessage>? messages,
    bool? hasMore,
    String? nextCursor,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  OrderChatStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _OrderChatStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OrderChatState, $Out>
    implements OrderChatStateCopyWith<$R, OrderChatState, $Out> {
  _OrderChatStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OrderChatState> $mapper =
      OrderChatStateMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    OrderChatMessage,
    ObjectCopyWith<$R, OrderChatMessage, OrderChatMessage>
  >?
  get messages => $value.messages != null
      ? ListCopyWith(
          $value.messages!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(messages: v),
        )
      : null;
  @override
  $R call({
    Object? messages = $none,
    bool? hasMore,
    Object? nextCursor = $none,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (messages != $none) #messages: messages,
      if (hasMore != null) #hasMore: hasMore,
      if (nextCursor != $none) #nextCursor: nextCursor,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  OrderChatState $make(CopyWithData data) => OrderChatState(
    messages: data.get(#messages, or: $value.messages),
    hasMore: data.get(#hasMore, or: $value.hasMore),
    nextCursor: data.get(#nextCursor, or: $value.nextCursor),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  OrderChatStateCopyWith<$R2, OrderChatState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OrderChatStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

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

