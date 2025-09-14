//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/review.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_all_review_success_response.g.dart';

/// GetAllReviewSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class GetAllReviewSuccessResponse implements Built<GetAllReviewSuccessResponse, GetAllReviewSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetAllReviewSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Review> get data;

  GetAllReviewSuccessResponse._();

  factory GetAllReviewSuccessResponse([void updates(GetAllReviewSuccessResponseBuilder b)]) = _$GetAllReviewSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetAllReviewSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetAllReviewSuccessResponse> get serializer => _$GetAllReviewSuccessResponseSerializer();
}

class _$GetAllReviewSuccessResponseSerializer implements PrimitiveSerializer<GetAllReviewSuccessResponse> {
  @override
  final Iterable<Type> types = const [GetAllReviewSuccessResponse, _$GetAllReviewSuccessResponse];

  @override
  final String wireName = r'GetAllReviewSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetAllReviewSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetAllReviewSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(Review)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetAllReviewSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetAllReviewSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GetAllReviewSuccessResponseSuccessEnum),
          ) as GetAllReviewSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(BuiltList, [FullType(Review)]),
          ) as BuiltList<Review>;
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
  GetAllReviewSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetAllReviewSuccessResponseBuilder();
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

class GetAllReviewSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const GetAllReviewSuccessResponseSuccessEnum true_ = _$getAllReviewSuccessResponseSuccessEnum_true_;

  static Serializer<GetAllReviewSuccessResponseSuccessEnum> get serializer => _$getAllReviewSuccessResponseSuccessEnumSerializer;

  const GetAllReviewSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<GetAllReviewSuccessResponseSuccessEnum> get values => _$getAllReviewSuccessResponseSuccessEnumValues;
  static GetAllReviewSuccessResponseSuccessEnum valueOf(String name) => _$getAllReviewSuccessResponseSuccessEnumValueOf(name);
}

