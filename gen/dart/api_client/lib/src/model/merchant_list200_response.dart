//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/merchant.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'merchant_list200_response.g.dart';

/// MerchantList200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class MerchantList200Response implements Built<MerchantList200Response, MerchantList200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Merchant> get data;

  MerchantList200Response._();

  factory MerchantList200Response([void updates(MerchantList200ResponseBuilder b)]) = _$MerchantList200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MerchantList200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MerchantList200Response> get serializer => _$MerchantList200ResponseSerializer();
}

class _$MerchantList200ResponseSerializer implements PrimitiveSerializer<MerchantList200Response> {
  @override
  final Iterable<Type> types = const [MerchantList200Response, _$MerchantList200Response];

  @override
  final String wireName = r'MerchantList200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MerchantList200Response object, {
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
      specifiedType: const FullType(BuiltList, [FullType(Merchant)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MerchantList200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MerchantList200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(Merchant)]),
          ) as BuiltList<Merchant>;
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
  MerchantList200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MerchantList200ResponseBuilder();
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

