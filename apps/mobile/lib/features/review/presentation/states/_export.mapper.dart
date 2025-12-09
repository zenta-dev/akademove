// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_export.dart';

class UserReviewStateMapper extends ClassMapperBase<UserReviewState> {
  UserReviewStateMapper._();

  static UserReviewStateMapper? _instance;
  static UserReviewStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserReviewStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserReviewState';

  static Review? _$submittedReview(UserReviewState v) => v.submittedReview;
  static const Field<UserReviewState, Review> _f$submittedReview = Field(
    'submittedReview',
    _$submittedReview,
    opt: true,
  );
  static List<Review> _$orderReviews(UserReviewState v) => v.orderReviews;
  static const Field<UserReviewState, List<Review>> _f$orderReviews = Field(
    'orderReviews',
    _$orderReviews,
    opt: true,
    def: const [],
  );
  static bool _$canReview(UserReviewState v) => v.canReview;
  static const Field<UserReviewState, bool> _f$canReview = Field(
    'canReview',
    _$canReview,
    opt: true,
    def: false,
  );
  static CubitState _$state(UserReviewState v) => v.state;
  static const Field<UserReviewState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(UserReviewState v) => v.message;
  static const Field<UserReviewState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(UserReviewState v) => v.error;
  static const Field<UserReviewState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<UserReviewState> fields = const {
    #submittedReview: _f$submittedReview,
    #orderReviews: _f$orderReviews,
    #canReview: _f$canReview,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static UserReviewState _instantiate(DecodingData data) {
    return UserReviewState(
      submittedReview: data.dec(_f$submittedReview),
      orderReviews: data.dec(_f$orderReviews),
      canReview: data.dec(_f$canReview),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin UserReviewStateMappable {
  UserReviewStateCopyWith<UserReviewState, UserReviewState, UserReviewState>
  get copyWith =>
      _UserReviewStateCopyWithImpl<UserReviewState, UserReviewState>(
        this as UserReviewState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserReviewStateMapper.ensureInitialized().stringifyValue(
      this as UserReviewState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserReviewStateMapper.ensureInitialized().equalsValue(
      this as UserReviewState,
      other,
    );
  }

  @override
  int get hashCode {
    return UserReviewStateMapper.ensureInitialized().hashValue(
      this as UserReviewState,
    );
  }
}

extension UserReviewStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserReviewState, $Out> {
  UserReviewStateCopyWith<$R, UserReviewState, $Out> get $asUserReviewState =>
      $base.as((v, t, t2) => _UserReviewStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserReviewStateCopyWith<$R, $In extends UserReviewState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Review, ObjectCopyWith<$R, Review, Review>> get orderReviews;
  $R call({
    Review? submittedReview,
    List<Review>? orderReviews,
    bool? canReview,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  UserReviewStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserReviewStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserReviewState, $Out>
    implements UserReviewStateCopyWith<$R, UserReviewState, $Out> {
  _UserReviewStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserReviewState> $mapper =
      UserReviewStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Review, ObjectCopyWith<$R, Review, Review>>
  get orderReviews => ListCopyWith(
    $value.orderReviews,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(orderReviews: v),
  );
  @override
  $R call({
    Object? submittedReview = $none,
    List<Review>? orderReviews,
    bool? canReview,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (submittedReview != $none) #submittedReview: submittedReview,
      if (orderReviews != null) #orderReviews: orderReviews,
      if (canReview != null) #canReview: canReview,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  UserReviewState $make(CopyWithData data) => UserReviewState(
    submittedReview: data.get(#submittedReview, or: $value.submittedReview),
    orderReviews: data.get(#orderReviews, or: $value.orderReviews),
    canReview: data.get(#canReview, or: $value.canReview),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  UserReviewStateCopyWith<$R2, UserReviewState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserReviewStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

