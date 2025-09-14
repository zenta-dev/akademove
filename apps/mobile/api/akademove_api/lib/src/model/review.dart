//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'review.g.dart';

/// Review
///
/// Properties:
/// * [id]
/// * [orderId]
/// * [fromUserId]
/// * [toUserId]
/// * [score]
/// * [createdAt] - unix timestamp format
/// * [category]
/// * [comment]
@BuiltValue()
abstract class Review implements Built<Review, ReviewBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'orderId')
  String get orderId;

  @BuiltValueField(wireName: r'fromUserId')
  String get fromUserId;

  @BuiltValueField(wireName: r'toUserId')
  String get toUserId;

  @BuiltValueField(wireName: r'score')
  num get score;

  /// unix timestamp format
  @BuiltValueField(wireName: r'createdAt')
  num get createdAt;

  @BuiltValueField(wireName: r'category')
  ReviewCategoryEnum? get category;
  // enum categoryEnum {  cleanliness,  courtesy,  other,  };

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  Review._();

  factory Review([void updates(ReviewBuilder b)]) = _$Review;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReviewBuilder b) => b
    ..category = const ReviewCategoryEnum._('other')
    ..comment = '';

  @BuiltValueSerializer(custom: true)
  static Serializer<Review> get serializer => _$ReviewSerializer();
}

class _$ReviewSerializer implements PrimitiveSerializer<Review> {
  @override
  final Iterable<Type> types = const [Review, _$Review];

  @override
  final String wireName = r'Review';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Review object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'orderId';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    yield r'fromUserId';
    yield serializers.serialize(
      object.fromUserId,
      specifiedType: const FullType(String),
    );
    yield r'toUserId';
    yield serializers.serialize(
      object.toUserId,
      specifiedType: const FullType(String),
    );
    yield r'score';
    yield serializers.serialize(
      object.score,
      specifiedType: const FullType(num),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(num),
    );
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(ReviewCategoryEnum),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Review object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'orderId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        case r'fromUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fromUserId = valueDes;
          break;
        case r'toUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.toUserId = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.score = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.createdAt = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReviewCategoryEnum),
          ) as ReviewCategoryEnum;
          result.category = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.comment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Review deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReviewBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class ReviewCategoryEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'cleanliness')
  static const ReviewCategoryEnum cleanliness =
      _$reviewCategoryEnum_cleanliness;
  @BuiltValueEnumConst(wireName: r'courtesy')
  static const ReviewCategoryEnum courtesy = _$reviewCategoryEnum_courtesy;
  @BuiltValueEnumConst(wireName: r'other')
  static const ReviewCategoryEnum other = _$reviewCategoryEnum_other;

  static Serializer<ReviewCategoryEnum> get serializer =>
      _$reviewCategoryEnumSerializer;

  const ReviewCategoryEnum._(String name) : super(name);

  static BuiltSet<ReviewCategoryEnum> get values => _$reviewCategoryEnumValues;
  static ReviewCategoryEnum valueOf(String name) =>
      _$reviewCategoryEnumValueOf(name);
}
