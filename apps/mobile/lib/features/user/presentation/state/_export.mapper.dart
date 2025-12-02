// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_export.dart';

class UserHomeStateMapper extends ClassMapperBase<UserHomeState> {
  UserHomeStateMapper._();

  static UserHomeStateMapper? _instance;
  static UserHomeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserHomeStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserHomeState';

  static List<Merchant> _$popularMerchants(UserHomeState v) =>
      v.popularMerchants;
  static const Field<UserHomeState, List<Merchant>> _f$popularMerchants = Field(
    'popularMerchants',
    _$popularMerchants,
    opt: true,
    def: const [],
  );
  static CubitState _$state(UserHomeState v) => v.state;
  static const Field<UserHomeState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(UserHomeState v) => v.message;
  static const Field<UserHomeState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(UserHomeState v) => v.error;
  static const Field<UserHomeState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<UserHomeState> fields = const {
    #popularMerchants: _f$popularMerchants,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static UserHomeState _instantiate(DecodingData data) {
    return UserHomeState(
      popularMerchants: data.dec(_f$popularMerchants),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin UserHomeStateMappable {
  UserHomeStateCopyWith<UserHomeState, UserHomeState, UserHomeState>
  get copyWith => _UserHomeStateCopyWithImpl<UserHomeState, UserHomeState>(
    this as UserHomeState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return UserHomeStateMapper.ensureInitialized().stringifyValue(
      this as UserHomeState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserHomeStateMapper.ensureInitialized().equalsValue(
      this as UserHomeState,
      other,
    );
  }

  @override
  int get hashCode {
    return UserHomeStateMapper.ensureInitialized().hashValue(
      this as UserHomeState,
    );
  }
}

extension UserHomeStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserHomeState, $Out> {
  UserHomeStateCopyWith<$R, UserHomeState, $Out> get $asUserHomeState =>
      $base.as((v, t, t2) => _UserHomeStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserHomeStateCopyWith<$R, $In extends UserHomeState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Merchant, ObjectCopyWith<$R, Merchant, Merchant>>
  get popularMerchants;
  $R call({
    List<Merchant>? popularMerchants,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  UserHomeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserHomeStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserHomeState, $Out>
    implements UserHomeStateCopyWith<$R, UserHomeState, $Out> {
  _UserHomeStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserHomeState> $mapper =
      UserHomeStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Merchant, ObjectCopyWith<$R, Merchant, Merchant>>
  get popularMerchants => ListCopyWith(
    $value.popularMerchants,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(popularMerchants: v),
  );
  @override
  $R call({
    List<Merchant>? popularMerchants,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (popularMerchants != null) #popularMerchants: popularMerchants,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  UserHomeState $make(CopyWithData data) => UserHomeState(
    popularMerchants: data.get(#popularMerchants, or: $value.popularMerchants),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  UserHomeStateCopyWith<$R2, UserHomeState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserHomeStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserRideStateMapper extends ClassMapperBase<UserRideState> {
  UserRideStateMapper._();

  static UserRideStateMapper? _instance;
  static UserRideStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserRideStateMapper._());
      PageTokenPaginationResultMapper.ensureInitialized();
      PlaceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserRideState';

  static List<Driver> _$nearbyDrivers(UserRideState v) => v.nearbyDrivers;
  static const Field<UserRideState, List<Driver>> _f$nearbyDrivers = Field(
    'nearbyDrivers',
    _$nearbyDrivers,
    opt: true,
    def: const [],
  );
  static PageTokenPaginationResult<List<Place>> _$nearbyPlaces(
    UserRideState v,
  ) => v.nearbyPlaces;
  static const Field<UserRideState, PageTokenPaginationResult<List<Place>>>
  _f$nearbyPlaces = Field(
    'nearbyPlaces',
    _$nearbyPlaces,
    opt: true,
    def: const PageTokenPaginationResult<List<Place>>(data: []),
  );
  static PageTokenPaginationResult<List<Place>> _$searchPlaces(
    UserRideState v,
  ) => v.searchPlaces;
  static const Field<UserRideState, PageTokenPaginationResult<List<Place>>>
  _f$searchPlaces = Field(
    'searchPlaces',
    _$searchPlaces,
    opt: true,
    def: const PageTokenPaginationResult<List<Place>>(data: []),
  );
  static GoogleMapController? _$mapController(UserRideState v) =>
      v.mapController;
  static const Field<UserRideState, GoogleMapController> _f$mapController =
      Field('mapController', _$mapController, opt: true);
  static CubitState _$state(UserRideState v) => v.state;
  static const Field<UserRideState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(UserRideState v) => v.message;
  static const Field<UserRideState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(UserRideState v) => v.error;
  static const Field<UserRideState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<UserRideState> fields = const {
    #nearbyDrivers: _f$nearbyDrivers,
    #nearbyPlaces: _f$nearbyPlaces,
    #searchPlaces: _f$searchPlaces,
    #mapController: _f$mapController,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static UserRideState _instantiate(DecodingData data) {
    return UserRideState(
      nearbyDrivers: data.dec(_f$nearbyDrivers),
      nearbyPlaces: data.dec(_f$nearbyPlaces),
      searchPlaces: data.dec(_f$searchPlaces),
      mapController: data.dec(_f$mapController),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin UserRideStateMappable {
  UserRideStateCopyWith<UserRideState, UserRideState, UserRideState>
  get copyWith => _UserRideStateCopyWithImpl<UserRideState, UserRideState>(
    this as UserRideState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return UserRideStateMapper.ensureInitialized().stringifyValue(
      this as UserRideState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserRideStateMapper.ensureInitialized().equalsValue(
      this as UserRideState,
      other,
    );
  }

  @override
  int get hashCode {
    return UserRideStateMapper.ensureInitialized().hashValue(
      this as UserRideState,
    );
  }
}

extension UserRideStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserRideState, $Out> {
  UserRideStateCopyWith<$R, UserRideState, $Out> get $asUserRideState =>
      $base.as((v, t, t2) => _UserRideStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserRideStateCopyWith<$R, $In extends UserRideState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Driver, ObjectCopyWith<$R, Driver, Driver>>
  get nearbyDrivers;
  PageTokenPaginationResultCopyWith<
    $R,
    PageTokenPaginationResult<List<Place>>,
    PageTokenPaginationResult<List<Place>>,
    List<Place>
  >
  get nearbyPlaces;
  PageTokenPaginationResultCopyWith<
    $R,
    PageTokenPaginationResult<List<Place>>,
    PageTokenPaginationResult<List<Place>>,
    List<Place>
  >
  get searchPlaces;
  $R call({
    List<Driver>? nearbyDrivers,
    PageTokenPaginationResult<List<Place>>? nearbyPlaces,
    PageTokenPaginationResult<List<Place>>? searchPlaces,
    GoogleMapController? mapController,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  UserRideStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserRideStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserRideState, $Out>
    implements UserRideStateCopyWith<$R, UserRideState, $Out> {
  _UserRideStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserRideState> $mapper =
      UserRideStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Driver, ObjectCopyWith<$R, Driver, Driver>>
  get nearbyDrivers => ListCopyWith(
    $value.nearbyDrivers,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(nearbyDrivers: v),
  );
  @override
  PageTokenPaginationResultCopyWith<
    $R,
    PageTokenPaginationResult<List<Place>>,
    PageTokenPaginationResult<List<Place>>,
    List<Place>
  >
  get nearbyPlaces =>
      $value.nearbyPlaces.copyWith.$chain((v) => call(nearbyPlaces: v));
  @override
  PageTokenPaginationResultCopyWith<
    $R,
    PageTokenPaginationResult<List<Place>>,
    PageTokenPaginationResult<List<Place>>,
    List<Place>
  >
  get searchPlaces =>
      $value.searchPlaces.copyWith.$chain((v) => call(searchPlaces: v));
  @override
  $R call({
    List<Driver>? nearbyDrivers,
    PageTokenPaginationResult<List<Place>>? nearbyPlaces,
    PageTokenPaginationResult<List<Place>>? searchPlaces,
    Object? mapController = $none,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (nearbyDrivers != null) #nearbyDrivers: nearbyDrivers,
      if (nearbyPlaces != null) #nearbyPlaces: nearbyPlaces,
      if (searchPlaces != null) #searchPlaces: searchPlaces,
      if (mapController != $none) #mapController: mapController,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  UserRideState $make(CopyWithData data) => UserRideState(
    nearbyDrivers: data.get(#nearbyDrivers, or: $value.nearbyDrivers),
    nearbyPlaces: data.get(#nearbyPlaces, or: $value.nearbyPlaces),
    searchPlaces: data.get(#searchPlaces, or: $value.searchPlaces),
    mapController: data.get(#mapController, or: $value.mapController),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  UserRideStateCopyWith<$R2, UserRideState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserRideStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserProfileStateMapper extends ClassMapperBase<UserProfileState> {
  UserProfileStateMapper._();

  static UserProfileStateMapper? _instance;
  static UserProfileStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserProfileStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserProfileState';

  static User? _$updateProfileResult(UserProfileState v) =>
      v.updateProfileResult;
  static const Field<UserProfileState, User> _f$updateProfileResult = Field(
    'updateProfileResult',
    _$updateProfileResult,
    opt: true,
  );
  static bool? _$updatePasswordResult(UserProfileState v) =>
      v.updatePasswordResult;
  static const Field<UserProfileState, bool> _f$updatePasswordResult = Field(
    'updatePasswordResult',
    _$updatePasswordResult,
    opt: true,
  );
  static CubitState _$state(UserProfileState v) => v.state;
  static const Field<UserProfileState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(UserProfileState v) => v.message;
  static const Field<UserProfileState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(UserProfileState v) => v.error;
  static const Field<UserProfileState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<UserProfileState> fields = const {
    #updateProfileResult: _f$updateProfileResult,
    #updatePasswordResult: _f$updatePasswordResult,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static UserProfileState _instantiate(DecodingData data) {
    return UserProfileState(
      updateProfileResult: data.dec(_f$updateProfileResult),
      updatePasswordResult: data.dec(_f$updatePasswordResult),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin UserProfileStateMappable {
  UserProfileStateCopyWith<UserProfileState, UserProfileState, UserProfileState>
  get copyWith =>
      _UserProfileStateCopyWithImpl<UserProfileState, UserProfileState>(
        this as UserProfileState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserProfileStateMapper.ensureInitialized().stringifyValue(
      this as UserProfileState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserProfileStateMapper.ensureInitialized().equalsValue(
      this as UserProfileState,
      other,
    );
  }

  @override
  int get hashCode {
    return UserProfileStateMapper.ensureInitialized().hashValue(
      this as UserProfileState,
    );
  }
}

extension UserProfileStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserProfileState, $Out> {
  UserProfileStateCopyWith<$R, UserProfileState, $Out>
  get $asUserProfileState =>
      $base.as((v, t, t2) => _UserProfileStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserProfileStateCopyWith<$R, $In extends UserProfileState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    User? updateProfileResult,
    bool? updatePasswordResult,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  UserProfileStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserProfileStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserProfileState, $Out>
    implements UserProfileStateCopyWith<$R, UserProfileState, $Out> {
  _UserProfileStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserProfileState> $mapper =
      UserProfileStateMapper.ensureInitialized();
  @override
  $R call({
    Object? updateProfileResult = $none,
    Object? updatePasswordResult = $none,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (updateProfileResult != $none)
        #updateProfileResult: updateProfileResult,
      if (updatePasswordResult != $none)
        #updatePasswordResult: updatePasswordResult,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  UserProfileState $make(CopyWithData data) => UserProfileState(
    updateProfileResult: data.get(
      #updateProfileResult,
      or: $value.updateProfileResult,
    ),
    updatePasswordResult: data.get(
      #updatePasswordResult,
      or: $value.updatePasswordResult,
    ),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  UserProfileStateCopyWith<$R2, UserProfileState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserProfileStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserLocationStateMapper extends ClassMapperBase<UserLocationState> {
  UserLocationStateMapper._();

  static UserLocationStateMapper? _instance;
  static UserLocationStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserLocationStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserLocationState';

  static Coordinate? _$coordinate(UserLocationState v) => v.coordinate;
  static const Field<UserLocationState, Coordinate> _f$coordinate = Field(
    'coordinate',
    _$coordinate,
    opt: true,
  );
  static Placemark? _$placemark(UserLocationState v) => v.placemark;
  static const Field<UserLocationState, Placemark> _f$placemark = Field(
    'placemark',
    _$placemark,
    opt: true,
  );
  static CubitState _$state(UserLocationState v) => v.state;
  static const Field<UserLocationState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(UserLocationState v) => v.message;
  static const Field<UserLocationState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(UserLocationState v) => v.error;
  static const Field<UserLocationState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<UserLocationState> fields = const {
    #coordinate: _f$coordinate,
    #placemark: _f$placemark,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static UserLocationState _instantiate(DecodingData data) {
    return UserLocationState(
      coordinate: data.dec(_f$coordinate),
      placemark: data.dec(_f$placemark),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin UserLocationStateMappable {
  UserLocationStateCopyWith<
    UserLocationState,
    UserLocationState,
    UserLocationState
  >
  get copyWith =>
      _UserLocationStateCopyWithImpl<UserLocationState, UserLocationState>(
        this as UserLocationState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserLocationStateMapper.ensureInitialized().stringifyValue(
      this as UserLocationState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserLocationStateMapper.ensureInitialized().equalsValue(
      this as UserLocationState,
      other,
    );
  }

  @override
  int get hashCode {
    return UserLocationStateMapper.ensureInitialized().hashValue(
      this as UserLocationState,
    );
  }
}

extension UserLocationStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserLocationState, $Out> {
  UserLocationStateCopyWith<$R, UserLocationState, $Out>
  get $asUserLocationState => $base.as(
    (v, t, t2) => _UserLocationStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class UserLocationStateCopyWith<
  $R,
  $In extends UserLocationState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Coordinate? coordinate,
    Placemark? placemark,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  UserLocationStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserLocationStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserLocationState, $Out>
    implements UserLocationStateCopyWith<$R, UserLocationState, $Out> {
  _UserLocationStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserLocationState> $mapper =
      UserLocationStateMapper.ensureInitialized();
  @override
  $R call({
    Object? coordinate = $none,
    Object? placemark = $none,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (coordinate != $none) #coordinate: coordinate,
      if (placemark != $none) #placemark: placemark,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  UserLocationState $make(CopyWithData data) => UserLocationState(
    coordinate: data.get(#coordinate, or: $value.coordinate),
    placemark: data.get(#placemark, or: $value.placemark),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  UserLocationStateCopyWith<$R2, UserLocationState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserLocationStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserDeliveryStateMapper extends ClassMapperBase<UserDeliveryState> {
  UserDeliveryStateMapper._();

  static UserDeliveryStateMapper? _instance;
  static UserDeliveryStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserDeliveryStateMapper._());
      PlaceMapper.ensureInitialized();
      PageTokenPaginationResultMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserDeliveryState';

  static List<Driver> _$nearbyDrivers(UserDeliveryState v) => v.nearbyDrivers;
  static const Field<UserDeliveryState, List<Driver>> _f$nearbyDrivers = Field(
    'nearbyDrivers',
    _$nearbyDrivers,
    opt: true,
    def: const [],
  );
  static Place? _$pickup(UserDeliveryState v) => v.pickup;
  static const Field<UserDeliveryState, Place> _f$pickup = Field(
    'pickup',
    _$pickup,
    opt: true,
  );
  static Place? _$dropoff(UserDeliveryState v) => v.dropoff;
  static const Field<UserDeliveryState, Place> _f$dropoff = Field(
    'dropoff',
    _$dropoff,
    opt: true,
  );
  static DeliveryDetails? _$details(UserDeliveryState v) => v.details;
  static const Field<UserDeliveryState, DeliveryDetails> _f$details = Field(
    'details',
    _$details,
    opt: true,
  );
  static DeliveryEstimateResult? _$estimate(UserDeliveryState v) => v.estimate;
  static const Field<UserDeliveryState, DeliveryEstimateResult> _f$estimate =
      Field('estimate', _$estimate, opt: true);
  static PageTokenPaginationResult<List<Place>> _$nearbyPlaces(
    UserDeliveryState v,
  ) => v.nearbyPlaces;
  static const Field<UserDeliveryState, PageTokenPaginationResult<List<Place>>>
  _f$nearbyPlaces = Field(
    'nearbyPlaces',
    _$nearbyPlaces,
    opt: true,
    def: const PageTokenPaginationResult<List<Place>>(data: []),
  );
  static PageTokenPaginationResult<List<Place>> _$searchPlaces(
    UserDeliveryState v,
  ) => v.searchPlaces;
  static const Field<UserDeliveryState, PageTokenPaginationResult<List<Place>>>
  _f$searchPlaces = Field(
    'searchPlaces',
    _$searchPlaces,
    opt: true,
    def: const PageTokenPaginationResult<List<Place>>(data: []),
  );
  static CubitState _$state(UserDeliveryState v) => v.state;
  static const Field<UserDeliveryState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(UserDeliveryState v) => v.message;
  static const Field<UserDeliveryState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(UserDeliveryState v) => v.error;
  static const Field<UserDeliveryState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<UserDeliveryState> fields = const {
    #nearbyDrivers: _f$nearbyDrivers,
    #pickup: _f$pickup,
    #dropoff: _f$dropoff,
    #details: _f$details,
    #estimate: _f$estimate,
    #nearbyPlaces: _f$nearbyPlaces,
    #searchPlaces: _f$searchPlaces,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static UserDeliveryState _instantiate(DecodingData data) {
    return UserDeliveryState(
      nearbyDrivers: data.dec(_f$nearbyDrivers),
      pickup: data.dec(_f$pickup),
      dropoff: data.dec(_f$dropoff),
      details: data.dec(_f$details),
      estimate: data.dec(_f$estimate),
      nearbyPlaces: data.dec(_f$nearbyPlaces),
      searchPlaces: data.dec(_f$searchPlaces),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin UserDeliveryStateMappable {
  UserDeliveryStateCopyWith<
    UserDeliveryState,
    UserDeliveryState,
    UserDeliveryState
  >
  get copyWith =>
      _UserDeliveryStateCopyWithImpl<UserDeliveryState, UserDeliveryState>(
        this as UserDeliveryState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserDeliveryStateMapper.ensureInitialized().stringifyValue(
      this as UserDeliveryState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserDeliveryStateMapper.ensureInitialized().equalsValue(
      this as UserDeliveryState,
      other,
    );
  }

  @override
  int get hashCode {
    return UserDeliveryStateMapper.ensureInitialized().hashValue(
      this as UserDeliveryState,
    );
  }
}

extension UserDeliveryStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserDeliveryState, $Out> {
  UserDeliveryStateCopyWith<$R, UserDeliveryState, $Out>
  get $asUserDeliveryState => $base.as(
    (v, t, t2) => _UserDeliveryStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class UserDeliveryStateCopyWith<
  $R,
  $In extends UserDeliveryState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Driver, ObjectCopyWith<$R, Driver, Driver>>
  get nearbyDrivers;
  PlaceCopyWith<$R, Place, Place>? get pickup;
  PlaceCopyWith<$R, Place, Place>? get dropoff;
  PageTokenPaginationResultCopyWith<
    $R,
    PageTokenPaginationResult<List<Place>>,
    PageTokenPaginationResult<List<Place>>,
    List<Place>
  >
  get nearbyPlaces;
  PageTokenPaginationResultCopyWith<
    $R,
    PageTokenPaginationResult<List<Place>>,
    PageTokenPaginationResult<List<Place>>,
    List<Place>
  >
  get searchPlaces;
  $R call({
    List<Driver>? nearbyDrivers,
    Place? pickup,
    Place? dropoff,
    DeliveryDetails? details,
    DeliveryEstimateResult? estimate,
    PageTokenPaginationResult<List<Place>>? nearbyPlaces,
    PageTokenPaginationResult<List<Place>>? searchPlaces,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  UserDeliveryStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserDeliveryStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserDeliveryState, $Out>
    implements UserDeliveryStateCopyWith<$R, UserDeliveryState, $Out> {
  _UserDeliveryStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserDeliveryState> $mapper =
      UserDeliveryStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Driver, ObjectCopyWith<$R, Driver, Driver>>
  get nearbyDrivers => ListCopyWith(
    $value.nearbyDrivers,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(nearbyDrivers: v),
  );
  @override
  PlaceCopyWith<$R, Place, Place>? get pickup =>
      $value.pickup?.copyWith.$chain((v) => call(pickup: v));
  @override
  PlaceCopyWith<$R, Place, Place>? get dropoff =>
      $value.dropoff?.copyWith.$chain((v) => call(dropoff: v));
  @override
  PageTokenPaginationResultCopyWith<
    $R,
    PageTokenPaginationResult<List<Place>>,
    PageTokenPaginationResult<List<Place>>,
    List<Place>
  >
  get nearbyPlaces =>
      $value.nearbyPlaces.copyWith.$chain((v) => call(nearbyPlaces: v));
  @override
  PageTokenPaginationResultCopyWith<
    $R,
    PageTokenPaginationResult<List<Place>>,
    PageTokenPaginationResult<List<Place>>,
    List<Place>
  >
  get searchPlaces =>
      $value.searchPlaces.copyWith.$chain((v) => call(searchPlaces: v));
  @override
  $R call({
    List<Driver>? nearbyDrivers,
    Object? pickup = $none,
    Object? dropoff = $none,
    Object? details = $none,
    Object? estimate = $none,
    PageTokenPaginationResult<List<Place>>? nearbyPlaces,
    PageTokenPaginationResult<List<Place>>? searchPlaces,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (nearbyDrivers != null) #nearbyDrivers: nearbyDrivers,
      if (pickup != $none) #pickup: pickup,
      if (dropoff != $none) #dropoff: dropoff,
      if (details != $none) #details: details,
      if (estimate != $none) #estimate: estimate,
      if (nearbyPlaces != null) #nearbyPlaces: nearbyPlaces,
      if (searchPlaces != null) #searchPlaces: searchPlaces,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  UserDeliveryState $make(CopyWithData data) => UserDeliveryState(
    nearbyDrivers: data.get(#nearbyDrivers, or: $value.nearbyDrivers),
    pickup: data.get(#pickup, or: $value.pickup),
    dropoff: data.get(#dropoff, or: $value.dropoff),
    details: data.get(#details, or: $value.details),
    estimate: data.get(#estimate, or: $value.estimate),
    nearbyPlaces: data.get(#nearbyPlaces, or: $value.nearbyPlaces),
    searchPlaces: data.get(#searchPlaces, or: $value.searchPlaces),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  UserDeliveryStateCopyWith<$R2, UserDeliveryState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserDeliveryStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BestSellerItemMapper extends ClassMapperBase<BestSellerItem> {
  BestSellerItemMapper._();

  static BestSellerItemMapper? _instance;
  static BestSellerItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BestSellerItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BestSellerItem';

  static MerchantMenu _$menu(BestSellerItem v) => v.menu;
  static const Field<BestSellerItem, MerchantMenu> _f$menu = Field(
    'menu',
    _$menu,
  );
  static String _$merchantName(BestSellerItem v) => v.merchantName;
  static const Field<BestSellerItem, String> _f$merchantName = Field(
    'merchantName',
    _$merchantName,
  );

  @override
  final MappableFields<BestSellerItem> fields = const {
    #menu: _f$menu,
    #merchantName: _f$merchantName,
  };

  static BestSellerItem _instantiate(DecodingData data) {
    return BestSellerItem(
      menu: data.dec(_f$menu),
      merchantName: data.dec(_f$merchantName),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin BestSellerItemMappable {
  BestSellerItemCopyWith<BestSellerItem, BestSellerItem, BestSellerItem>
  get copyWith => _BestSellerItemCopyWithImpl<BestSellerItem, BestSellerItem>(
    this as BestSellerItem,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return BestSellerItemMapper.ensureInitialized().stringifyValue(
      this as BestSellerItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return BestSellerItemMapper.ensureInitialized().equalsValue(
      this as BestSellerItem,
      other,
    );
  }

  @override
  int get hashCode {
    return BestSellerItemMapper.ensureInitialized().hashValue(
      this as BestSellerItem,
    );
  }
}

extension BestSellerItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BestSellerItem, $Out> {
  BestSellerItemCopyWith<$R, BestSellerItem, $Out> get $asBestSellerItem =>
      $base.as((v, t, t2) => _BestSellerItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BestSellerItemCopyWith<$R, $In extends BestSellerItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({MerchantMenu? menu, String? merchantName});
  BestSellerItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BestSellerItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BestSellerItem, $Out>
    implements BestSellerItemCopyWith<$R, BestSellerItem, $Out> {
  _BestSellerItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BestSellerItem> $mapper =
      BestSellerItemMapper.ensureInitialized();
  @override
  $R call({MerchantMenu? menu, String? merchantName}) => $apply(
    FieldCopyWithData({
      if (menu != null) #menu: menu,
      if (merchantName != null) #merchantName: merchantName,
    }),
  );
  @override
  BestSellerItem $make(CopyWithData data) => BestSellerItem(
    menu: data.get(#menu, or: $value.menu),
    merchantName: data.get(#merchantName, or: $value.merchantName),
  );

  @override
  BestSellerItemCopyWith<$R2, BestSellerItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BestSellerItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserMartStateMapper extends ClassMapperBase<UserMartState> {
  UserMartStateMapper._();

  static UserMartStateMapper? _instance;
  static UserMartStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserMartStateMapper._());
      BestSellerItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserMartState';

  static List<String> _$categories(UserMartState v) => v.categories;
  static const Field<UserMartState, List<String>> _f$categories = Field(
    'categories',
    _$categories,
    opt: true,
    def: const ['ATK', 'Printing', 'Food'],
  );
  static List<BestSellerItem> _$bestSellers(UserMartState v) => v.bestSellers;
  static const Field<UserMartState, List<BestSellerItem>> _f$bestSellers =
      Field('bestSellers', _$bestSellers, opt: true, def: const []);
  static List<Order> _$recentOrders(UserMartState v) => v.recentOrders;
  static const Field<UserMartState, List<Order>> _f$recentOrders = Field(
    'recentOrders',
    _$recentOrders,
    opt: true,
    def: const [],
  );
  static List<Merchant> _$categoryMerchants(UserMartState v) =>
      v.categoryMerchants;
  static const Field<UserMartState, List<Merchant>> _f$categoryMerchants =
      Field('categoryMerchants', _$categoryMerchants, opt: true, def: const []);
  static String? _$selectedCategory(UserMartState v) => v.selectedCategory;
  static const Field<UserMartState, String> _f$selectedCategory = Field(
    'selectedCategory',
    _$selectedCategory,
    opt: true,
  );
  static CubitState _$state(UserMartState v) => v.state;
  static const Field<UserMartState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(UserMartState v) => v.message;
  static const Field<UserMartState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(UserMartState v) => v.error;
  static const Field<UserMartState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<UserMartState> fields = const {
    #categories: _f$categories,
    #bestSellers: _f$bestSellers,
    #recentOrders: _f$recentOrders,
    #categoryMerchants: _f$categoryMerchants,
    #selectedCategory: _f$selectedCategory,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static UserMartState _instantiate(DecodingData data) {
    return UserMartState(
      categories: data.dec(_f$categories),
      bestSellers: data.dec(_f$bestSellers),
      recentOrders: data.dec(_f$recentOrders),
      categoryMerchants: data.dec(_f$categoryMerchants),
      selectedCategory: data.dec(_f$selectedCategory),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin UserMartStateMappable {
  UserMartStateCopyWith<UserMartState, UserMartState, UserMartState>
  get copyWith => _UserMartStateCopyWithImpl<UserMartState, UserMartState>(
    this as UserMartState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return UserMartStateMapper.ensureInitialized().stringifyValue(
      this as UserMartState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserMartStateMapper.ensureInitialized().equalsValue(
      this as UserMartState,
      other,
    );
  }

  @override
  int get hashCode {
    return UserMartStateMapper.ensureInitialized().hashValue(
      this as UserMartState,
    );
  }
}

extension UserMartStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserMartState, $Out> {
  UserMartStateCopyWith<$R, UserMartState, $Out> get $asUserMartState =>
      $base.as((v, t, t2) => _UserMartStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserMartStateCopyWith<$R, $In extends UserMartState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get categories;
  ListCopyWith<
    $R,
    BestSellerItem,
    BestSellerItemCopyWith<$R, BestSellerItem, BestSellerItem>
  >
  get bestSellers;
  ListCopyWith<$R, Order, ObjectCopyWith<$R, Order, Order>> get recentOrders;
  ListCopyWith<$R, Merchant, ObjectCopyWith<$R, Merchant, Merchant>>
  get categoryMerchants;
  $R call({
    List<String>? categories,
    List<BestSellerItem>? bestSellers,
    List<Order>? recentOrders,
    List<Merchant>? categoryMerchants,
    String? selectedCategory,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  UserMartStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserMartStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserMartState, $Out>
    implements UserMartStateCopyWith<$R, UserMartState, $Out> {
  _UserMartStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserMartState> $mapper =
      UserMartStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get categories =>
      ListCopyWith(
        $value.categories,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(categories: v),
      );
  @override
  ListCopyWith<
    $R,
    BestSellerItem,
    BestSellerItemCopyWith<$R, BestSellerItem, BestSellerItem>
  >
  get bestSellers => ListCopyWith(
    $value.bestSellers,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(bestSellers: v),
  );
  @override
  ListCopyWith<$R, Order, ObjectCopyWith<$R, Order, Order>> get recentOrders =>
      ListCopyWith(
        $value.recentOrders,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(recentOrders: v),
      );
  @override
  ListCopyWith<$R, Merchant, ObjectCopyWith<$R, Merchant, Merchant>>
  get categoryMerchants => ListCopyWith(
    $value.categoryMerchants,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(categoryMerchants: v),
  );
  @override
  $R call({
    List<String>? categories,
    List<BestSellerItem>? bestSellers,
    List<Order>? recentOrders,
    List<Merchant>? categoryMerchants,
    Object? selectedCategory = $none,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (categories != null) #categories: categories,
      if (bestSellers != null) #bestSellers: bestSellers,
      if (recentOrders != null) #recentOrders: recentOrders,
      if (categoryMerchants != null) #categoryMerchants: categoryMerchants,
      if (selectedCategory != $none) #selectedCategory: selectedCategory,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  UserMartState $make(CopyWithData data) => UserMartState(
    categories: data.get(#categories, or: $value.categories),
    bestSellers: data.get(#bestSellers, or: $value.bestSellers),
    recentOrders: data.get(#recentOrders, or: $value.recentOrders),
    categoryMerchants: data.get(
      #categoryMerchants,
      or: $value.categoryMerchants,
    ),
    selectedCategory: data.get(#selectedCategory, or: $value.selectedCategory),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  UserMartStateCopyWith<$R2, UserMartState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserMartStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

