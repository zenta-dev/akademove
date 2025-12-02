// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'driver_home_state.dart';

class DriverHomeStateMapper extends ClassMapperBase<DriverHomeState> {
  DriverHomeStateMapper._();

  static DriverHomeStateMapper? _instance;
  static DriverHomeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DriverHomeStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DriverHomeState';

  static Driver? _$myDriver(DriverHomeState v) => v.myDriver;
  static const Field<DriverHomeState, Driver> _f$myDriver = Field(
    'myDriver',
    _$myDriver,
    opt: true,
  );
  static bool _$isOnline(DriverHomeState v) => v.isOnline;
  static const Field<DriverHomeState, bool> _f$isOnline = Field(
    'isOnline',
    _$isOnline,
    opt: true,
    def: false,
  );
  static num _$todayEarnings(DriverHomeState v) => v.todayEarnings;
  static const Field<DriverHomeState, num> _f$todayEarnings = Field(
    'todayEarnings',
    _$todayEarnings,
    opt: true,
    def: 0,
  );
  static int _$todayTrips(DriverHomeState v) => v.todayTrips;
  static const Field<DriverHomeState, int> _f$todayTrips = Field(
    'todayTrips',
    _$todayTrips,
    opt: true,
    def: 0,
  );
  static Order? _$currentOrder(DriverHomeState v) => v.currentOrder;
  static const Field<DriverHomeState, Order> _f$currentOrder = Field(
    'currentOrder',
    _$currentOrder,
    opt: true,
  );
  static Order? _$incomingOrder(DriverHomeState v) => v.incomingOrder;
  static const Field<DriverHomeState, Order> _f$incomingOrder = Field(
    'incomingOrder',
    _$incomingOrder,
    opt: true,
  );
  static bool _$isLoading(DriverHomeState v) => v.isLoading;
  static const Field<DriverHomeState, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
    opt: true,
    def: false,
  );
  static BaseError? _$error(DriverHomeState v) => v.error;
  static const Field<DriverHomeState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static String? _$message(DriverHomeState v) => v.message;
  static const Field<DriverHomeState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );

  @override
  final MappableFields<DriverHomeState> fields = const {
    #myDriver: _f$myDriver,
    #isOnline: _f$isOnline,
    #todayEarnings: _f$todayEarnings,
    #todayTrips: _f$todayTrips,
    #currentOrder: _f$currentOrder,
    #incomingOrder: _f$incomingOrder,
    #isLoading: _f$isLoading,
    #error: _f$error,
    #message: _f$message,
  };

  static DriverHomeState _instantiate(DecodingData data) {
    return DriverHomeState(
      myDriver: data.dec(_f$myDriver),
      isOnline: data.dec(_f$isOnline),
      todayEarnings: data.dec(_f$todayEarnings),
      todayTrips: data.dec(_f$todayTrips),
      currentOrder: data.dec(_f$currentOrder),
      incomingOrder: data.dec(_f$incomingOrder),
      isLoading: data.dec(_f$isLoading),
      error: data.dec(_f$error),
      message: data.dec(_f$message),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DriverHomeState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DriverHomeState>(map);
  }

  static DriverHomeState fromJson(String json) {
    return ensureInitialized().decodeJson<DriverHomeState>(json);
  }
}

mixin DriverHomeStateMappable {
  String toJson() {
    return DriverHomeStateMapper.ensureInitialized()
        .encodeJson<DriverHomeState>(this as DriverHomeState);
  }

  Map<String, dynamic> toMap() {
    return DriverHomeStateMapper.ensureInitialized().encodeMap<DriverHomeState>(
      this as DriverHomeState,
    );
  }

  DriverHomeStateCopyWith<DriverHomeState, DriverHomeState, DriverHomeState>
  get copyWith =>
      _DriverHomeStateCopyWithImpl<DriverHomeState, DriverHomeState>(
        this as DriverHomeState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DriverHomeStateMapper.ensureInitialized().stringifyValue(
      this as DriverHomeState,
    );
  }

  @override
  bool operator ==(Object other) {
    return DriverHomeStateMapper.ensureInitialized().equalsValue(
      this as DriverHomeState,
      other,
    );
  }

  @override
  int get hashCode {
    return DriverHomeStateMapper.ensureInitialized().hashValue(
      this as DriverHomeState,
    );
  }
}

extension DriverHomeStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DriverHomeState, $Out> {
  DriverHomeStateCopyWith<$R, DriverHomeState, $Out> get $asDriverHomeState =>
      $base.as((v, t, t2) => _DriverHomeStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DriverHomeStateCopyWith<$R, $In extends DriverHomeState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Driver? myDriver,
    bool? isOnline,
    num? todayEarnings,
    int? todayTrips,
    Order? currentOrder,
    Order? incomingOrder,
    bool? isLoading,
    BaseError? error,
    String? message,
  });
  DriverHomeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DriverHomeStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DriverHomeState, $Out>
    implements DriverHomeStateCopyWith<$R, DriverHomeState, $Out> {
  _DriverHomeStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DriverHomeState> $mapper =
      DriverHomeStateMapper.ensureInitialized();
  @override
  $R call({
    Object? myDriver = $none,
    bool? isOnline,
    num? todayEarnings,
    int? todayTrips,
    Object? currentOrder = $none,
    Object? incomingOrder = $none,
    bool? isLoading,
    Object? error = $none,
    Object? message = $none,
  }) => $apply(
    FieldCopyWithData({
      if (myDriver != $none) #myDriver: myDriver,
      if (isOnline != null) #isOnline: isOnline,
      if (todayEarnings != null) #todayEarnings: todayEarnings,
      if (todayTrips != null) #todayTrips: todayTrips,
      if (currentOrder != $none) #currentOrder: currentOrder,
      if (incomingOrder != $none) #incomingOrder: incomingOrder,
      if (isLoading != null) #isLoading: isLoading,
      if (error != $none) #error: error,
      if (message != $none) #message: message,
    }),
  );
  @override
  DriverHomeState $make(CopyWithData data) => DriverHomeState(
    myDriver: data.get(#myDriver, or: $value.myDriver),
    isOnline: data.get(#isOnline, or: $value.isOnline),
    todayEarnings: data.get(#todayEarnings, or: $value.todayEarnings),
    todayTrips: data.get(#todayTrips, or: $value.todayTrips),
    currentOrder: data.get(#currentOrder, or: $value.currentOrder),
    incomingOrder: data.get(#incomingOrder, or: $value.incomingOrder),
    isLoading: data.get(#isLoading, or: $value.isLoading),
    error: data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
  );

  @override
  DriverHomeStateCopyWith<$R2, DriverHomeState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DriverHomeStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

