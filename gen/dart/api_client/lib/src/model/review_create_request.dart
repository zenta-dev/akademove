//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'review_create_request.g.dart';

/// ReviewCreateRequest
///
/// Properties:
/// * [orderId] 
/// * [fromUserId] 
/// * [toUserId] 
/// * [category] 
/// * [score] 
/// * [comment] 
@BuiltValue()
abstract class ReviewCreateRequest implements Built<ReviewCreateRequest, ReviewCreateRequestBuilder> {
  @BuiltValueField(wireName: r'orderId')
  String get orderId;

  @BuiltValueField(wireName: r'fromUserId')
  String get fromUserId;

  @BuiltValueField(wireName: r'toUserId')
  String get toUserId;

  @BuiltValueField(wireName: r'category')
  ReviewCreateRequestCategoryEnum? get category;
  // enum categoryEnum {  cleanliness,  courtesy,  other,  };

  @BuiltValueField(wireName: r'score')
  num get score;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  ReviewCreateRequest._();

  factory ReviewCreateRequest([void updates(ReviewCreateRequestBuilder b)]) = _$ReviewCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReviewCreateRequestBuilder b) => b
      ..category = const ReviewCreateRequestCategoryEnum._('other')
      ..comment = '';

  @BuiltValueSerializer(custom: true)
  static Serializer<ReviewCreateRequest> get serializer => _$ReviewCreateRequestSerializer();
}

class _$ReviewCreateRequestSerializer implements PrimitiveSerializer<ReviewCreateRequest> {
  @override
  final Iterable<Type> types = const [ReviewCreateRequest, _$ReviewCreateRequest];

  @override
  final String wireName = r'ReviewCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReviewCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(ReviewCreateRequestCategoryEnum),
      );
    }
    yield r'score';
    yield serializers.serialize(
      object.score,
      specifiedType: const FullType(num),
    );
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
    ReviewCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReviewCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReviewCreateRequestCategoryEnum),
          ) as ReviewCreateRequestCategoryEnum;
          result.category = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.score = valueDes;
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
  ReviewCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReviewCreateRequestBuilder();
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

class ReviewCreateRequestCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cleanliness')
  static const ReviewCreateRequestCategoryEnum cleanliness = _$reviewCreateRequestCategoryEnum_cleanliness;
  @BuiltValueEnumConst(wireName: r'courtesy')
  static const ReviewCreateRequestCategoryEnum courtesy = _$reviewCreateRequestCategoryEnum_courtesy;
  @BuiltValueEnumConst(wireName: r'other')
  static const ReviewCreateRequestCategoryEnum other = _$reviewCreateRequestCategoryEnum_other;

  static Serializer<ReviewCreateRequestCategoryEnum> get serializer => _$reviewCreateRequestCategoryEnumSerializer;

  const ReviewCreateRequestCategoryEnum._(String name): super(name);

  static BuiltSet<ReviewCreateRequestCategoryEnum> get values => _$reviewCreateRequestCategoryEnumValues;
  static ReviewCreateRequestCategoryEnum valueOf(String name) => _$reviewCreateRequestCategoryEnumValueOf(name);
}

