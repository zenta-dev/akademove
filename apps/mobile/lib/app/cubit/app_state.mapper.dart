// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'app_state.dart';

class AppStateMapper extends ClassMapperBase<AppState> {
  AppStateMapper._();

  static AppStateMapper? _instance;
  static AppStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppStateMapper._());
      InternalAppStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppState';

  static InternalAppState? _$data(AppState v) => v.data;
  static const Field<AppState, InternalAppState> _f$data = Field(
    'data',
    _$data,
    opt: true,
  );
  static Exception? _$error(AppState v) => v.error;
  static const Field<AppState, Exception> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static CubitState _$state(AppState v) => v.state;
  static const Field<AppState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );

  @override
  final MappableFields<AppState> fields = const {
    #data: _f$data,
    #error: _f$error,
    #state: _f$state,
  };

  static AppState _instantiate(DecodingData data) {
    return AppState(
      data: data.dec(_f$data),
      error: data.dec(_f$error),
      state: data.dec(_f$state),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppState>(map);
  }

  static AppState fromJson(String json) {
    return ensureInitialized().decodeJson<AppState>(json);
  }
}

mixin AppStateMappable {
  String toJson() {
    return AppStateMapper.ensureInitialized().encodeJson<AppState>(
      this as AppState,
    );
  }

  Map<String, dynamic> toMap() {
    return AppStateMapper.ensureInitialized().encodeMap<AppState>(
      this as AppState,
    );
  }

  AppStateCopyWith<AppState, AppState, AppState> get copyWith =>
      _AppStateCopyWithImpl<AppState, AppState>(
        this as AppState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppStateMapper.ensureInitialized().stringifyValue(this as AppState);
  }

  @override
  bool operator ==(Object other) {
    return AppStateMapper.ensureInitialized().equalsValue(
      this as AppState,
      other,
    );
  }

  @override
  int get hashCode {
    return AppStateMapper.ensureInitialized().hashValue(this as AppState);
  }
}

extension AppStateValueCopy<$R, $Out> on ObjectCopyWith<$R, AppState, $Out> {
  AppStateCopyWith<$R, AppState, $Out> get $asAppState =>
      $base.as((v, t, t2) => _AppStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppStateCopyWith<$R, $In extends AppState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  InternalAppStateCopyWith<$R, InternalAppState, InternalAppState>? get data;
  $R call({InternalAppState? data, Exception? error, CubitState? state});
  AppStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AppStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppState, $Out>
    implements AppStateCopyWith<$R, AppState, $Out> {
  _AppStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppState> $mapper =
      AppStateMapper.ensureInitialized();
  @override
  InternalAppStateCopyWith<$R, InternalAppState, InternalAppState>? get data =>
      $value.data?.copyWith.$chain((v) => call(data: v));
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
  AppState $make(CopyWithData data) => AppState(
    data: data.get(#data, or: $value.data),
    error: data.get(#error, or: $value.error),
    state: data.get(#state, or: $value.state),
  );

  @override
  AppStateCopyWith<$R2, AppState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class InternalAppStateMapper extends ClassMapperBase<InternalAppState> {
  InternalAppStateMapper._();

  static InternalAppStateMapper? _instance;
  static InternalAppStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InternalAppStateMapper._());
      MapperContainer.globals.useAll([ThemeModeMapper(), LocaleMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'InternalAppState';

  static ThemeMode _$themeMode(InternalAppState v) => v.themeMode;
  static const Field<InternalAppState, ThemeMode> _f$themeMode = Field(
    'themeMode',
    _$themeMode,
    opt: true,
    def: ThemeMode.system,
  );
  static Locale _$locale(InternalAppState v) => v.locale;
  static const Field<InternalAppState, Locale> _f$locale = Field(
    'locale',
    _$locale,
    opt: true,
    def: const Locale('en'),
  );

  @override
  final MappableFields<InternalAppState> fields = const {
    #themeMode: _f$themeMode,
    #locale: _f$locale,
  };

  static InternalAppState _instantiate(DecodingData data) {
    return InternalAppState(
      themeMode: data.dec(_f$themeMode),
      locale: data.dec(_f$locale),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static InternalAppState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InternalAppState>(map);
  }

  static InternalAppState fromJson(String json) {
    return ensureInitialized().decodeJson<InternalAppState>(json);
  }
}

mixin InternalAppStateMappable {
  String toJson() {
    return InternalAppStateMapper.ensureInitialized()
        .encodeJson<InternalAppState>(this as InternalAppState);
  }

  Map<String, dynamic> toMap() {
    return InternalAppStateMapper.ensureInitialized()
        .encodeMap<InternalAppState>(this as InternalAppState);
  }

  InternalAppStateCopyWith<InternalAppState, InternalAppState, InternalAppState>
  get copyWith =>
      _InternalAppStateCopyWithImpl<InternalAppState, InternalAppState>(
        this as InternalAppState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return InternalAppStateMapper.ensureInitialized().stringifyValue(
      this as InternalAppState,
    );
  }

  @override
  bool operator ==(Object other) {
    return InternalAppStateMapper.ensureInitialized().equalsValue(
      this as InternalAppState,
      other,
    );
  }

  @override
  int get hashCode {
    return InternalAppStateMapper.ensureInitialized().hashValue(
      this as InternalAppState,
    );
  }
}

extension InternalAppStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InternalAppState, $Out> {
  InternalAppStateCopyWith<$R, InternalAppState, $Out>
  get $asInternalAppState =>
      $base.as((v, t, t2) => _InternalAppStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class InternalAppStateCopyWith<$R, $In extends InternalAppState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({ThemeMode? themeMode, Locale? locale});
  InternalAppStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _InternalAppStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InternalAppState, $Out>
    implements InternalAppStateCopyWith<$R, InternalAppState, $Out> {
  _InternalAppStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InternalAppState> $mapper =
      InternalAppStateMapper.ensureInitialized();
  @override
  $R call({ThemeMode? themeMode, Locale? locale}) => $apply(
    FieldCopyWithData({
      if (themeMode != null) #themeMode: themeMode,
      if (locale != null) #locale: locale,
    }),
  );
  @override
  InternalAppState $make(CopyWithData data) => InternalAppState(
    themeMode: data.get(#themeMode, or: $value.themeMode),
    locale: data.get(#locale, or: $value.locale),
  );

  @override
  InternalAppStateCopyWith<$R2, InternalAppState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _InternalAppStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

