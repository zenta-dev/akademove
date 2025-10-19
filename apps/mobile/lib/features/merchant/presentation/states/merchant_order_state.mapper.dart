// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'merchant_order_state.dart';

class MerchantOrderStateMapper extends ClassMapperBase<MerchantOrderState> {
  MerchantOrderStateMapper._();

  static MerchantOrderStateMapper? _instance;
  static MerchantOrderStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MerchantOrderStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MerchantOrderState';

  static CubitState _$state(MerchantOrderState v) => v.state;
  static const Field<MerchantOrderState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(MerchantOrderState v) => v.message;
  static const Field<MerchantOrderState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(MerchantOrderState v) => v.error;
  static const Field<MerchantOrderState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static List<Order> _$list(MerchantOrderState v) => v.list;
  static const Field<MerchantOrderState, List<Order>> _f$list = Field(
    'list',
    _$list,
    opt: true,
    def: const [],
  );
  static Order? _$selected(MerchantOrderState v) => v.selected;
  static const Field<MerchantOrderState, Order> _f$selected = Field(
    'selected',
    _$selected,
    opt: true,
  );

  @override
  final MappableFields<MerchantOrderState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #list: _f$list,
    #selected: _f$selected,
  };

  static MerchantOrderState _instantiate(DecodingData data) {
    return MerchantOrderState(
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
      list: data.dec(_f$list),
      selected: data.dec(_f$selected),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin MerchantOrderStateMappable {
  MerchantOrderStateCopyWith<
    MerchantOrderState,
    MerchantOrderState,
    MerchantOrderState
  >
  get copyWith =>
      _MerchantOrderStateCopyWithImpl<MerchantOrderState, MerchantOrderState>(
        this as MerchantOrderState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MerchantOrderStateMapper.ensureInitialized().stringifyValue(
      this as MerchantOrderState,
    );
  }

  @override
  bool operator ==(Object other) {
    return MerchantOrderStateMapper.ensureInitialized().equalsValue(
      this as MerchantOrderState,
      other,
    );
  }

  @override
  int get hashCode {
    return MerchantOrderStateMapper.ensureInitialized().hashValue(
      this as MerchantOrderState,
    );
  }
}

extension MerchantOrderStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MerchantOrderState, $Out> {
  MerchantOrderStateCopyWith<$R, MerchantOrderState, $Out>
  get $asMerchantOrderState => $base.as(
    (v, t, t2) => _MerchantOrderStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MerchantOrderStateCopyWith<
  $R,
  $In extends MerchantOrderState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Order, ObjectCopyWith<$R, Order, Order>> get list;
  $R call({
    CubitState? state,
    String? message,
    BaseError? error,
    List<Order>? list,
    Order? selected,
  });
  MerchantOrderStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MerchantOrderStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MerchantOrderState, $Out>
    implements MerchantOrderStateCopyWith<$R, MerchantOrderState, $Out> {
  _MerchantOrderStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MerchantOrderState> $mapper =
      MerchantOrderStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Order, ObjectCopyWith<$R, Order, Order>> get list =>
      ListCopyWith(
        $value.list,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(list: v),
      );
  @override
  $R call({
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
    List<Order>? list,
    Object? selected = $none,
  }) => $apply(
    FieldCopyWithData({
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
      if (list != null) #list: list,
      if (selected != $none) #selected: selected,
    }),
  );
  @override
  MerchantOrderState $make(CopyWithData data) => MerchantOrderState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    list: data.get(#list, or: $value.list),
    selected: data.get(#selected, or: $value.selected),
  );

  @override
  MerchantOrderStateCopyWith<$R2, MerchantOrderState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MerchantOrderStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

