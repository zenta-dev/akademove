// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_export.dart';

class DriverEarningsStateMapper extends ClassMapperBase<DriverEarningsState> {
  DriverEarningsStateMapper._();

  static DriverEarningsStateMapper? _instance;
  static DriverEarningsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DriverEarningsStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DriverEarningsState';

  static CubitState _$state(DriverEarningsState v) => v.state;
  static const Field<DriverEarningsState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(DriverEarningsState v) => v.message;
  static const Field<DriverEarningsState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(DriverEarningsState v) => v.error;
  static const Field<DriverEarningsState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static Wallet? _$wallet(DriverEarningsState v) => v.wallet;
  static const Field<DriverEarningsState, Wallet> _f$wallet = Field(
    'wallet',
    _$wallet,
    opt: true,
  );
  static List<Transaction> _$transactions(DriverEarningsState v) =>
      v.transactions;
  static const Field<DriverEarningsState, List<Transaction>> _f$transactions =
      Field('transactions', _$transactions, opt: true, def: const []);
  static Object? _$monthlySummary(DriverEarningsState v) => v.monthlySummary;
  static const Field<DriverEarningsState, Object> _f$monthlySummary = Field(
    'monthlySummary',
    _$monthlySummary,
    opt: true,
  );
  static EarningsPeriod _$selectedPeriod(DriverEarningsState v) =>
      v.selectedPeriod;
  static const Field<DriverEarningsState, EarningsPeriod> _f$selectedPeriod =
      Field(
        'selectedPeriod',
        _$selectedPeriod,
        opt: true,
        def: EarningsPeriod.daily,
      );

