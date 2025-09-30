// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'splash_state.dart';

class SplashStateMapper extends ClassMapperBase<SplashState> {
  SplashStateMapper._();

  static SplashStateMapper? _instance;
  static SplashStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SplashStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SplashState';

  static int? _$data(SplashState v) => v.data;
  static const Field<SplashState, int> _f$data = Field(
    'data',
    _$data,
    opt: true,
  );
  static Exception? _$error(SplashState v) => v.error;
  static const Field<SplashState, Exception> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static CubitState _$state(SplashState v) => v.state;
  static const Field<SplashState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );

  @override
  final MappableFields<SplashState> fields = const {
    #data: _f$data,
    #error: _f$error,
    #state: _f$state,
  };

  static SplashState _instantiate(DecodingData data) {
    return SplashState(
      data: data.dec(_f$data),
      error: data.dec(_f$error),
      state: data.dec(_f$state),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SplashState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SplashState>(map);
  }

  static SplashState fromJson(String json) {
    return ensureInitialized().decodeJson<SplashState>(json);
  }
}

mixin SplashStateMappable {
  String toJson() {
    return SplashStateMapper.ensureInitialized().encodeJson<SplashState>(
      this as SplashState,
    );
  }

  Map<String, dynamic> toMap() {
    return SplashStateMapper.ensureInitialized().encodeMap<SplashState>(
      this as SplashState,
    );
  }

  SplashStateCopyWith<SplashState, SplashState, SplashState> get copyWith =>
      _SplashStateCopyWithImpl<SplashState, SplashState>(
        this as SplashState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SplashStateMapper.ensureInitialized().stringifyValue(
      this as SplashState,
    );
  }

  @override
  bool operator ==(Object other) {
    return SplashStateMapper.ensureInitialized().equalsValue(
      this as SplashState,
      other,
    );
  }

  @override
  int get hashCode {
    return SplashStateMapper.ensureInitialized().hashValue(this as SplashState);
  }
}

extension SplashStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SplashState, $Out> {
  SplashStateCopyWith<$R, SplashState, $Out> get $asSplashState =>
      $base.as((v, t, t2) => _SplashStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SplashStateCopyWith<$R, $In extends SplashState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? data, Exception? error, CubitState? state});
  SplashStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SplashStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SplashState, $Out>
    implements SplashStateCopyWith<$R, SplashState, $Out> {
  _SplashStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SplashState> $mapper =
      SplashStateMapper.ensureInitialized();
  @override
  $R call({Object? data = $none, Object? error = $none, CubitState? state}) =>
      $apply(
        FieldCopyWithData({
          if (data != $none) #data: data,
          if (error != $none) #error: error,
          if (state != null) #state: state,
        }),
      );
  @override
  SplashState $make(CopyWithData data) => SplashState(
    data: data.get(#data, or: $value.data),
    error: data.get(#error, or: $value.error),
    state: data.get(#state, or: $value.state),
  );

  @override
  SplashStateCopyWith<$R2, SplashState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SplashStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

