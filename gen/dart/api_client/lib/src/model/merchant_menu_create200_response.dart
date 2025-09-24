//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/merchant_menu.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'merchant_menu_create200_response.g.dart';

/// MerchantMenuCreate200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class MerchantMenuCreate200Response implements Built<MerchantMenuCreate200Response, MerchantMenuCreate200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  MerchantMenu get data;

  MerchantMenuCreate200Response._();

  factory MerchantMenuCreate200Response([void updates(MerchantMenuCreate200ResponseBuilder b)]) = _$MerchantMenuCreate200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MerchantMenuCreate200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MerchantMenuCreate200Response> get serializer => _$MerchantMenuCreate200ResponseSerializer();
}

class _$MerchantMenuCreate200ResponseSerializer implements PrimitiveSerializer<MerchantMenuCreate200Response> {
  @override
  final Iterable<Type> types = const [MerchantMenuCreate200Response, _$MerchantMenuCreate200Response];

  @override
  final String wireName = r'MerchantMenuCreate200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MerchantMenuCreate200Response object, {
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
      specifiedType: const FullType(MerchantMenu),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MerchantMenuCreate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MerchantMenuCreate200ResponseBuilder result,
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
            specifiedType: const FullType(MerchantMenu),
          ) as MerchantMenu;
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
  MerchantMenuCreate200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MerchantMenuCreate200ResponseBuilder();
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

