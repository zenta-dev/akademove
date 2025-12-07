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

  static CubitState _$state(DriverHomeState v) => v.state;
  static const Field<DriverHomeState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(DriverHomeState v) => v.message;
  static const Field<DriverHomeState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(DriverHomeState v) => v.error;
  static const Field<DriverHomeState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
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

  @override
  final MappableFields<DriverHomeState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #myDriver: _f$myDriver,
    #isOnline: _f$isOnline,
    #todayEarnings: _f$todayEarnings,
    #todayTrips: _f$todayTrips,
    #currentOrder: _f$currentOrder,
    #incomingOrder: _f$incomingOrder,
  };

  static DriverHomeState _instantiate(DecodingData data) {
    return DriverHomeState(
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
      myDriver: data.dec(_f$myDriver),
      isOnline: data.dec(_f$isOnline),
      todayEarnings: data.dec(_f$todayEarnings),
      todayTrips: data.dec(_f$todayTrips),
      currentOrder: data.dec(_f$currentOrder),
      incomingOrder: data.dec(_f$incomingOrder),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DriverHomeStateMappable {
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
    CubitState? state,
    String? message,
    BaseError? error,
    Driver? myDriver,
    bool? isOnline,
    num? todayEarnings,
    int? todayTrips,
    Order? currentOrder,
    Order? incomingOrder,
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
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
    Object? myDriver = $none,
    bool? isOnline,
    num? todayEarnings,
    int? todayTrips,
    Object? currentOrder = $none,
    Object? incomingOrder = $none,
  }) => $apply(
    FieldCopyWithData({
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
      if (myDriver != $none) #myDriver: myDriver,
      if (isOnline != null) #isOnline: isOnline,
      if (todayEarnings != null) #todayEarnings: todayEarnings,
      if (todayTrips != null) #todayTrips: todayTrips,
      if (currentOrder != $none) #currentOrder: currentOrder,
      if (incomingOrder != $none) #incomingOrder: incomingOrder,
    }),
  );
  @override
  DriverHomeState $make(CopyWithData data) => DriverHomeState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    myDriver: data.get(#myDriver, or: $value.myDriver),
    isOnline: data.get(#isOnline, or: $value.isOnline),
    todayEarnings: data.get(#todayEarnings, or: $value.todayEarnings),
    todayTrips: data.get(#todayTrips, or: $value.todayTrips),
    currentOrder: data.get(#currentOrder, or: $value.currentOrder),
    incomingOrder: data.get(#incomingOrder, or: $value.incomingOrder),
  );

  @override
  DriverHomeStateCopyWith<$R2, DriverHomeState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DriverHomeStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
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
  static Order? _$currentOrder(DriverOrderState v) => v.currentOrder;
  static const Field<DriverOrderState, Order> _f$currentOrder = Field(
    'currentOrder',
    _$currentOrder,
    opt: true,
  );
  static User? _$customer(DriverOrderState v) => v.customer;
  static const Field<DriverOrderState, User> _f$customer = Field(
    'customer',
    _$customer,
    opt: true,
  );
  static OrderStatus? _$orderStatus(DriverOrderState v) => v.orderStatus;
  static const Field<DriverOrderState, OrderStatus> _f$orderStatus = Field(
    'orderStatus',
    _$orderStatus,
    opt: true,
  );

  @override
  final MappableFields<DriverOrderState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #currentOrder: _f$currentOrder,
    #customer: _f$customer,
    #orderStatus: _f$orderStatus,
  };

  static DriverOrderState _instantiate(DecodingData data) {
    return DriverOrderState(
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
      currentOrder: data.dec(_f$currentOrder),
      customer: data.dec(_f$customer),
      orderStatus: data.dec(_f$orderStatus),
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
  $R call({
    CubitState? state,
    String? message,
    BaseError? error,
    Order? currentOrder,
    User? customer,
    OrderStatus? orderStatus,
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
  $R call({
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
    Object? currentOrder = $none,
    Object? customer = $none,
    Object? orderStatus = $none,
  }) => $apply(
    FieldCopyWithData({
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
      if (currentOrder != $none) #currentOrder: currentOrder,
      if (customer != $none) #customer: customer,
      if (orderStatus != $none) #orderStatus: orderStatus,
    }),
  );
  @override
  DriverOrderState $make(CopyWithData data) => DriverOrderState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    currentOrder: data.get(#currentOrder, or: $value.currentOrder),
    customer: data.get(#customer, or: $value.customer),
    orderStatus: data.get(#orderStatus, or: $value.orderStatus),
  );

  @override
  DriverOrderStateCopyWith<$R2, DriverOrderState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DriverOrderStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

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

  static CubitState _$state(DriverProfileState v) => v.state;
  static const Field<DriverProfileState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(DriverProfileState v) => v.message;
  static const Field<DriverProfileState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(DriverProfileState v) => v.error;
  static const Field<DriverProfileState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static Driver? _$myDriver(DriverProfileState v) => v.myDriver;
  static const Field<DriverProfileState, Driver> _f$myDriver = Field(
    'myDriver',
    _$myDriver,
    opt: true,
  );

  @override
  final MappableFields<DriverProfileState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #myDriver: _f$myDriver,
  };

  static DriverProfileState _instantiate(DecodingData data) {
    return DriverProfileState(
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
      myDriver: data.dec(_f$myDriver),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DriverProfileStateMappable {
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
    CubitState? state,
    String? message,
    BaseError? error,
    Driver? myDriver,
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
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
    Object? myDriver = $none,
  }) => $apply(
    FieldCopyWithData({
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
      if (myDriver != $none) #myDriver: myDriver,
    }),
  );
  @override
  DriverProfileState $make(CopyWithData data) => DriverProfileState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    myDriver: data.get(#myDriver, or: $value.myDriver),
  );

  @override
  DriverProfileStateCopyWith<$R2, DriverProfileState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DriverProfileStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DriverQuizStateMapper extends ClassMapperBase<DriverQuizState> {
  DriverQuizStateMapper._();

  static DriverQuizStateMapper? _instance;
  static DriverQuizStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DriverQuizStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DriverQuizState';

  static CubitState _$state(DriverQuizState v) => v.state;
  static const Field<DriverQuizState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(DriverQuizState v) => v.message;
  static const Field<DriverQuizState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(DriverQuizState v) => v.error;
  static const Field<DriverQuizState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static QuizAttempt? _$attempt(DriverQuizState v) => v.attempt;
  static const Field<DriverQuizState, QuizAttempt> _f$attempt = Field(
    'attempt',
    _$attempt,
    opt: true,
  );
  static int? _$currentQuestionIndex(DriverQuizState v) =>
      v.currentQuestionIndex;
  static const Field<DriverQuizState, int> _f$currentQuestionIndex = Field(
    'currentQuestionIndex',
    _$currentQuestionIndex,
    opt: true,
  );
  static String? _$selectedAnswerId(DriverQuizState v) => v.selectedAnswerId;
  static const Field<DriverQuizState, String> _f$selectedAnswerId = Field(
    'selectedAnswerId',
    _$selectedAnswerId,
    opt: true,
  );
  static Set<String> _$answeredQuestions(DriverQuizState v) =>
      v.answeredQuestions;
  static const Field<DriverQuizState, Set<String>> _f$answeredQuestions = Field(
    'answeredQuestions',
    _$answeredQuestions,
    opt: true,
    def: const <String>{},
  );
  static QuizResult? _$result(DriverQuizState v) => v.result;
  static const Field<DriverQuizState, QuizResult> _f$result = Field(
    'result',
    _$result,
    opt: true,
  );
  static Map<String, dynamic>? _$answerFeedback(DriverQuizState v) =>
      v.answerFeedback;
  static const Field<DriverQuizState, Map<String, dynamic>> _f$answerFeedback =
      Field('answerFeedback', _$answerFeedback, opt: true);

  @override
  final MappableFields<DriverQuizState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #attempt: _f$attempt,
    #currentQuestionIndex: _f$currentQuestionIndex,
    #selectedAnswerId: _f$selectedAnswerId,
    #answeredQuestions: _f$answeredQuestions,
    #result: _f$result,
    #answerFeedback: _f$answerFeedback,
  };

  static DriverQuizState _instantiate(DecodingData data) {
    return DriverQuizState(
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
      attempt: data.dec(_f$attempt),
      currentQuestionIndex: data.dec(_f$currentQuestionIndex),
      selectedAnswerId: data.dec(_f$selectedAnswerId),
      answeredQuestions: data.dec(_f$answeredQuestions),
      result: data.dec(_f$result),
      answerFeedback: data.dec(_f$answerFeedback),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DriverQuizStateMappable {
  DriverQuizStateCopyWith<DriverQuizState, DriverQuizState, DriverQuizState>
  get copyWith =>
      _DriverQuizStateCopyWithImpl<DriverQuizState, DriverQuizState>(
        this as DriverQuizState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DriverQuizStateMapper.ensureInitialized().stringifyValue(
      this as DriverQuizState,
    );
  }

  @override
  bool operator ==(Object other) {
    return DriverQuizStateMapper.ensureInitialized().equalsValue(
      this as DriverQuizState,
      other,
    );
  }

  @override
  int get hashCode {
    return DriverQuizStateMapper.ensureInitialized().hashValue(
      this as DriverQuizState,
    );
  }
}

extension DriverQuizStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DriverQuizState, $Out> {
  DriverQuizStateCopyWith<$R, DriverQuizState, $Out> get $asDriverQuizState =>
      $base.as((v, t, t2) => _DriverQuizStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DriverQuizStateCopyWith<$R, $In extends DriverQuizState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
  get answerFeedback;
  $R call({
    CubitState? state,
    String? message,
    BaseError? error,
    QuizAttempt? attempt,
    int? currentQuestionIndex,
    String? selectedAnswerId,
    Set<String>? answeredQuestions,
    QuizResult? result,
    Map<String, dynamic>? answerFeedback,
  });
  DriverQuizStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DriverQuizStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DriverQuizState, $Out>
    implements DriverQuizStateCopyWith<$R, DriverQuizState, $Out> {
  _DriverQuizStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DriverQuizState> $mapper =
      DriverQuizStateMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
  get answerFeedback => $value.answerFeedback != null
      ? MapCopyWith(
          $value.answerFeedback!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(answerFeedback: v),
        )
      : null;
  @override
  $R call({
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
    Object? attempt = $none,
    Object? currentQuestionIndex = $none,
    Object? selectedAnswerId = $none,
    Set<String>? answeredQuestions,
    Object? result = $none,
    Object? answerFeedback = $none,
  }) => $apply(
    FieldCopyWithData({
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
      if (attempt != $none) #attempt: attempt,
      if (currentQuestionIndex != $none)
        #currentQuestionIndex: currentQuestionIndex,
      if (selectedAnswerId != $none) #selectedAnswerId: selectedAnswerId,
      if (answeredQuestions != null) #answeredQuestions: answeredQuestions,
      if (result != $none) #result: result,
      if (answerFeedback != $none) #answerFeedback: answerFeedback,
    }),
  );
  @override
  DriverQuizState $make(CopyWithData data) => DriverQuizState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    attempt: data.get(#attempt, or: $value.attempt),
    currentQuestionIndex: data.get(
      #currentQuestionIndex,
      or: $value.currentQuestionIndex,
    ),
    selectedAnswerId: data.get(#selectedAnswerId, or: $value.selectedAnswerId),
    answeredQuestions: data.get(
      #answeredQuestions,
      or: $value.answeredQuestions,
    ),
    result: data.get(#result, or: $value.result),
    answerFeedback: data.get(#answerFeedback, or: $value.answerFeedback),
  );

  @override
  DriverQuizStateCopyWith<$R2, DriverQuizState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DriverQuizStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DriverReviewStateMapper extends ClassMapperBase<DriverReviewState> {
  DriverReviewStateMapper._();

  static DriverReviewStateMapper? _instance;
  static DriverReviewStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DriverReviewStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DriverReviewState';

  static CubitState _$state(DriverReviewState v) => v.state;
  static const Field<DriverReviewState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(DriverReviewState v) => v.message;
  static const Field<DriverReviewState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(DriverReviewState v) => v.error;
  static const Field<DriverReviewState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static Review? _$submitted(DriverReviewState v) => v.submitted;
  static const Field<DriverReviewState, Review> _f$submitted = Field(
    'submitted',
    _$submitted,
    opt: true,
  );
  static List<Review> _$reviews(DriverReviewState v) => v.reviews;
  static const Field<DriverReviewState, List<Review>> _f$reviews = Field(
    'reviews',
    _$reviews,
    opt: true,
    def: const [],
  );
  static bool _$hasMore(DriverReviewState v) => v.hasMore;
  static const Field<DriverReviewState, bool> _f$hasMore = Field(
    'hasMore',
    _$hasMore,
    opt: true,
    def: true,
  );
  static String? _$cursor(DriverReviewState v) => v.cursor;
  static const Field<DriverReviewState, String> _f$cursor = Field(
    'cursor',
    _$cursor,
    opt: true,
  );

  @override
  final MappableFields<DriverReviewState> fields = const {
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
    #submitted: _f$submitted,
    #reviews: _f$reviews,
    #hasMore: _f$hasMore,
    #cursor: _f$cursor,
  };

  static DriverReviewState _instantiate(DecodingData data) {
    return DriverReviewState(
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
      submitted: data.dec(_f$submitted),
      reviews: data.dec(_f$reviews),
      hasMore: data.dec(_f$hasMore),
      cursor: data.dec(_f$cursor),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DriverReviewStateMappable {
  DriverReviewStateCopyWith<
    DriverReviewState,
    DriverReviewState,
    DriverReviewState
  >
  get copyWith =>
      _DriverReviewStateCopyWithImpl<DriverReviewState, DriverReviewState>(
        this as DriverReviewState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DriverReviewStateMapper.ensureInitialized().stringifyValue(
      this as DriverReviewState,
    );
  }

  @override
  bool operator ==(Object other) {
    return DriverReviewStateMapper.ensureInitialized().equalsValue(
      this as DriverReviewState,
      other,
    );
  }

  @override
  int get hashCode {
    return DriverReviewStateMapper.ensureInitialized().hashValue(
      this as DriverReviewState,
    );
  }
}

extension DriverReviewStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DriverReviewState, $Out> {
  DriverReviewStateCopyWith<$R, DriverReviewState, $Out>
  get $asDriverReviewState => $base.as(
    (v, t, t2) => _DriverReviewStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DriverReviewStateCopyWith<
  $R,
  $In extends DriverReviewState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Review, ObjectCopyWith<$R, Review, Review>> get reviews;
  $R call({
    CubitState? state,
    String? message,
    BaseError? error,
    Review? submitted,
    List<Review>? reviews,
    bool? hasMore,
    String? cursor,
  });
  DriverReviewStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DriverReviewStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DriverReviewState, $Out>
    implements DriverReviewStateCopyWith<$R, DriverReviewState, $Out> {
  _DriverReviewStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DriverReviewState> $mapper =
      DriverReviewStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Review, ObjectCopyWith<$R, Review, Review>> get reviews =>
      ListCopyWith(
        $value.reviews,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(reviews: v),
      );
  @override
  $R call({
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
    Object? submitted = $none,
    List<Review>? reviews,
    bool? hasMore,
    Object? cursor = $none,
  }) => $apply(
    FieldCopyWithData({
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
      if (submitted != $none) #submitted: submitted,
      if (reviews != null) #reviews: reviews,
      if (hasMore != null) #hasMore: hasMore,
      if (cursor != $none) #cursor: cursor,
    }),
  );
  @override
  DriverReviewState $make(CopyWithData data) => DriverReviewState(
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
    submitted: data.get(#submitted, or: $value.submitted),
    reviews: data.get(#reviews, or: $value.reviews),
    hasMore: data.get(#hasMore, or: $value.hasMore),
    cursor: data.get(#cursor, or: $value.cursor),
  );

  @override
  DriverReviewStateCopyWith<$R2, DriverReviewState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DriverReviewStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
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