  @override
  final MappableFields<DriverEarningsState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #wallet: _f$wallet,
    #transactions: _f$transactions,
    #monthlySummary: _f$monthlySummary,
    #selectedPeriod: _f$selectedPeriod,
  };

  static DriverEarningsState _instantiate(DecodingData data) {
    return DriverEarningsState(
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
      wallet: data.dec(_f$wallet),
      transactions: data.dec(_f$transactions),
      monthlySummary: data.dec(_f$monthlySummary),
      selectedPeriod: data.dec(_f$selectedPeriod),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DriverEarningsStateMappable {
  DriverEarningsStateCopyWith<
    DriverEarningsState,
    DriverEarningsState,
    DriverEarningsState
  >
  get copyWith =>
      _DriverEarningsStateCopyWithImpl<
        DriverEarningsState,
        DriverEarningsState
      >(this as DriverEarningsState, $identity, $identity);
  @override
  String toString() {
    return DriverEarningsStateMapper.ensureInitialized().stringifyValue(
      this as DriverEarningsState,
    );
  }

  @override
  bool operator ==(Object other) {
    return DriverEarningsStateMapper.ensureInitialized().equalsValue(
      this as DriverEarningsState,
      other,
    );
  }

  @override
  int get hashCode {
    return DriverEarningsStateMapper.ensureInitialized().hashValue(
      this as DriverEarningsState,
    );
  }
}

extension DriverEarningsStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DriverEarningsState, $Out> {
  DriverEarningsStateCopyWith<$R, DriverEarningsState, $Out>
  get $asDriverEarningsState => $base.as(
    (v, t, t2) => _DriverEarningsStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DriverEarningsStateCopyWith<
  $R,
  $In extends DriverEarningsState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Transaction, ObjectCopyWith<$R, Transaction, Transaction>>
  get transactions;
  $R call({
    CubitState? state,
    String? message,
    BaseError? error,
    Wallet? wallet,
    List<Transaction>? transactions,
    Object? monthlySummary,
    EarningsPeriod? selectedPeriod,
  });
  DriverEarningsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DriverEarningsStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DriverEarningsState, $Out>
    implements DriverEarningsStateCopyWith<$R, DriverEarningsState, $Out> {
  _DriverEarningsStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DriverEarningsState> $mapper =
      DriverEarningsStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Transaction, ObjectCopyWith<$R, Transaction, Transaction>>
  get transactions => ListCopyWith(
    $value.transactions,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(transactions: v),
  );
  @override
  $R call({
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
    Object? wallet = $none,
    List<Transaction>? transactions,
    Object? monthlySummary = $none,
    EarningsPeriod? selectedPeriod,
  }) => $apply(
    FieldCopyWithData({
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
      if (wallet != $none) #wallet: wallet,
      if (transactions != null) #transactions: transactions,
      if (monthlySummary != $none) #monthlySummary: monthlySummary,
      if (selectedPeriod != null) #selectedPeriod: selectedPeriod,
    }),
  );
  @override
  DriverEarningsState $make(CopyWithData data) => DriverEarningsState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    wallet: data.get(#wallet, or: $value.wallet),
    transactions: data.get(#transactions, or: $value.transactions),
    monthlySummary: data.get(#monthlySummary, or: $value.monthlySummary),
    selectedPeriod: data.get(#selectedPeriod, or: $value.selectedPeriod),
  );

  @override
  DriverEarningsStateCopyWith<$R2, DriverEarningsState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DriverEarningsStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DriverOrderStateMapper extends ClassMapperBase<DriverOrderState> {
  DriverOrderStateMapper._();

  static DriverOrderStateMapper? _instance;
  static DriverOrderStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DriverOrderStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DriverOrderState';

  static CubitState _$state(DriverOrderState v) => v.state;
  static const Field<DriverOrderState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(DriverOrderState v) => v.message;
  static const Field<DriverOrderState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(DriverOrderState v) => v.error;
  static const Field<DriverOrderState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static Order? _$incomingOrder(DriverOrderState v) => v.incomingOrder;
  static const Field<DriverOrderState, Order> _f$incomingOrder = Field(
    'incomingOrder',
    _$incomingOrder,
    opt: true,
  );
  static Order? _$activeOrder(DriverOrderState v) => v.activeOrder;
  static const Field<DriverOrderState, Order> _f$activeOrder = Field(
    'activeOrder',
    _$activeOrder,
    opt: true,
  );
  static List<Order>? _$orderHistory(DriverOrderState v) => v.orderHistory;
  static const Field<DriverOrderState, List<Order>> _f$orderHistory = Field(
    'orderHistory',
    _$orderHistory,
    opt: true,
  );
  static Coordinate? _$currentLocation(DriverOrderState v) => v.currentLocation;
  static const Field<DriverOrderState, Coordinate> _f$currentLocation = Field(
    'currentLocation',
    _$currentLocation,
    opt: true,
  );
  static Coordinate? _$pickupLocation(DriverOrderState v) => v.pickupLocation;
  static const Field<DriverOrderState, Coordinate> _f$pickupLocation = Field(
    'pickupLocation',
    _$pickupLocation,
    opt: true,
  );
  static Coordinate? _$dropoffLocation(DriverOrderState v) => v.dropoffLocation;
  static const Field<DriverOrderState, Coordinate> _f$dropoffLocation = Field(
    'dropoffLocation',
    _$dropoffLocation,
    opt: true,
  );
  static GoogleMapController? _$mapController(DriverOrderState v) =>
      v.mapController;
  static const Field<DriverOrderState, GoogleMapController> _f$mapController =
      Field('mapController', _$mapController, opt: true);
  static Set<Polyline> _$routePolylines(DriverOrderState v) => v.routePolylines;
  static const Field<DriverOrderState, Set<Polyline>> _f$routePolylines = Field(
    'routePolylines',
    _$routePolylines,
    opt: true,
    def: const {},
  );
  static Marker? _$customerMarker(DriverOrderState v) => v.customerMarker;
  static const Field<DriverOrderState, Marker> _f$customerMarker = Field(
    'customerMarker',
    _$customerMarker,
    opt: true,
  );
  static Marker? _$pickupMarker(DriverOrderState v) => v.pickupMarker;
  static const Field<DriverOrderState, Marker> _f$pickupMarker = Field(
    'pickupMarker',
    _$pickupMarker,
    opt: true,
  );
  static Marker? _$dropoffMarker(DriverOrderState v) => v.dropoffMarker;
  static const Field<DriverOrderState, Marker> _f$dropoffMarker = Field(
    'dropoffMarker',
    _$dropoffMarker,
    opt: true,
  );

  @override
  final MappableFields<DriverOrderState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #incomingOrder: _f$incomingOrder,
    #activeOrder: _f$activeOrder,
    #orderHistory: _f$orderHistory,
    #currentLocation: _f$currentLocation,
    #pickupLocation: _f$pickupLocation,
    #dropoffLocation: _f$dropoffLocation,
    #mapController: _f$mapController,
    #routePolylines: _f$routePolylines,
    #customerMarker: _f$customerMarker,
    #pickupMarker: _f$pickupMarker,
    #dropoffMarker: _f$dropoffMarker,
  };

  static DriverOrderState _instantiate(DecodingData data) {
    return DriverOrderState(
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
      incomingOrder: data.dec(_f$incomingOrder),
      activeOrder: data.dec(_f$activeOrder),
      orderHistory: data.dec(_f$orderHistory),
      currentLocation: data.dec(_f$currentLocation),
      pickupLocation: data.dec(_f$pickupLocation),
      dropoffLocation: data.dec(_f$dropoffLocation),
      mapController: data.dec(_f$mapController),
      routePolylines: data.dec(_f$routePolylines),
      customerMarker: data.dec(_f$customerMarker),
      pickupMarker: data.dec(_f$pickupMarker),
      dropoffMarker: data.dec(_f$dropoffMarker),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DriverOrderStateMappable {
  DriverOrderStateCopyWith<DriverOrderState, DriverOrderState, DriverOrderState>
  get copyWith =>
      _DriverOrderStateCopyWithImpl<DriverOrderState, DriverOrderState>(
        this as DriverOrderState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DriverOrderStateMapper.ensureInitialized().stringifyValue(
      this as DriverOrderState,
    );
  }

  @override
  bool operator ==(Object other) {
    return DriverOrderStateMapper.ensureInitialized().equalsValue(
      this as DriverOrderState,
      other,
    );
  }

  @override
  int get hashCode {
    return DriverOrderStateMapper.ensureInitialized().hashValue(
      this as DriverOrderState,
    );
  }
}

extension DriverOrderStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DriverOrderState, $Out> {
  DriverOrderStateCopyWith<$R, DriverOrderState, $Out>
  get $asDriverOrderState =>
      $base.as((v, t, t2) => _DriverOrderStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DriverOrderStateCopyWith<$R, $In extends DriverOrderState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Order, ObjectCopyWith<$R, Order, Order>>? get orderHistory;
  $R call({
    CubitState? state,
    String? message,
    BaseError? error,
    Order? incomingOrder,
    Order? activeOrder,
    List<Order>? orderHistory,
    Coordinate? currentLocation,
    Coordinate? pickupLocation,
    Coordinate? dropoffLocation,
    GoogleMapController? mapController,
    Set<Polyline>? routePolylines,
    Marker? customerMarker,
    Marker? pickupMarker,
    Marker? dropoffMarker,
  });
  DriverOrderStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DriverOrderStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DriverOrderState, $Out>
    implements DriverOrderStateCopyWith<$R, DriverOrderState, $Out> {
  _DriverOrderStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DriverOrderState> $mapper =
      DriverOrderStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Order, ObjectCopyWith<$R, Order, Order>>? get orderHistory =>
      $value.orderHistory != null
      ? ListCopyWith(
          $value.orderHistory!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(orderHistory: v),
        )
      : null;
  @override
  $R call({
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
    Object? incomingOrder = $none,
    Object? activeOrder = $none,
    Object? orderHistory = $none,
    Object? currentLocation = $none,
    Object? pickupLocation = $none,
    Object? dropoffLocation = $none,
    Object? mapController = $none,
    Set<Polyline>? routePolylines,
    Object? customerMarker = $none,
    Object? pickupMarker = $none,
    Object? dropoffMarker = $none,
  }) => $apply(
    FieldCopyWithData({
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
      if (incomingOrder != $none) #incomingOrder: incomingOrder,
      if (activeOrder != $none) #activeOrder: activeOrder,
      if (orderHistory != $none) #orderHistory: orderHistory,
      if (currentLocation != $none) #currentLocation: currentLocation,
      if (pickupLocation != $none) #pickupLocation: pickupLocation,
      if (dropoffLocation != $none) #dropoffLocation: dropoffLocation,
      if (mapController != $none) #mapController: mapController,
      if (routePolylines != null) #routePolylines: routePolylines,
      if (customerMarker != $none) #customerMarker: customerMarker,
      if (pickupMarker != $none) #pickupMarker: pickupMarker,
      if (dropoffMarker != $none) #dropoffMarker: dropoffMarker,
    }),
  );
  @override
  DriverOrderState $make(CopyWithData data) => DriverOrderState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    incomingOrder: data.get(#incomingOrder, or: $value.incomingOrder),
    activeOrder: data.get(#activeOrder, or: $value.activeOrder),
    orderHistory: data.get(#orderHistory, or: $value.orderHistory),
    currentLocation: data.get(#currentLocation, or: $value.currentLocation),
    pickupLocation: data.get(#pickupLocation, or: $value.pickupLocation),
    dropoffLocation: data.get(#dropoffLocation, or: $value.dropoffLocation),
    mapController: data.get(#mapController, or: $value.mapController),
    routePolylines: data.get(#routePolylines, or: $value.routePolylines),
    customerMarker: data.get(#customerMarker, or: $value.customerMarker),
    pickupMarker: data.get(#pickupMarker, or: $value.pickupMarker),
    dropoffMarker: data.get(#dropoffMarker, or: $value.dropoffMarker),
  );

  @override
  DriverOrderStateCopyWith<$R2, DriverOrderState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DriverOrderStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DriverScheduleStateMapper extends ClassMapperBase<DriverScheduleState> {
  DriverScheduleStateMapper._();

  static DriverScheduleStateMapper? _instance;
  static DriverScheduleStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DriverScheduleStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DriverScheduleState';

  static CubitState _$state(DriverScheduleState v) => v.state;
  static const Field<DriverScheduleState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(DriverScheduleState v) => v.message;
  static const Field<DriverScheduleState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(DriverScheduleState v) => v.error;
  static const Field<DriverScheduleState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static List<DriverSchedule> _$schedules(DriverScheduleState v) => v.schedules;
  static const Field<DriverScheduleState, List<DriverSchedule>> _f$schedules =
      Field('schedules', _$schedules, opt: true, def: const []);
  static DriverSchedule? _$selectedSchedule(DriverScheduleState v) =>
      v.selectedSchedule;
  static const Field<DriverScheduleState, DriverSchedule> _f$selectedSchedule =
      Field('selectedSchedule', _$selectedSchedule, opt: true);

  @override
  final MappableFields<DriverScheduleState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #schedules: _f$schedules,
    #selectedSchedule: _f$selectedSchedule,
  };

  static DriverScheduleState _instantiate(DecodingData data) {
    return DriverScheduleState(
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
      schedules: data.dec(_f$schedules),
      selectedSchedule: data.dec(_f$selectedSchedule),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DriverScheduleStateMappable {
  DriverScheduleStateCopyWith<
    DriverScheduleState,
    DriverScheduleState,
    DriverScheduleState
  >
  get copyWith =>
      _DriverScheduleStateCopyWithImpl<
        DriverScheduleState,
        DriverScheduleState
      >(this as DriverScheduleState, $identity, $identity);
  @override
  String toString() {
    return DriverScheduleStateMapper.ensureInitialized().stringifyValue(
      this as DriverScheduleState,
    );
  }

  @override
  bool operator ==(Object other) {
    return DriverScheduleStateMapper.ensureInitialized().equalsValue(
      this as DriverScheduleState,
      other,
    );
  }

  @override
  int get hashCode {
    return DriverScheduleStateMapper.ensureInitialized().hashValue(
      this as DriverScheduleState,
    );
  }
}

extension DriverScheduleStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DriverScheduleState, $Out> {
  DriverScheduleStateCopyWith<$R, DriverScheduleState, $Out>
  get $asDriverScheduleState => $base.as(
    (v, t, t2) => _DriverScheduleStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DriverScheduleStateCopyWith<
  $R,
  $In extends DriverScheduleState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    DriverSchedule,
    ObjectCopyWith<$R, DriverSchedule, DriverSchedule>
  >
  get schedules;
  $R call({
    CubitState? state,
    String? message,
    BaseError? error,
    List<DriverSchedule>? schedules,
    DriverSchedule? selectedSchedule,
  });
  DriverScheduleStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DriverScheduleStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DriverScheduleState, $Out>
    implements DriverScheduleStateCopyWith<$R, DriverScheduleState, $Out> {
  _DriverScheduleStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DriverScheduleState> $mapper =
      DriverScheduleStateMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    DriverSchedule,
    ObjectCopyWith<$R, DriverSchedule, DriverSchedule>
  >
  get schedules => ListCopyWith(
    $value.schedules,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(schedules: v),
  );
  @override
  $R call({
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
    List<DriverSchedule>? schedules,
    Object? selectedSchedule = $none,
  }) => $apply(
    FieldCopyWithData({
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
      if (schedules != null) #schedules: schedules,
      if (selectedSchedule != $none) #selectedSchedule: selectedSchedule,
    }),
  );
  @override
  DriverScheduleState $make(CopyWithData data) => DriverScheduleState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    schedules: data.get(#schedules, or: $value.schedules),
    selectedSchedule: data.get(#selectedSchedule, or: $value.selectedSchedule),
  );

  @override
  DriverScheduleStateCopyWith<$R2, DriverScheduleState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DriverScheduleStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DriverStateMapper extends ClassMapperBase<DriverState> {
  DriverStateMapper._();

  static DriverStateMapper? _instance;
  static DriverStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DriverStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DriverState';

  static CubitState _$state(DriverState v) => v.state;
  static const Field<DriverState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(DriverState v) => v.message;
  static const Field<DriverState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(DriverState v) => v.error;
  static const Field<DriverState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static Driver? _$driver(DriverState v) => v.driver;
  static const Field<DriverState, Driver> _f$driver = Field(
    'driver',
    _$driver,
    opt: true,
  );
  static bool? _$isOnline(DriverState v) => v.isOnline;
  static const Field<DriverState, bool> _f$isOnline = Field(
    'isOnline',
    _$isOnline,
    opt: true,
  );
  static Order? _$activeOrder(DriverState v) => v.activeOrder;
  static const Field<DriverState, Order> _f$activeOrder = Field(
    'activeOrder',
    _$activeOrder,
    opt: true,
  );
  static num? _$todayEarnings(DriverState v) => v.todayEarnings;
  static const Field<DriverState, num> _f$todayEarnings = Field(
    'todayEarnings',
    _$todayEarnings,
    opt: true,
  );
  static int? _$todayTrips(DriverState v) => v.todayTrips;
  static const Field<DriverState, int> _f$todayTrips = Field(
    'todayTrips',
    _$todayTrips,
    opt: true,
  );

  @override
  final MappableFields<DriverState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #driver: _f$driver,
    #isOnline: _f$isOnline,
    #activeOrder: _f$activeOrder,
    #todayEarnings: _f$todayEarnings,
    #todayTrips: _f$todayTrips,
  };

  static DriverState _instantiate(DecodingData data) {
    return DriverState(
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
      driver: data.dec(_f$driver),
      isOnline: data.dec(_f$isOnline),
      activeOrder: data.dec(_f$activeOrder),
      todayEarnings: data.dec(_f$todayEarnings),
      todayTrips: data.dec(_f$todayTrips),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DriverStateMappable {
  DriverStateCopyWith<DriverState, DriverState, DriverState> get copyWith =>
      _DriverStateCopyWithImpl<DriverState, DriverState>(
        this as DriverState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DriverStateMapper.ensureInitialized().stringifyValue(
      this as DriverState,
    );
  }

  @override
  bool operator ==(Object other) {
    return DriverStateMapper.ensureInitialized().equalsValue(
      this as DriverState,
      other,
    );
  }

  @override
  int get hashCode {
    return DriverStateMapper.ensureInitialized().hashValue(this as DriverState);
  }
}

extension DriverStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DriverState, $Out> {
  DriverStateCopyWith<$R, DriverState, $Out> get $asDriverState =>
      $base.as((v, t, t2) => _DriverStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DriverStateCopyWith<$R, $In extends DriverState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    CubitState? state,
    String? message,
    BaseError? error,
    Driver? driver,
    bool? isOnline,
    Order? activeOrder,
    num? todayEarnings,
    int? todayTrips,
  });
  DriverStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DriverStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DriverState, $Out>
    implements DriverStateCopyWith<$R, DriverState, $Out> {
  _DriverStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DriverState> $mapper =
      DriverStateMapper.ensureInitialized();
  @override
  $R call({
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
    Object? driver = $none,
    Object? isOnline = $none,
    Object? activeOrder = $none,
    Object? todayEarnings = $none,
    Object? todayTrips = $none,
  }) => $apply(
    FieldCopyWithData({
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
      if (driver != $none) #driver: driver,
      if (isOnline != $none) #isOnline: isOnline,
      if (activeOrder != $none) #activeOrder: activeOrder,
      if (todayEarnings != $none) #todayEarnings: todayEarnings,
      if (todayTrips != $none) #todayTrips: todayTrips,
    }),
  );
  @override
  DriverState $make(CopyWithData data) => DriverState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    driver: data.get(#driver, or: $value.driver),
    isOnline: data.get(#isOnline, or: $value.isOnline),
    activeOrder: data.get(#activeOrder, or: $value.activeOrder),
    todayEarnings: data.get(#todayEarnings, or: $value.todayEarnings),
    todayTrips: data.get(#todayTrips, or: $value.todayTrips),
  );

  @override
  DriverStateCopyWith<$R2, DriverState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DriverStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

