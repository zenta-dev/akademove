// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'merchant_menu_state.dart';

class MerchantMenuStateMapper extends ClassMapperBase<MerchantMenuState> {
  MerchantMenuStateMapper._();

  static MerchantMenuStateMapper? _instance;
  static MerchantMenuStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MerchantMenuStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MerchantMenuState';

  static CubitState _$state(MerchantMenuState v) => v.state;
  static const Field<MerchantMenuState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(MerchantMenuState v) => v.message;
  static const Field<MerchantMenuState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(MerchantMenuState v) => v.error;
  static const Field<MerchantMenuState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static List<MerchantMenu> _$list(MerchantMenuState v) => v.list;
  static const Field<MerchantMenuState, List<MerchantMenu>> _f$list = Field(
    'list',
    _$list,
    opt: true,
    def: const [],
  );
  static MerchantMenu? _$selected(MerchantMenuState v) => v.selected;
  static const Field<MerchantMenuState, MerchantMenu> _f$selected = Field(
    'selected',
    _$selected,
    opt: true,
  );

  @override
  final MappableFields<MerchantMenuState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #list: _f$list,
    #selected: _f$selected,
  };

  static MerchantMenuState _instantiate(DecodingData data) {
    return MerchantMenuState(
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

mixin MerchantMenuStateMappable {
  MerchantMenuStateCopyWith<
    MerchantMenuState,
    MerchantMenuState,
    MerchantMenuState
  >
  get copyWith =>
      _MerchantMenuStateCopyWithImpl<MerchantMenuState, MerchantMenuState>(
        this as MerchantMenuState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MerchantMenuStateMapper.ensureInitialized().stringifyValue(
      this as MerchantMenuState,
    );
  }

  @override
  bool operator ==(Object other) {
    return MerchantMenuStateMapper.ensureInitialized().equalsValue(
      this as MerchantMenuState,
      other,
    );
  }

  @override
  int get hashCode {
    return MerchantMenuStateMapper.ensureInitialized().hashValue(
      this as MerchantMenuState,
    );
  }
}

extension MerchantMenuStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MerchantMenuState, $Out> {
  MerchantMenuStateCopyWith<$R, MerchantMenuState, $Out>
  get $asMerchantMenuState => $base.as(
    (v, t, t2) => _MerchantMenuStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MerchantMenuStateCopyWith<
  $R,
  $In extends MerchantMenuState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, MerchantMenu, ObjectCopyWith<$R, MerchantMenu, MerchantMenu>>
  get list;
  $R call({
    CubitState? state,
    String? message,
    BaseError? error,
    List<MerchantMenu>? list,
    MerchantMenu? selected,
  });
  MerchantMenuStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MerchantMenuStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MerchantMenuState, $Out>
    implements MerchantMenuStateCopyWith<$R, MerchantMenuState, $Out> {
  _MerchantMenuStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MerchantMenuState> $mapper =
      MerchantMenuStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, MerchantMenu, ObjectCopyWith<$R, MerchantMenu, MerchantMenu>>
  get list => ListCopyWith(
    $value.list,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(list: v),
  );
  @override
  $R call({
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
    List<MerchantMenu>? list,
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
  MerchantMenuState $make(CopyWithData data) => MerchantMenuState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    list: data.get(#list, or: $value.list),
    selected: data.get(#selected, or: $value.selected),
  );

  @override
  MerchantMenuStateCopyWith<$R2, MerchantMenuState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MerchantMenuStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

