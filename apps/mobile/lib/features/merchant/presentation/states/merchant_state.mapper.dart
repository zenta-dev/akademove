// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'merchant_state.dart';

class MerchantStateMapper extends ClassMapperBase<MerchantState> {
  MerchantStateMapper._();

  static MerchantStateMapper? _instance;
  static MerchantStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MerchantStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MerchantState';

  static CubitState _$state(MerchantState v) => v.state;
  static const Field<MerchantState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(MerchantState v) => v.message;
  static const Field<MerchantState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(MerchantState v) => v.error;
  static const Field<MerchantState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static List<Merchant> _$list(MerchantState v) => v.list;
  static const Field<MerchantState, List<Merchant>> _f$list = Field(
    'list',
    _$list,
    opt: true,
    def: const [],
  );
  static Merchant? _$selected(MerchantState v) => v.selected;
  static const Field<MerchantState, Merchant> _f$selected = Field(
    'selected',
    _$selected,
    opt: true,
  );

  @override
  final MappableFields<MerchantState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #list: _f$list,
    #selected: _f$selected,
  };

  static MerchantState _instantiate(DecodingData data) {
    return MerchantState(
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

mixin MerchantStateMappable {
  MerchantStateCopyWith<MerchantState, MerchantState, MerchantState>
  get copyWith => _MerchantStateCopyWithImpl<MerchantState, MerchantState>(
    this as MerchantState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return MerchantStateMapper.ensureInitialized().stringifyValue(
      this as MerchantState,
    );
  }

  @override
  bool operator ==(Object other) {
    return MerchantStateMapper.ensureInitialized().equalsValue(
      this as MerchantState,
      other,
    );
  }

  @override
  int get hashCode {
    return MerchantStateMapper.ensureInitialized().hashValue(
      this as MerchantState,
    );
  }
}

extension MerchantStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MerchantState, $Out> {
  MerchantStateCopyWith<$R, MerchantState, $Out> get $asMerchantState =>
      $base.as((v, t, t2) => _MerchantStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MerchantStateCopyWith<$R, $In extends MerchantState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Merchant, ObjectCopyWith<$R, Merchant, Merchant>> get list;
  $R call({
    CubitState? state,
    String? message,
    BaseError? error,
    List<Merchant>? list,
    Merchant? selected,
  });
  MerchantStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MerchantStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MerchantState, $Out>
    implements MerchantStateCopyWith<$R, MerchantState, $Out> {
  _MerchantStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MerchantState> $mapper =
      MerchantStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Merchant, ObjectCopyWith<$R, Merchant, Merchant>> get list =>
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
    List<Merchant>? list,
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
  MerchantState $make(CopyWithData data) => MerchantState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    list: data.get(#list, or: $value.list),
    selected: data.get(#selected, or: $value.selected),
  );

  @override
  MerchantStateCopyWith<$R2, MerchantState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MerchantStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

