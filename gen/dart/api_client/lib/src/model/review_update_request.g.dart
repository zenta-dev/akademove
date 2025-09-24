// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ReviewUpdateRequestCategoryEnum
_$reviewUpdateRequestCategoryEnum_cleanliness =
    const ReviewUpdateRequestCategoryEnum._('cleanliness');
const ReviewUpdateRequestCategoryEnum
_$reviewUpdateRequestCategoryEnum_courtesy =
    const ReviewUpdateRequestCategoryEnum._('courtesy');
const ReviewUpdateRequestCategoryEnum _$reviewUpdateRequestCategoryEnum_other =
    const ReviewUpdateRequestCategoryEnum._('other');

ReviewUpdateRequestCategoryEnum _$reviewUpdateRequestCategoryEnumValueOf(
  String name,
) {
  switch (name) {
    case 'cleanliness':
      return _$reviewUpdateRequestCategoryEnum_cleanliness;
    case 'courtesy':
      return _$reviewUpdateRequestCategoryEnum_courtesy;
    case 'other':
      return _$reviewUpdateRequestCategoryEnum_other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ReviewUpdateRequestCategoryEnum>
_$reviewUpdateRequestCategoryEnumValues =
    BuiltSet<ReviewUpdateRequestCategoryEnum>(
      const <ReviewUpdateRequestCategoryEnum>[
        _$reviewUpdateRequestCategoryEnum_cleanliness,
        _$reviewUpdateRequestCategoryEnum_courtesy,
        _$reviewUpdateRequestCategoryEnum_other,
      ],
    );

Serializer<ReviewUpdateRequestCategoryEnum>
_$reviewUpdateRequestCategoryEnumSerializer =
    _$ReviewUpdateRequestCategoryEnumSerializer();

class _$ReviewUpdateRequestCategoryEnumSerializer
    implements PrimitiveSerializer<ReviewUpdateRequestCategoryEnum> {
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
  final Iterable<Type> types = const <Type>[ReviewUpdateRequestCategoryEnum];
  @override
  final String wireName = 'ReviewUpdateRequestCategoryEnum';

  @override
  Object serialize(
    Serializers serializers,
    ReviewUpdateRequestCategoryEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ReviewUpdateRequestCategoryEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ReviewUpdateRequestCategoryEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ReviewUpdateRequest extends ReviewUpdateRequest {
  @override
  final String? orderId;
  @override
  final String? fromUserId;
  @override
  final String? toUserId;
  @override
  final ReviewUpdateRequestCategoryEnum? category;
  @override
  final num? score;
  @override
  final String? comment;

  factory _$ReviewUpdateRequest([
    void Function(ReviewUpdateRequestBuilder)? updates,
  ]) => (ReviewUpdateRequestBuilder()..update(updates))._build();

  _$ReviewUpdateRequest._({
    this.orderId,
    this.fromUserId,
    this.toUserId,
    this.category,
    this.score,
    this.comment,
  }) : super._();
  @override
  ReviewUpdateRequest rebuild(
    void Function(ReviewUpdateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReviewUpdateRequestBuilder toBuilder() =>
      ReviewUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewUpdateRequest &&
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
    return (newBuiltValueToStringHelper(r'ReviewUpdateRequest')
          ..add('orderId', orderId)
          ..add('fromUserId', fromUserId)
          ..add('toUserId', toUserId)
          ..add('category', category)
          ..add('score', score)
          ..add('comment', comment))
        .toString();
  }
}

class ReviewUpdateRequestBuilder
    implements Builder<ReviewUpdateRequest, ReviewUpdateRequestBuilder> {
  _$ReviewUpdateRequest? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _fromUserId;
  String? get fromUserId => _$this._fromUserId;
  set fromUserId(String? fromUserId) => _$this._fromUserId = fromUserId;

  String? _toUserId;
  String? get toUserId => _$this._toUserId;
  set toUserId(String? toUserId) => _$this._toUserId = toUserId;

  ReviewUpdateRequestCategoryEnum? _category;
  ReviewUpdateRequestCategoryEnum? get category => _$this._category;
  set category(ReviewUpdateRequestCategoryEnum? category) =>
      _$this._category = category;

  num? _score;
  num? get score => _$this._score;
  set score(num? score) => _$this._score = score;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  ReviewUpdateRequestBuilder() {
    ReviewUpdateRequest._defaults(this);
  }

  ReviewUpdateRequestBuilder get _$this {
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
  void replace(ReviewUpdateRequest other) {
    _$v = other as _$ReviewUpdateRequest;
  }

  @override
  void update(void Function(ReviewUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewUpdateRequest build() => _build();

  _$ReviewUpdateRequest _build() {
    final _$result =
        _$v ??
        _$ReviewUpdateRequest._(
          orderId: orderId,
          fromUserId: fromUserId,
          toUserId: toUserId,
          category: category,
          score: score,
          comment: comment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
