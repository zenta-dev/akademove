// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ReviewCategoryEnum _$reviewCategoryEnum_cleanliness =
    const ReviewCategoryEnum._('cleanliness');
const ReviewCategoryEnum _$reviewCategoryEnum_courtesy =
    const ReviewCategoryEnum._('courtesy');
const ReviewCategoryEnum _$reviewCategoryEnum_other =
    const ReviewCategoryEnum._('other');

ReviewCategoryEnum _$reviewCategoryEnumValueOf(String name) {
  switch (name) {
    case 'cleanliness':
      return _$reviewCategoryEnum_cleanliness;
    case 'courtesy':
      return _$reviewCategoryEnum_courtesy;
    case 'other':
      return _$reviewCategoryEnum_other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ReviewCategoryEnum> _$reviewCategoryEnumValues =
    BuiltSet<ReviewCategoryEnum>(const <ReviewCategoryEnum>[
      _$reviewCategoryEnum_cleanliness,
      _$reviewCategoryEnum_courtesy,
      _$reviewCategoryEnum_other,
    ]);

Serializer<ReviewCategoryEnum> _$reviewCategoryEnumSerializer =
    _$ReviewCategoryEnumSerializer();

class _$ReviewCategoryEnumSerializer
    implements PrimitiveSerializer<ReviewCategoryEnum> {
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
  final Iterable<Type> types = const <Type>[ReviewCategoryEnum];
  @override
  final String wireName = 'ReviewCategoryEnum';

  @override
  Object serialize(
    Serializers serializers,
    ReviewCategoryEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ReviewCategoryEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ReviewCategoryEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$Review extends Review {
  @override
  final String id;
  @override
  final String orderId;
  @override
  final String fromUserId;
  @override
  final String toUserId;
  @override
  final ReviewCategoryEnum? category;
  @override
  final num score;
  @override
  final String? comment;
  @override
  final num createdAt;

  factory _$Review([void Function(ReviewBuilder)? updates]) =>
      (ReviewBuilder()..update(updates))._build();

  _$Review._({
    required this.id,
    required this.orderId,
    required this.fromUserId,
    required this.toUserId,
    this.category,
    required this.score,
    this.comment,
    required this.createdAt,
  }) : super._();
  @override
  Review rebuild(void Function(ReviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewBuilder toBuilder() => ReviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Review &&
        id == other.id &&
        orderId == other.orderId &&
        fromUserId == other.fromUserId &&
        toUserId == other.toUserId &&
        category == other.category &&
        score == other.score &&
        comment == other.comment &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, fromUserId.hashCode);
    _$hash = $jc(_$hash, toUserId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Review')
          ..add('id', id)
          ..add('orderId', orderId)
          ..add('fromUserId', fromUserId)
          ..add('toUserId', toUserId)
          ..add('category', category)
          ..add('score', score)
          ..add('comment', comment)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ReviewBuilder implements Builder<Review, ReviewBuilder> {
  _$Review? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _fromUserId;
  String? get fromUserId => _$this._fromUserId;
  set fromUserId(String? fromUserId) => _$this._fromUserId = fromUserId;

  String? _toUserId;
  String? get toUserId => _$this._toUserId;
  set toUserId(String? toUserId) => _$this._toUserId = toUserId;

  ReviewCategoryEnum? _category;
  ReviewCategoryEnum? get category => _$this._category;
  set category(ReviewCategoryEnum? category) => _$this._category = category;

  num? _score;
  num? get score => _$this._score;
  set score(num? score) => _$this._score = score;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  num? _createdAt;
  num? get createdAt => _$this._createdAt;
  set createdAt(num? createdAt) => _$this._createdAt = createdAt;

  ReviewBuilder() {
    Review._defaults(this);
  }

  ReviewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _orderId = $v.orderId;
      _fromUserId = $v.fromUserId;
      _toUserId = $v.toUserId;
      _category = $v.category;
      _score = $v.score;
      _comment = $v.comment;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Review other) {
    _$v = other as _$Review;
  }

  @override
  void update(void Function(ReviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Review build() => _build();

  _$Review _build() {
    final _$result =
        _$v ??
        _$Review._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Review', 'id'),
          orderId: BuiltValueNullFieldError.checkNotNull(
            orderId,
            r'Review',
            'orderId',
          ),
          fromUserId: BuiltValueNullFieldError.checkNotNull(
            fromUserId,
            r'Review',
            'fromUserId',
          ),
          toUserId: BuiltValueNullFieldError.checkNotNull(
            toUserId,
            r'Review',
            'toUserId',
          ),
          category: category,
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'Review',
            'score',
          ),
          comment: comment,
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'Review',
            'createdAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
