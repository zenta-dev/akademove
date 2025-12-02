// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'driver_order_state.dart';

class DriverOrderStateMapper extends ClassMapperBase<DriverOrderState> {
  DriverOrderStateMapper._();

  static DriverOrderStateMapper? _instance;
  static DriverOrderStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DriverOrderStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DriverOrderState';

  static Order? _$currentOrder(DriverOrderState v) => v.currentOrder;
  static const Field<DriverOrderState, Order> _f$currentOrder = Field(
    'currentOrder',
    _$currentOrder,
    opt: true,
  );
  static User? _$customer(DriverOrderState v) => v.customer;
  static const Field<DriverOrderState, User> _f$customer = Field(
    'customer',
    _$customer,
    opt: true,
  );
  static OrderStatus? _$orderStatus(DriverOrderState v) => v.orderStatus;
  static const Field<DriverOrderState, OrderStatus> _f$orderStatus = Field(
    'orderStatus',
    _$orderStatus,
    opt: true,
  );
  static bool _$isLoading(DriverOrderState v) => v.isLoading;
  static const Field<DriverOrderState, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
    opt: true,
    def: false,
  );
  static BaseError? _$error(DriverOrderState v) => v.error;
  static const Field<DriverOrderState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static String? _$message(DriverOrderState v) => v.message;
  static const Field<DriverOrderState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );

  @override
  final MappableFields<DriverOrderState> fields = const {
    #currentOrder: _f$currentOrder,
    #customer: _f$customer,
    #orderStatus: _f$orderStatus,
    #isLoading: _f$isLoading,
    #error: _f$error,
    #message: _f$message,
  };

  static DriverOrderState _instantiate(DecodingData data) {
    return DriverOrderState(
      currentOrder: data.dec(_f$currentOrder),
      customer: data.dec(_f$customer),
      orderStatus: data.dec(_f$orderStatus),
      isLoading: data.dec(_f$isLoading),
      error: data.dec(_f$error),
      message: data.dec(_f$message),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DriverOrderState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DriverOrderState>(map);
  }

  static DriverOrderState fromJson(String json) {
    return ensureInitialized().decodeJson<DriverOrderState>(json);
  }
}

mixin DriverOrderStateMappable {
  String toJson() {
    return DriverOrderStateMapper.ensureInitialized()
        .encodeJson<DriverOrderState>(this as DriverOrderState);
  }

  Map<String, dynamic> toMap() {
    return DriverOrderStateMapper.ensureInitialized()
        .encodeMap<DriverOrderState>(this as DriverOrderState);
  }

  DriverOrderStateCopyWith<DriverOrderState, DriverOrderState, DriverOrderState>
  get copyWith =>
      _DriverOrderStateCopyWithImpl<DriverOrderState, DriverOrderState>(
        this as DriverOrderState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DriverOrderStateMapper.ensureInitialized().stringifyValue(
      this as DriverOrderState,
    );
  }

  @override
  bool operator ==(Object other) {
    return DriverOrderStateMapper.ensureInitialized().equalsValue(
      this as DriverOrderState,
      other,
    );
  }

  @override
  int get hashCode {
    return DriverOrderStateMapper.ensureInitialized().hashValue(
      this as DriverOrderState,
    );
  }
}

extension DriverOrderStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DriverOrderState, $Out> {
  DriverOrderStateCopyWith<$R, DriverOrderState, $Out>
  get $asDriverOrderState =>
      $base.as((v, t, t2) => _DriverOrderStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DriverOrderStateCopyWith<$R, $In extends DriverOrderState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Order? currentOrder,
    User? customer,
    OrderStatus? orderStatus,
    bool? isLoading,
    BaseError? error,
    String? message,
  });
  DriverOrderStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DriverOrderStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DriverOrderState, $Out>
    implements DriverOrderStateCopyWith<$R, DriverOrderState, $Out> {
  _DriverOrderStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DriverOrderState> $mapper =
      DriverOrderStateMapper.ensureInitialized();
  @override
  $R call({
    Object? currentOrder = $none,
    Object? customer = $none,
    Object? orderStatus = $none,
    bool? isLoading,
    Object? error = $none,
    Object? message = $none,
  }) => $apply(
    FieldCopyWithData({
      if (currentOrder != $none) #currentOrder: currentOrder,
      if (customer != $none) #customer: customer,
      if (orderStatus != $none) #orderStatus: orderStatus,
      if (isLoading != null) #isLoading: isLoading,
      if (error != $none) #error: error,
      if (message != $none) #message: message,
    }),
  );
  @override
  DriverOrderState $make(CopyWithData data) => DriverOrderState(
    currentOrder: data.get(#currentOrder, or: $value.currentOrder),
    customer: data.get(#customer, or: $value.customer),
    orderStatus: data.get(#orderStatus, or: $value.orderStatus),
    isLoading: data.get(#isLoading, or: $value.isLoading),
    error: data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
  );

  @override
  DriverOrderStateCopyWith<$R2, DriverOrderState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DriverOrderStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

