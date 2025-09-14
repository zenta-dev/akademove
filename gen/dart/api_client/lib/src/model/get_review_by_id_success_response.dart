//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/review.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_review_by_id_success_response.g.dart';

/// GetReviewByIdSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class GetReviewByIdSuccessResponse implements Built<GetReviewByIdSuccessResponse, GetReviewByIdSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetReviewByIdSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Review get data;

  GetReviewByIdSuccessResponse._();

  factory GetReviewByIdSuccessResponse([void updates(GetReviewByIdSuccessResponseBuilder b)]) = _$GetReviewByIdSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetReviewByIdSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetReviewByIdSuccessResponse> get serializer => _$GetReviewByIdSuccessResponseSerializer();
}

class _$GetReviewByIdSuccessResponseSerializer implements PrimitiveSerializer<GetReviewByIdSuccessResponse> {
  @override
  final Iterable<Type> types = const [GetReviewByIdSuccessResponse, _$GetReviewByIdSuccessResponse];

  @override
  final String wireName = r'GetReviewByIdSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetReviewByIdSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetReviewByIdSuccessResponseSuccessEnum),
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
    GetReviewByIdSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetReviewByIdSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GetReviewByIdSuccessResponseSuccessEnum),
          ) as GetReviewByIdSuccessResponseSuccessEnum;
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
  GetReviewByIdSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetReviewByIdSuccessResponseBuilder();
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

class GetReviewByIdSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const GetReviewByIdSuccessResponseSuccessEnum true_ = _$getReviewByIdSuccessResponseSuccessEnum_true_;

  static Serializer<GetReviewByIdSuccessResponseSuccessEnum> get serializer => _$getReviewByIdSuccessResponseSuccessEnumSerializer;

  const GetReviewByIdSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<GetReviewByIdSuccessResponseSuccessEnum> get values => _$getReviewByIdSuccessResponseSuccessEnumValues;
  static GetReviewByIdSuccessResponseSuccessEnum valueOf(String name) => _$getReviewByIdSuccessResponseSuccessEnumValueOf(name);
}

