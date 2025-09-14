// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateReviewRequestCategoryEnum
    _$createReviewRequestCategoryEnum_cleanliness =
    const CreateReviewRequestCategoryEnum._('cleanliness');
const CreateReviewRequestCategoryEnum
    _$createReviewRequestCategoryEnum_courtesy =
    const CreateReviewRequestCategoryEnum._('courtesy');
const CreateReviewRequestCategoryEnum _$createReviewRequestCategoryEnum_other =
    const CreateReviewRequestCategoryEnum._('other');

CreateReviewRequestCategoryEnum _$createReviewRequestCategoryEnumValueOf(
    String name) {
  switch (name) {
    case 'cleanliness':
      return _$createReviewRequestCategoryEnum_cleanliness;
    case 'courtesy':
      return _$createReviewRequestCategoryEnum_courtesy;
    case 'other':
      return _$createReviewRequestCategoryEnum_other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateReviewRequestCategoryEnum>
    _$createReviewRequestCategoryEnumValues = BuiltSet<
        CreateReviewRequestCategoryEnum>(const <CreateReviewRequestCategoryEnum>[
  _$createReviewRequestCategoryEnum_cleanliness,
  _$createReviewRequestCategoryEnum_courtesy,
  _$createReviewRequestCategoryEnum_other,
]);

Serializer<CreateReviewRequestCategoryEnum>
    _$createReviewRequestCategoryEnumSerializer =
    _$CreateReviewRequestCategoryEnumSerializer();

class _$CreateReviewRequestCategoryEnumSerializer
    implements PrimitiveSerializer<CreateReviewRequestCategoryEnum> {
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
  final Iterable<Type> types = const <Type>[CreateReviewRequestCategoryEnum];
  @override
  final String wireName = 'CreateReviewRequestCategoryEnum';

  @override
  Object serialize(
          Serializers serializers, CreateReviewRequestCategoryEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateReviewRequestCategoryEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateReviewRequestCategoryEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateReviewRequest extends CreateReviewRequest {
  @override
  final String orderId;
  @override
  final String fromUserId;
  @override
  final String toUserId;
  @override
  final num score;
  @override
  final CreateReviewRequestCategoryEnum? category;
  @override
  final String? comment;

  factory _$CreateReviewRequest(
          [void Function(CreateReviewRequestBuilder)? updates]) =>
      (CreateReviewRequestBuilder()..update(updates))._build();

  _$CreateReviewRequest._(
      {required this.orderId,
      required this.fromUserId,
      required this.toUserId,
      required this.score,
      this.category,
      this.comment})
      : super._();
  @override
  CreateReviewRequest rebuild(
          void Function(CreateReviewRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateReviewRequestBuilder toBuilder() =>
      CreateReviewRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateReviewRequest &&
        orderId == other.orderId &&
        fromUserId == other.fromUserId &&
        toUserId == other.toUserId &&
        score == other.score &&
        category == other.category &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, fromUserId.hashCode);
    _$hash = $jc(_$hash, toUserId.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateReviewRequest')
          ..add('orderId', orderId)
          ..add('fromUserId', fromUserId)
          ..add('toUserId', toUserId)
          ..add('score', score)
          ..add('category', category)
          ..add('comment', comment))
        .toString();
  }
}

class CreateReviewRequestBuilder
    implements Builder<CreateReviewRequest, CreateReviewRequestBuilder> {
  _$CreateReviewRequest? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _fromUserId;
  String? get fromUserId => _$this._fromUserId;
  set fromUserId(String? fromUserId) => _$this._fromUserId = fromUserId;

  String? _toUserId;
  String? get toUserId => _$this._toUserId;
  set toUserId(String? toUserId) => _$this._toUserId = toUserId;

  num? _score;
  num? get score => _$this._score;
  set score(num? score) => _$this._score = score;

  CreateReviewRequestCategoryEnum? _category;
  CreateReviewRequestCategoryEnum? get category => _$this._category;
  set category(CreateReviewRequestCategoryEnum? category) =>
      _$this._category = category;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  CreateReviewRequestBuilder() {
    CreateReviewRequest._defaults(this);
  }

  CreateReviewRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _fromUserId = $v.fromUserId;
      _toUserId = $v.toUserId;
      _score = $v.score;
      _category = $v.category;
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateReviewRequest other) {
    _$v = other as _$CreateReviewRequest;
  }

  @override
  void update(void Function(CreateReviewRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateReviewRequest build() => _build();

  _$CreateReviewRequest _build() {
    final _$result = _$v ??
        _$CreateReviewRequest._(
          orderId: BuiltValueNullFieldError.checkNotNull(
              orderId, r'CreateReviewRequest', 'orderId'),
          fromUserId: BuiltValueNullFieldError.checkNotNull(
              fromUserId, r'CreateReviewRequest', 'fromUserId'),
          toUserId: BuiltValueNullFieldError.checkNotNull(
              toUserId, r'CreateReviewRequest', 'toUserId'),
          score: BuiltValueNullFieldError.checkNotNull(
              score, r'CreateReviewRequest', 'score'),
          category: category,
          comment: comment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
