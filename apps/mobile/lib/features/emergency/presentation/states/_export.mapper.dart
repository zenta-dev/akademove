// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_export.dart';

class EmergencyStateMapper extends ClassMapperBase<EmergencyState> {
  EmergencyStateMapper._();

  static EmergencyStateMapper? _instance;
  static EmergencyStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EmergencyStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EmergencyState';

  static Emergency? _$triggered(EmergencyState v) => v.triggered;
  static const Field<EmergencyState, Emergency> _f$triggered = Field(
    'triggered',
    _$triggered,
    opt: true,
  );
  static List<Emergency> _$list(EmergencyState v) => v.list;
  static const Field<EmergencyState, List<Emergency>> _f$list = Field(
    'list',
    _$list,
    opt: true,
    def: const [],
  );
  static CubitState _$state(EmergencyState v) => v.state;
  static const Field<EmergencyState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(EmergencyState v) => v.message;
  static const Field<EmergencyState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(EmergencyState v) => v.error;
  static const Field<EmergencyState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<EmergencyState> fields = const {
    #triggered: _f$triggered,
    #list: _f$list,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static EmergencyState _instantiate(DecodingData data) {
    return EmergencyState(
      triggered: data.dec(_f$triggered),
      list: data.dec(_f$list),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin EmergencyStateMappable {
  EmergencyStateCopyWith<EmergencyState, EmergencyState, EmergencyState>
  get copyWith => _EmergencyStateCopyWithImpl<EmergencyState, EmergencyState>(
    this as EmergencyState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return EmergencyStateMapper.ensureInitialized().stringifyValue(
      this as EmergencyState,
    );
  }

  @override
  bool operator ==(Object other) {
    return EmergencyStateMapper.ensureInitialized().equalsValue(
      this as EmergencyState,
      other,
    );
  }

  @override
  int get hashCode {
    return EmergencyStateMapper.ensureInitialized().hashValue(
      this as EmergencyState,
    );
  }
}

extension EmergencyStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EmergencyState, $Out> {
  EmergencyStateCopyWith<$R, EmergencyState, $Out> get $asEmergencyState =>
      $base.as((v, t, t2) => _EmergencyStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EmergencyStateCopyWith<$R, $In extends EmergencyState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Emergency, ObjectCopyWith<$R, Emergency, Emergency>>
  get list;
  $R call({
    Emergency? triggered,
    List<Emergency>? list,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  EmergencyStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EmergencyStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EmergencyState, $Out>
    implements EmergencyStateCopyWith<$R, EmergencyState, $Out> {
  _EmergencyStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EmergencyState> $mapper =
      EmergencyStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Emergency, ObjectCopyWith<$R, Emergency, Emergency>>
  get list => ListCopyWith(
    $value.list,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(list: v),
  );
  @override
  $R call({
    Object? triggered = $none,
    List<Emergency>? list,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (triggered != $none) #triggered: triggered,
      if (list != null) #list: list,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  EmergencyState $make(CopyWithData data) => EmergencyState(
    triggered: data.get(#triggered, or: $value.triggered),
    list: data.get(#list, or: $value.list),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  EmergencyStateCopyWith<$R2, EmergencyState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EmergencyStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

