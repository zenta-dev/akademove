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
  static PlaceOrderResponse? _$placeOrderResult(UserOrderState v) =>
      v.placeOrderResult;
  static const Field<UserOrderState, PlaceOrderResponse> _f$placeOrderResult =
      Field('placeOrderResult', _$placeOrderResult, opt: true);
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
    #placeOrderResult: _f$placeOrderResult,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static UserOrderState _instantiate(DecodingData data) {
    return UserOrderState(
      estimateOrder: data.dec(_f$estimateOrder),
      placeOrderResult: data.dec(_f$placeOrderResult),
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
  $R call({
    EstimateOrderResult? estimateOrder,
    PlaceOrderResponse? placeOrderResult,
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
  $R call({
    Object? estimateOrder = $none,
    Object? placeOrderResult = $none,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (estimateOrder != $none) #estimateOrder: estimateOrder,
      if (placeOrderResult != $none) #placeOrderResult: placeOrderResult,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  UserOrderState $make(CopyWithData data) => UserOrderState(
    estimateOrder: data.get(#estimateOrder, or: $value.estimateOrder),
    placeOrderResult: data.get(#placeOrderResult, or: $value.placeOrderResult),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  UserOrderStateCopyWith<$R2, UserOrderState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserOrderStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

