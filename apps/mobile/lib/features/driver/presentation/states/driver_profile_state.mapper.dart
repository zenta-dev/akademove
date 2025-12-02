// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'driver_profile_state.dart';

class DriverProfileStateMapper extends ClassMapperBase<DriverProfileState> {
  DriverProfileStateMapper._();

  static DriverProfileStateMapper? _instance;
  static DriverProfileStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DriverProfileStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DriverProfileState';

  static Driver? _$myDriver(DriverProfileState v) => v.myDriver;
  static const Field<DriverProfileState, Driver> _f$myDriver = Field(
    'myDriver',
    _$myDriver,
    opt: true,
  );
  static bool _$isLoading(DriverProfileState v) => v.isLoading;
  static const Field<DriverProfileState, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
    opt: true,
    def: false,
  );
  static BaseError? _$error(DriverProfileState v) => v.error;
  static const Field<DriverProfileState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static String? _$message(DriverProfileState v) => v.message;
  static const Field<DriverProfileState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );

  @override
  final MappableFields<DriverProfileState> fields = const {
    #myDriver: _f$myDriver,
    #isLoading: _f$isLoading,
    #error: _f$error,
    #message: _f$message,
  };

  static DriverProfileState _instantiate(DecodingData data) {
    return DriverProfileState(
      myDriver: data.dec(_f$myDriver),
      isLoading: data.dec(_f$isLoading),
      error: data.dec(_f$error),
      message: data.dec(_f$message),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DriverProfileState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DriverProfileState>(map);
  }

  static DriverProfileState fromJson(String json) {
    return ensureInitialized().decodeJson<DriverProfileState>(json);
  }
}

mixin DriverProfileStateMappable {
  String toJson() {
    return DriverProfileStateMapper.ensureInitialized()
        .encodeJson<DriverProfileState>(this as DriverProfileState);
  }

  Map<String, dynamic> toMap() {
    return DriverProfileStateMapper.ensureInitialized()
        .encodeMap<DriverProfileState>(this as DriverProfileState);
  }

  DriverProfileStateCopyWith<
    DriverProfileState,
    DriverProfileState,
    DriverProfileState
  >
  get copyWith =>
      _DriverProfileStateCopyWithImpl<DriverProfileState, DriverProfileState>(
        this as DriverProfileState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DriverProfileStateMapper.ensureInitialized().stringifyValue(
      this as DriverProfileState,
    );
  }

  @override
  bool operator ==(Object other) {
    return DriverProfileStateMapper.ensureInitialized().equalsValue(
      this as DriverProfileState,
      other,
    );
  }

  @override
  int get hashCode {
    return DriverProfileStateMapper.ensureInitialized().hashValue(
      this as DriverProfileState,
    );
  }
}

extension DriverProfileStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DriverProfileState, $Out> {
  DriverProfileStateCopyWith<$R, DriverProfileState, $Out>
  get $asDriverProfileState => $base.as(
    (v, t, t2) => _DriverProfileStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DriverProfileStateCopyWith<
  $R,
  $In extends DriverProfileState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Driver? myDriver,
    bool? isLoading,
    BaseError? error,
    String? message,
  });
  DriverProfileStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DriverProfileStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DriverProfileState, $Out>
    implements DriverProfileStateCopyWith<$R, DriverProfileState, $Out> {
  _DriverProfileStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DriverProfileState> $mapper =
      DriverProfileStateMapper.ensureInitialized();
  @override
  $R call({
    Object? myDriver = $none,
    bool? isLoading,
    Object? error = $none,
    Object? message = $none,
  }) => $apply(
    FieldCopyWithData({
      if (myDriver != $none) #myDriver: myDriver,
      if (isLoading != null) #isLoading: isLoading,
      if (error != $none) #error: error,
      if (message != $none) #message: message,
    }),
  );
  @override
  DriverProfileState $make(CopyWithData data) => DriverProfileState(
    myDriver: data.get(#myDriver, or: $value.myDriver),
    isLoading: data.get(#isLoading, or: $value.isLoading),
    error: data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
  );

  @override
  DriverProfileStateCopyWith<$R2, DriverProfileState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DriverProfileStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

