//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/merchant.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'merchant_get_mine200_response_body.g.dart';

/// MerchantGetMine200ResponseBody
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class MerchantGetMine200ResponseBody implements Built<MerchantGetMine200ResponseBody, MerchantGetMine200ResponseBodyBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Merchant get data;

  MerchantGetMine200ResponseBody._();

  factory MerchantGetMine200ResponseBody([void updates(MerchantGetMine200ResponseBodyBuilder b)]) = _$MerchantGetMine200ResponseBody;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MerchantGetMine200ResponseBodyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MerchantGetMine200ResponseBody> get serializer => _$MerchantGetMine200ResponseBodySerializer();
}

class _$MerchantGetMine200ResponseBodySerializer implements PrimitiveSerializer<MerchantGetMine200ResponseBody> {
  @override
  final Iterable<Type> types = const [MerchantGetMine200ResponseBody, _$MerchantGetMine200ResponseBody];

  @override
  final String wireName = r'MerchantGetMine200ResponseBody';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MerchantGetMine200ResponseBody object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Merchant),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MerchantGetMine200ResponseBody object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MerchantGetMine200ResponseBodyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(Merchant),
          ) as Merchant;
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
  MerchantGetMine200ResponseBody deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MerchantGetMine200ResponseBodyBuilder();
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

