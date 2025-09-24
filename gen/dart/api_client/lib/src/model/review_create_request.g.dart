// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ReviewCreateRequestCategoryEnum
_$reviewCreateRequestCategoryEnum_cleanliness =
    const ReviewCreateRequestCategoryEnum._('cleanliness');
const ReviewCreateRequestCategoryEnum
_$reviewCreateRequestCategoryEnum_courtesy =
    const ReviewCreateRequestCategoryEnum._('courtesy');
const ReviewCreateRequestCategoryEnum _$reviewCreateRequestCategoryEnum_other =
    const ReviewCreateRequestCategoryEnum._('other');

ReviewCreateRequestCategoryEnum _$reviewCreateRequestCategoryEnumValueOf(
  String name,
) {
  switch (name) {
    case 'cleanliness':
      return _$reviewCreateRequestCategoryEnum_cleanliness;
    case 'courtesy':
      return _$reviewCreateRequestCategoryEnum_courtesy;
    case 'other':
      return _$reviewCreateRequestCategoryEnum_other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ReviewCreateRequestCategoryEnum>
_$reviewCreateRequestCategoryEnumValues =
    BuiltSet<ReviewCreateRequestCategoryEnum>(
      const <ReviewCreateRequestCategoryEnum>[
        _$reviewCreateRequestCategoryEnum_cleanliness,
        _$reviewCreateRequestCategoryEnum_courtesy,
        _$reviewCreateRequestCategoryEnum_other,
      ],
    );

Serializer<ReviewCreateRequestCategoryEnum>
_$reviewCreateRequestCategoryEnumSerializer =
    _$ReviewCreateRequestCategoryEnumSerializer();

class _$ReviewCreateRequestCategoryEnumSerializer
    implements PrimitiveSerializer<ReviewCreateRequestCategoryEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'cleanliness': 'cleanliness',
    'courtesy': 'courtesy',
    'other': 'other',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'cleanliness': 'cleanliness',
    'courtesy': 'courtesy',
    'other': 'other',
  };

  @override
  final Iterable<Type> types = const <Type>[ReviewCreateRequestCategoryEnum];
  @override
  final String wireName = 'ReviewCreateRequestCategoryEnum';

  @override
  Object serialize(
    Serializers serializers,
    ReviewCreateRequestCategoryEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ReviewCreateRequestCategoryEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ReviewCreateRequestCategoryEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ReviewCreateRequest extends ReviewCreateRequest {
  @override
  final String orderId;
  @override
  final String fromUserId;
  @override
  final String toUserId;
  @override
  final ReviewCreateRequestCategoryEnum? category;
  @override
  final num score;
  @override
  final String? comment;

  factory _$ReviewCreateRequest([
    void Function(ReviewCreateRequestBuilder)? updates,
  ]) => (ReviewCreateRequestBuilder()..update(updates))._build();

  _$ReviewCreateRequest._({
    required this.orderId,
    required this.fromUserId,
    required this.toUserId,
    this.category,
    required this.score,
    this.comment,
  }) : super._();
  @override
  ReviewCreateRequest rebuild(
    void Function(ReviewCreateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReviewCreateRequestBuilder toBuilder() =>
      ReviewCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewCreateRequest &&
        orderId == other.orderId &&
        fromUserId == other.fromUserId &&
        toUserId == other.toUserId &&
        category == other.category &&
        score == other.score &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, fromUserId.hashCode);
    _$hash = $jc(_$hash, toUserId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewCreateRequest')
          ..add('orderId', orderId)
          ..add('fromUserId', fromUserId)
          ..add('toUserId', toUserId)
          ..add('category', category)
          ..add('score', score)
          ..add('comment', comment))
        .toString();
  }
}

class ReviewCreateRequestBuilder
    implements Builder<ReviewCreateRequest, ReviewCreateRequestBuilder> {
  _$ReviewCreateRequest? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _fromUserId;
  String? get fromUserId => _$this._fromUserId;
  set fromUserId(String? fromUserId) => _$this._fromUserId = fromUserId;

  String? _toUserId;
  String? get toUserId => _$this._toUserId;
  set toUserId(String? toUserId) => _$this._toUserId = toUserId;

  ReviewCreateRequestCategoryEnum? _category;
  ReviewCreateRequestCategoryEnum? get category => _$this._category;
  set category(ReviewCreateRequestCategoryEnum? category) =>
      _$this._category = category;

  num? _score;
  num? get score => _$this._score;
  set score(num? score) => _$this._score = score;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  ReviewCreateRequestBuilder() {
    ReviewCreateRequest._defaults(this);
  }

  ReviewCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _fromUserId = $v.fromUserId;
      _toUserId = $v.toUserId;
      _category = $v.category;
      _score = $v.score;
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewCreateRequest other) {
    _$v = other as _$ReviewCreateRequest;
  }

  @override
  void update(void Function(ReviewCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewCreateRequest build() => _build();

  _$ReviewCreateRequest _build() {
    final _$result =
        _$v ??
        _$ReviewCreateRequest._(
          orderId: BuiltValueNullFieldError.checkNotNull(
            orderId,
            r'ReviewCreateRequest',
            'orderId',
          ),
          fromUserId: BuiltValueNullFieldError.checkNotNull(
            fromUserId,
            r'ReviewCreateRequest',
            'fromUserId',
          ),
          toUserId: BuiltValueNullFieldError.checkNotNull(
            toUserId,
            r'ReviewCreateRequest',
            'toUserId',
          ),
          category: category,
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'ReviewCreateRequest',
            'score',
          ),
          comment: comment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
