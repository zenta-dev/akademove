//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/merchant_menu.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'merchant_menu_list200_response.g.dart';

/// MerchantMenuList200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class MerchantMenuList200Response implements Built<MerchantMenuList200Response, MerchantMenuList200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<MerchantMenu> get data;

  MerchantMenuList200Response._();

  factory MerchantMenuList200Response([void updates(MerchantMenuList200ResponseBuilder b)]) = _$MerchantMenuList200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MerchantMenuList200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MerchantMenuList200Response> get serializer => _$MerchantMenuList200ResponseSerializer();
}

class _$MerchantMenuList200ResponseSerializer implements PrimitiveSerializer<MerchantMenuList200Response> {
  @override
  final Iterable<Type> types = const [MerchantMenuList200Response, _$MerchantMenuList200Response];

  @override
  final String wireName = r'MerchantMenuList200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MerchantMenuList200Response object, {
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
      specifiedType: const FullType(BuiltList, [FullType(MerchantMenu)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MerchantMenuList200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MerchantMenuList200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(MerchantMenu)]),
          ) as BuiltList<MerchantMenu>;
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
  MerchantMenuList200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MerchantMenuList200ResponseBuilder();
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

