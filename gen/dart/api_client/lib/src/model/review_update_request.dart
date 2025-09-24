//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'review_update_request.g.dart';

/// ReviewUpdateRequest
///
/// Properties:
/// * [orderId] 
/// * [fromUserId] 
/// * [toUserId] 
/// * [category] 
/// * [score] 
/// * [comment] 
@BuiltValue()
abstract class ReviewUpdateRequest implements Built<ReviewUpdateRequest, ReviewUpdateRequestBuilder> {
  @BuiltValueField(wireName: r'orderId')
  String? get orderId;

  @BuiltValueField(wireName: r'fromUserId')
  String? get fromUserId;

  @BuiltValueField(wireName: r'toUserId')
  String? get toUserId;

  @BuiltValueField(wireName: r'category')
  ReviewUpdateRequestCategoryEnum? get category;
  // enum categoryEnum {  cleanliness,  courtesy,  other,  };

  @BuiltValueField(wireName: r'score')
  num? get score;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  ReviewUpdateRequest._();

  factory ReviewUpdateRequest([void updates(ReviewUpdateRequestBuilder b)]) = _$ReviewUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReviewUpdateRequestBuilder b) => b
      ..category = const ReviewUpdateRequestCategoryEnum._('other')
      ..comment = '';

  @BuiltValueSerializer(custom: true)
  static Serializer<ReviewUpdateRequest> get serializer => _$ReviewUpdateRequestSerializer();
}

class _$ReviewUpdateRequestSerializer implements PrimitiveSerializer<ReviewUpdateRequest> {
  @override
  final Iterable<Type> types = const [ReviewUpdateRequest, _$ReviewUpdateRequest];

  @override
  final String wireName = r'ReviewUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReviewUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.orderId != null) {
      yield r'orderId';
      yield serializers.serialize(
        object.orderId,
        specifiedType: const FullType(String),
      );
    }
    if (object.fromUserId != null) {
      yield r'fromUserId';
      yield serializers.serialize(
        object.fromUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.toUserId != null) {
      yield r'toUserId';
      yield serializers.serialize(
        object.toUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(ReviewUpdateRequestCategoryEnum),
      );
    }
    if (object.score != null) {
      yield r'score';
      yield serializers.serialize(
        object.score,
        specifiedType: const FullType(num),
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
    ReviewUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReviewUpdateRequestBuilder result,
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
            specifiedType: const FullType(ReviewUpdateRequestCategoryEnum),
          ) as ReviewUpdateRequestCategoryEnum;
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
  ReviewUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReviewUpdateRequestBuilder();
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

class ReviewUpdateRequestCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cleanliness')
  static const ReviewUpdateRequestCategoryEnum cleanliness = _$reviewUpdateRequestCategoryEnum_cleanliness;
  @BuiltValueEnumConst(wireName: r'courtesy')
  static const ReviewUpdateRequestCategoryEnum courtesy = _$reviewUpdateRequestCategoryEnum_courtesy;
  @BuiltValueEnumConst(wireName: r'other')
  static const ReviewUpdateRequestCategoryEnum other = _$reviewUpdateRequestCategoryEnum_other;

  static Serializer<ReviewUpdateRequestCategoryEnum> get serializer => _$reviewUpdateRequestCategoryEnumSerializer;

  const ReviewUpdateRequestCategoryEnum._(String name): super(name);

  static BuiltSet<ReviewUpdateRequestCategoryEnum> get values => _$reviewUpdateRequestCategoryEnumValues;
  static ReviewUpdateRequestCategoryEnum valueOf(String name) => _$reviewUpdateRequestCategoryEnumValueOf(name);
}

