// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'review_state.dart';

class ReviewStateMapper extends ClassMapperBase<ReviewState> {
  ReviewStateMapper._();

  static ReviewStateMapper? _instance;
  static ReviewStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReviewStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ReviewState';

  static Review? _$submitted(ReviewState v) => v.submitted;
  static const Field<ReviewState, Review> _f$submitted = Field(
    'submitted',
    _$submitted,
    opt: true,
  );
  static List<Review> _$reviews(ReviewState v) => v.reviews;
  static const Field<ReviewState, List<Review>> _f$reviews = Field(
    'reviews',
    _$reviews,
    opt: true,
    def: const [],
  );
  static bool _$hasMore(ReviewState v) => v.hasMore;
  static const Field<ReviewState, bool> _f$hasMore = Field(
    'hasMore',
    _$hasMore,
    opt: true,
    def: true,
  );
  static String? _$cursor(ReviewState v) => v.cursor;
  static const Field<ReviewState, String> _f$cursor = Field(
    'cursor',
    _$cursor,
    opt: true,
  );
  static bool _$isLoading(ReviewState v) => v.isLoading;
  static const Field<ReviewState, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
    opt: true,
    def: false,
  );
  static BaseError? _$error(ReviewState v) => v.error;
  static const Field<ReviewState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static String? _$message(ReviewState v) => v.message;
  static const Field<ReviewState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );

  @override
  final MappableFields<ReviewState> fields = const {
    #submitted: _f$submitted,
    #reviews: _f$reviews,
    #hasMore: _f$hasMore,
    #cursor: _f$cursor,
    #isLoading: _f$isLoading,
    #error: _f$error,
    #message: _f$message,
  };

  static ReviewState _instantiate(DecodingData data) {
    return ReviewState(
      submitted: data.dec(_f$submitted),
      reviews: data.dec(_f$reviews),
      hasMore: data.dec(_f$hasMore),
      cursor: data.dec(_f$cursor),
      isLoading: data.dec(_f$isLoading),
      error: data.dec(_f$error),
      message: data.dec(_f$message),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ReviewState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReviewState>(map);
  }

  static ReviewState fromJson(String json) {
    return ensureInitialized().decodeJson<ReviewState>(json);
  }
}

mixin ReviewStateMappable {
  String toJson() {
    return ReviewStateMapper.ensureInitialized().encodeJson<ReviewState>(
      this as ReviewState,
    );
  }

  Map<String, dynamic> toMap() {
    return ReviewStateMapper.ensureInitialized().encodeMap<ReviewState>(
      this as ReviewState,
    );
  }

  ReviewStateCopyWith<ReviewState, ReviewState, ReviewState> get copyWith =>
      _ReviewStateCopyWithImpl<ReviewState, ReviewState>(
        this as ReviewState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ReviewStateMapper.ensureInitialized().stringifyValue(
      this as ReviewState,
    );
  }

  @override
  bool operator ==(Object other) {
    return ReviewStateMapper.ensureInitialized().equalsValue(
      this as ReviewState,
      other,
    );
  }

  @override
  int get hashCode {
    return ReviewStateMapper.ensureInitialized().hashValue(this as ReviewState);
  }
}

extension ReviewStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReviewState, $Out> {
  ReviewStateCopyWith<$R, ReviewState, $Out> get $asReviewState =>
      $base.as((v, t, t2) => _ReviewStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ReviewStateCopyWith<$R, $In extends ReviewState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Review, ObjectCopyWith<$R, Review, Review>> get reviews;
  $R call({
    Review? submitted,
    List<Review>? reviews,
    bool? hasMore,
    String? cursor,
    bool? isLoading,
    BaseError? error,
    String? message,
  });
  ReviewStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReviewStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReviewState, $Out>
    implements ReviewStateCopyWith<$R, ReviewState, $Out> {
  _ReviewStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReviewState> $mapper =
      ReviewStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Review, ObjectCopyWith<$R, Review, Review>> get reviews =>
      ListCopyWith(
        $value.reviews,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(reviews: v),
      );
  @override
  $R call({
    Object? submitted = $none,
    List<Review>? reviews,
    bool? hasMore,
    Object? cursor = $none,
    bool? isLoading,
    Object? error = $none,
    Object? message = $none,
  }) => $apply(
    FieldCopyWithData({
      if (submitted != $none) #submitted: submitted,
      if (reviews != null) #reviews: reviews,
      if (hasMore != null) #hasMore: hasMore,
      if (cursor != $none) #cursor: cursor,
      if (isLoading != null) #isLoading: isLoading,
      if (error != $none) #error: error,
      if (message != $none) #message: message,
    }),
  );
  @override
  ReviewState $make(CopyWithData data) => ReviewState(
    submitted: data.get(#submitted, or: $value.submitted),
    reviews: data.get(#reviews, or: $value.reviews),
    hasMore: data.get(#hasMore, or: $value.hasMore),
    cursor: data.get(#cursor, or: $value.cursor),
    isLoading: data.get(#isLoading, or: $value.isLoading),
    error: data.get(#error, or: $value.error),
    message: data.get(#message, or: $value.message),
  );

  @override
  ReviewStateCopyWith<$R2, ReviewState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ReviewStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

