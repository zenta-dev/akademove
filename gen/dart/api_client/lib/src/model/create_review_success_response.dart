//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/review.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_review_success_response.g.dart';

/// CreateReviewSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class CreateReviewSuccessResponse implements Built<CreateReviewSuccessResponse, CreateReviewSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  CreateReviewSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Review get data;

  CreateReviewSuccessResponse._();

  factory CreateReviewSuccessResponse([void updates(CreateReviewSuccessResponseBuilder b)]) = _$CreateReviewSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateReviewSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateReviewSuccessResponse> get serializer => _$CreateReviewSuccessResponseSerializer();
}

class _$CreateReviewSuccessResponseSerializer implements PrimitiveSerializer<CreateReviewSuccessResponse> {
  @override
  final Iterable<Type> types = const [CreateReviewSuccessResponse, _$CreateReviewSuccessResponse];

  @override
  final String wireName = r'CreateReviewSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateReviewSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(CreateReviewSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Review),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateReviewSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateReviewSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateReviewSuccessResponseSuccessEnum),
          ) as CreateReviewSuccessResponseSuccessEnum;
          result.success = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Review),
          ) as Review;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateReviewSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateReviewSuccessResponseBuilder();
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

class CreateReviewSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const CreateReviewSuccessResponseSuccessEnum true_ = _$createReviewSuccessResponseSuccessEnum_true_;

  static Serializer<CreateReviewSuccessResponseSuccessEnum> get serializer => _$createReviewSuccessResponseSuccessEnumSerializer;

  const CreateReviewSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<CreateReviewSuccessResponseSuccessEnum> get values => _$createReviewSuccessResponseSuccessEnumValues;
  static CreateReviewSuccessResponseSuccessEnum valueOf(String name) => _$createReviewSuccessResponseSuccessEnumValueOf(name);
}

