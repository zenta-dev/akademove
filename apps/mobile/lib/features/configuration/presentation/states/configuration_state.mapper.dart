// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'configuration_state.dart';

class ConfigurationStateMapper extends ClassMapperBase<ConfigurationState> {
  ConfigurationStateMapper._();

  static ConfigurationStateMapper? _instance;
  static ConfigurationStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConfigurationStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ConfigurationState';

  static CubitState _$state(ConfigurationState v) => v.state;
  static const Field<ConfigurationState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(ConfigurationState v) => v.message;
  static const Field<ConfigurationState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(ConfigurationState v) => v.error;
  static const Field<ConfigurationState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static List<Configuration> _$list(ConfigurationState v) => v.list;
  static const Field<ConfigurationState, List<Configuration>> _f$list = Field(
    'list',
    _$list,
    opt: true,
    def: const [],
  );
  static Configuration? _$selected(ConfigurationState v) => v.selected;
  static const Field<ConfigurationState, Configuration> _f$selected = Field(
    'selected',
    _$selected,
    opt: true,
  );

  @override
  final MappableFields<ConfigurationState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #list: _f$list,
    #selected: _f$selected,
  };

  static ConfigurationState _instantiate(DecodingData data) {
    return ConfigurationState(
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

mixin ConfigurationStateMappable {
  ConfigurationStateCopyWith<
    ConfigurationState,
    ConfigurationState,
    ConfigurationState
  >
  get copyWith =>
      _ConfigurationStateCopyWithImpl<ConfigurationState, ConfigurationState>(
        this as ConfigurationState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ConfigurationStateMapper.ensureInitialized().stringifyValue(
      this as ConfigurationState,
    );
  }

  @override
  bool operator ==(Object other) {
    return ConfigurationStateMapper.ensureInitialized().equalsValue(
      this as ConfigurationState,
      other,
    );
  }

  @override
  int get hashCode {
    return ConfigurationStateMapper.ensureInitialized().hashValue(
      this as ConfigurationState,
    );
  }
}

extension ConfigurationStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ConfigurationState, $Out> {
  ConfigurationStateCopyWith<$R, ConfigurationState, $Out>
  get $asConfigurationState => $base.as(
    (v, t, t2) => _ConfigurationStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ConfigurationStateCopyWith<
  $R,
  $In extends ConfigurationState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    Configuration,
    ObjectCopyWith<$R, Configuration, Configuration>
  >
  get list;
  $R call({
    CubitState? state,
    String? message,
    BaseError? error,
    List<Configuration>? list,
    Configuration? selected,
  });
  ConfigurationStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ConfigurationStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ConfigurationState, $Out>
    implements ConfigurationStateCopyWith<$R, ConfigurationState, $Out> {
  _ConfigurationStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConfigurationState> $mapper =
      ConfigurationStateMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    Configuration,
    ObjectCopyWith<$R, Configuration, Configuration>
  >
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
    List<Configuration>? list,
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
  ConfigurationState $make(CopyWithData data) => ConfigurationState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    list: data.get(#list, or: $value.list),
    selected: data.get(#selected, or: $value.selected),
  );

  @override
  ConfigurationStateCopyWith<$R2, ConfigurationState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ConfigurationStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

