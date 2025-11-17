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
  static Coordinate? _$coordinate(UserRideState v) => v.coordinate;
  static const Field<UserRideState, Coordinate> _f$coordinate = Field(
    'coordinate',
    _$coordinate,
    opt: true,
  );
  static Placemark? _$placemark(UserRideState v) => v.placemark;
  static const Field<UserRideState, Placemark> _f$placemark = Field(
    'placemark',
    _$placemark,
    opt: true,
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
    #coordinate: _f$coordinate,
    #placemark: _f$placemark,
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
      coordinate: data.dec(_f$coordinate),
      placemark: data.dec(_f$placemark),
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
    Coordinate? coordinate,
    Placemark? placemark,
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
    Object? coordinate = $none,
    Object? placemark = $none,
    Object? mapController = $none,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (nearbyDrivers != null) #nearbyDrivers: nearbyDrivers,
      if (nearbyPlaces != null) #nearbyPlaces: nearbyPlaces,
      if (searchPlaces != null) #searchPlaces: searchPlaces,
      if (coordinate != $none) #coordinate: coordinate,
      if (placemark != $none) #placemark: placemark,
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
    coordinate: data.get(#coordinate, or: $value.coordinate),
    placemark: data.get(#placemark, or: $value.placemark),
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

