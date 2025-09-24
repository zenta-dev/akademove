//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/merchant_get_mine200_response_body.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'merchant_get_mine200_response.g.dart';

/// MerchantGetMine200Response
///
/// Properties:
/// * [status] 
/// * [body] 
@BuiltValue()
abstract class MerchantGetMine200Response implements Built<MerchantGetMine200Response, MerchantGetMine200ResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  JsonObject? get status;

  @BuiltValueField(wireName: r'body')
  MerchantGetMine200ResponseBody get body;

  MerchantGetMine200Response._();

  factory MerchantGetMine200Response([void updates(MerchantGetMine200ResponseBuilder b)]) = _$MerchantGetMine200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MerchantGetMine200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MerchantGetMine200Response> get serializer => _$MerchantGetMine200ResponseSerializer();
}

class _$MerchantGetMine200ResponseSerializer implements PrimitiveSerializer<MerchantGetMine200Response> {
  @override
  final Iterable<Type> types = const [MerchantGetMine200Response, _$MerchantGetMine200Response];

  @override
  final String wireName = r'MerchantGetMine200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MerchantGetMine200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield object.status == null ? null : serializers.serialize(
      object.status,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(MerchantGetMine200ResponseBody),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MerchantGetMine200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MerchantGetMine200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MerchantGetMine200ResponseBody),
          ) as MerchantGetMine200ResponseBody;
          result.body.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MerchantGetMine200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MerchantGetMine200ResponseBuilder();
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

