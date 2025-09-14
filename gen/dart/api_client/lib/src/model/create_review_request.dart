//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_review_request.g.dart';

/// CreateReviewRequest
///
/// Properties:
/// * [orderId] 
/// * [fromUserId] 
/// * [toUserId] 
/// * [category] 
/// * [score] 
/// * [comment] 
@BuiltValue()
abstract class CreateReviewRequest implements Built<CreateReviewRequest, CreateReviewRequestBuilder> {
  @BuiltValueField(wireName: r'orderId')
  String get orderId;

  @BuiltValueField(wireName: r'fromUserId')
  String get fromUserId;

  @BuiltValueField(wireName: r'toUserId')
  String get toUserId;

  @BuiltValueField(wireName: r'category')
  CreateReviewRequestCategoryEnum? get category;
  // enum categoryEnum {  cleanliness,  courtesy,  other,  };

  @BuiltValueField(wireName: r'score')
  num get score;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  CreateReviewRequest._();

  factory CreateReviewRequest([void updates(CreateReviewRequestBuilder b)]) = _$CreateReviewRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateReviewRequestBuilder b) => b
      ..category = const CreateReviewRequestCategoryEnum._('other')
      ..comment = '';

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateReviewRequest> get serializer => _$CreateReviewRequestSerializer();
}

class _$CreateReviewRequestSerializer implements PrimitiveSerializer<CreateReviewRequest> {
  @override
  final Iterable<Type> types = const [CreateReviewRequest, _$CreateReviewRequest];

  @override
  final String wireName = r'CreateReviewRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateReviewRequest object, {
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
        specifiedType: const FullType(CreateReviewRequestCategoryEnum),
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
    CreateReviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateReviewRequestBuilder result,
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
            specifiedType: const FullType(CreateReviewRequestCategoryEnum),
          ) as CreateReviewRequestCategoryEnum;
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
  CreateReviewRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateReviewRequestBuilder();
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

class CreateReviewRequestCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cleanliness')
  static const CreateReviewRequestCategoryEnum cleanliness = _$createReviewRequestCategoryEnum_cleanliness;
  @BuiltValueEnumConst(wireName: r'courtesy')
  static const CreateReviewRequestCategoryEnum courtesy = _$createReviewRequestCategoryEnum_courtesy;
  @BuiltValueEnumConst(wireName: r'other')
  static const CreateReviewRequestCategoryEnum other = _$createReviewRequestCategoryEnum_other;

  static Serializer<CreateReviewRequestCategoryEnum> get serializer => _$createReviewRequestCategoryEnumSerializer;

  const CreateReviewRequestCategoryEnum._(String name): super(name);

  static BuiltSet<CreateReviewRequestCategoryEnum> get values => _$createReviewRequestCategoryEnumValues;
  static CreateReviewRequestCategoryEnum valueOf(String name) => _$createReviewRequestCategoryEnumValueOf(name);
}

