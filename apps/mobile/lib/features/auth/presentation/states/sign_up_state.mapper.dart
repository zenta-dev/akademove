// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'sign_up_state.dart';

class SignUpStateMapper extends ClassMapperBase<SignUpState> {
  SignUpStateMapper._();

  static SignUpStateMapper? _instance;
  static SignUpStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SignUpStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SignUpState';

  static UserEntity? _$data(SignUpState v) => v.data;
  static const Field<SignUpState, UserEntity> _f$data = Field(
    'data',
    _$data,
    opt: true,
  );
  static BaseError? _$error(SignUpState v) => v.error;
  static const Field<SignUpState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static CubitState _$state(SignUpState v) => v.state;
  static const Field<SignUpState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );

  @override
  final MappableFields<SignUpState> fields = const {
    #data: _f$data,
    #error: _f$error,
    #state: _f$state,
  };

  static SignUpState _instantiate(DecodingData data) {
    return SignUpState(
      data: data.dec(_f$data),
      error: data.dec(_f$error),
      state: data.dec(_f$state),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SignUpState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SignUpState>(map);
  }

  static SignUpState fromJson(String json) {
    return ensureInitialized().decodeJson<SignUpState>(json);
  }
}

mixin SignUpStateMappable {
  String toJson() {
    return SignUpStateMapper.ensureInitialized().encodeJson<SignUpState>(
      this as SignUpState,
    );
  }

  Map<String, dynamic> toMap() {
    return SignUpStateMapper.ensureInitialized().encodeMap<SignUpState>(
      this as SignUpState,
    );
  }

  SignUpStateCopyWith<SignUpState, SignUpState, SignUpState> get copyWith =>
      _SignUpStateCopyWithImpl<SignUpState, SignUpState>(
        this as SignUpState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SignUpStateMapper.ensureInitialized().stringifyValue(
      this as SignUpState,
    );
  }

  @override
  bool operator ==(Object other) {
    return SignUpStateMapper.ensureInitialized().equalsValue(
      this as SignUpState,
      other,
    );
  }

  @override
  int get hashCode {
    return SignUpStateMapper.ensureInitialized().hashValue(this as SignUpState);
  }
}

extension SignUpStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SignUpState, $Out> {
  SignUpStateCopyWith<$R, SignUpState, $Out> get $asSignUpState =>
      $base.as((v, t, t2) => _SignUpStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SignUpStateCopyWith<$R, $In extends SignUpState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({UserEntity? data, BaseError? error, CubitState? state});
  SignUpStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SignUpStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SignUpState, $Out>
    implements SignUpStateCopyWith<$R, SignUpState, $Out> {
  _SignUpStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SignUpState> $mapper =
      SignUpStateMapper.ensureInitialized();
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
  SignUpState $make(CopyWithData data) => SignUpState(
    data: data.get(#data, or: $value.data),
    error: data.get(#error, or: $value.error),
    state: data.get(#state, or: $value.state),
  );

  @override
  SignUpStateCopyWith<$R2, SignUpState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SignUpStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

