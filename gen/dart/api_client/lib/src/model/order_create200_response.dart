//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_create200_response.g.dart';

/// OrderCreate200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class OrderCreate200Response implements Built<OrderCreate200Response, OrderCreate200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Order get data;

  OrderCreate200Response._();

  factory OrderCreate200Response([void updates(OrderCreate200ResponseBuilder b)]) = _$OrderCreate200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderCreate200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderCreate200Response> get serializer => _$OrderCreate200ResponseSerializer();
}

class _$OrderCreate200ResponseSerializer implements PrimitiveSerializer<OrderCreate200Response> {
  @override
  final Iterable<Type> types = const [OrderCreate200Response, _$OrderCreate200Response];

  @override
  final String wireName = r'OrderCreate200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderCreate200Response object, {
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
      specifiedType: const FullType(Order),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderCreate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderCreate200ResponseBuilder result,
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
            specifiedType: const FullType(Order),
          ) as Order;
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
  OrderCreate200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderCreate200ResponseBuilder();
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

