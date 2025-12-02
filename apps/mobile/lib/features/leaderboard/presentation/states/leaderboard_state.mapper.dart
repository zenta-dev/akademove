// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'leaderboard_state.dart';

class LeaderboardStateMapper extends ClassMapperBase<LeaderboardState> {
  LeaderboardStateMapper._();

  static LeaderboardStateMapper? _instance;
  static LeaderboardStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LeaderboardStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LeaderboardState';

  static List<Leaderboard> _$leaderboards(LeaderboardState v) => v.leaderboards;
  static const Field<LeaderboardState, List<Leaderboard>> _f$leaderboards =
      Field('leaderboards', _$leaderboards, opt: true, def: const []);
  static List<Badge> _$badges(LeaderboardState v) => v.badges;
  static const Field<LeaderboardState, List<Badge>> _f$badges = Field(
    'badges',
    _$badges,
    opt: true,
    def: const [],
  );
  static List<UserBadge> _$userBadges(LeaderboardState v) => v.userBadges;
  static const Field<LeaderboardState, List<UserBadge>> _f$userBadges = Field(
    'userBadges',
    _$userBadges,
    opt: true,
    def: const [],
  );
  static List<Leaderboard> _$myRankings(LeaderboardState v) => v.myRankings;
  static const Field<LeaderboardState, List<Leaderboard>> _f$myRankings = Field(
    'myRankings',
    _$myRankings,
    opt: true,
    def: const [],
  );
  static CubitState _$state(LeaderboardState v) => v.state;
  static const Field<LeaderboardState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(LeaderboardState v) => v.message;
  static const Field<LeaderboardState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(LeaderboardState v) => v.error;
  static const Field<LeaderboardState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<LeaderboardState> fields = const {
    #leaderboards: _f$leaderboards,
    #badges: _f$badges,
    #userBadges: _f$userBadges,
    #myRankings: _f$myRankings,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static LeaderboardState _instantiate(DecodingData data) {
    return LeaderboardState(
      leaderboards: data.dec(_f$leaderboards),
      badges: data.dec(_f$badges),
      userBadges: data.dec(_f$userBadges),
      myRankings: data.dec(_f$myRankings),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin LeaderboardStateMappable {
  LeaderboardStateCopyWith<LeaderboardState, LeaderboardState, LeaderboardState>
  get copyWith =>
      _LeaderboardStateCopyWithImpl<LeaderboardState, LeaderboardState>(
        this as LeaderboardState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LeaderboardStateMapper.ensureInitialized().stringifyValue(
      this as LeaderboardState,
    );
  }

  @override
  bool operator ==(Object other) {
    return LeaderboardStateMapper.ensureInitialized().equalsValue(
      this as LeaderboardState,
      other,
    );
  }

  @override
  int get hashCode {
    return LeaderboardStateMapper.ensureInitialized().hashValue(
      this as LeaderboardState,
    );
  }
}

extension LeaderboardStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LeaderboardState, $Out> {
  LeaderboardStateCopyWith<$R, LeaderboardState, $Out>
  get $asLeaderboardState =>
      $base.as((v, t, t2) => _LeaderboardStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LeaderboardStateCopyWith<$R, $In extends LeaderboardState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Leaderboard, ObjectCopyWith<$R, Leaderboard, Leaderboard>>
  get leaderboards;
  ListCopyWith<$R, Badge, ObjectCopyWith<$R, Badge, Badge>> get badges;
  ListCopyWith<$R, UserBadge, ObjectCopyWith<$R, UserBadge, UserBadge>>
  get userBadges;
  ListCopyWith<$R, Leaderboard, ObjectCopyWith<$R, Leaderboard, Leaderboard>>
  get myRankings;
  $R call({
    List<Leaderboard>? leaderboards,
    List<Badge>? badges,
    List<UserBadge>? userBadges,
    List<Leaderboard>? myRankings,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  LeaderboardStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LeaderboardStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LeaderboardState, $Out>
    implements LeaderboardStateCopyWith<$R, LeaderboardState, $Out> {
  _LeaderboardStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LeaderboardState> $mapper =
      LeaderboardStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Leaderboard, ObjectCopyWith<$R, Leaderboard, Leaderboard>>
  get leaderboards => ListCopyWith(
    $value.leaderboards,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(leaderboards: v),
  );
  @override
  ListCopyWith<$R, Badge, ObjectCopyWith<$R, Badge, Badge>> get badges =>
      ListCopyWith(
        $value.badges,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(badges: v),
      );
  @override
  ListCopyWith<$R, UserBadge, ObjectCopyWith<$R, UserBadge, UserBadge>>
  get userBadges => ListCopyWith(
    $value.userBadges,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(userBadges: v),
  );
  @override
  ListCopyWith<$R, Leaderboard, ObjectCopyWith<$R, Leaderboard, Leaderboard>>
  get myRankings => ListCopyWith(
    $value.myRankings,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(myRankings: v),
  );
  @override
  $R call({
    List<Leaderboard>? leaderboards,
    List<Badge>? badges,
    List<UserBadge>? userBadges,
    List<Leaderboard>? myRankings,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (leaderboards != null) #leaderboards: leaderboards,
      if (badges != null) #badges: badges,
      if (userBadges != null) #userBadges: userBadges,
      if (myRankings != null) #myRankings: myRankings,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  LeaderboardState $make(CopyWithData data) => LeaderboardState(
    leaderboards: data.get(#leaderboards, or: $value.leaderboards),
    badges: data.get(#badges, or: $value.badges),
    userBadges: data.get(#userBadges, or: $value.userBadges),
    myRankings: data.get(#myRankings, or: $value.myRankings),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  LeaderboardStateCopyWith<$R2, LeaderboardState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LeaderboardStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

