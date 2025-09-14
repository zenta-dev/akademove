//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/promo.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_promo_by_id_success_response.g.dart';

/// GetPromoByIdSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class GetPromoByIdSuccessResponse
    implements
        Built<GetPromoByIdSuccessResponse, GetPromoByIdSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetPromoByIdSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Promo get data;

  GetPromoByIdSuccessResponse._();

  factory GetPromoByIdSuccessResponse(
          [void updates(GetPromoByIdSuccessResponseBuilder b)]) =
      _$GetPromoByIdSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetPromoByIdSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetPromoByIdSuccessResponse> get serializer =>
      _$GetPromoByIdSuccessResponseSerializer();
}

class _$GetPromoByIdSuccessResponseSerializer
    implements PrimitiveSerializer<GetPromoByIdSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    GetPromoByIdSuccessResponse,
    _$GetPromoByIdSuccessResponse
  ];

  @override
  final String wireName = r'GetPromoByIdSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetPromoByIdSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetPromoByIdSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Promo),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetPromoByIdSuccessResponse object, {
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
    required GetPromoByIdSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(GetPromoByIdSuccessResponseSuccessEnum),
          ) as GetPromoByIdSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(Promo),
          ) as Promo;
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
  GetPromoByIdSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetPromoByIdSuccessResponseBuilder();
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

class GetPromoByIdSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const GetPromoByIdSuccessResponseSuccessEnum true_ =
      _$getPromoByIdSuccessResponseSuccessEnum_true_;

  static Serializer<GetPromoByIdSuccessResponseSuccessEnum> get serializer =>
      _$getPromoByIdSuccessResponseSuccessEnumSerializer;

  const GetPromoByIdSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<GetPromoByIdSuccessResponseSuccessEnum> get values =>
      _$getPromoByIdSuccessResponseSuccessEnumValues;
  static GetPromoByIdSuccessResponseSuccessEnum valueOf(String name) =>
      _$getPromoByIdSuccessResponseSuccessEnumValueOf(name);
}
