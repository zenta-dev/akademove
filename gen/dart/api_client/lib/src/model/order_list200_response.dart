//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_list200_response.g.dart';

/// OrderList200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class OrderList200Response implements Built<OrderList200Response, OrderList200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Order> get data;

  OrderList200Response._();

  factory OrderList200Response([void updates(OrderList200ResponseBuilder b)]) = _$OrderList200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderList200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderList200Response> get serializer => _$OrderList200ResponseSerializer();
}

class _$OrderList200ResponseSerializer implements PrimitiveSerializer<OrderList200Response> {
  @override
  final Iterable<Type> types = const [OrderList200Response, _$OrderList200Response];

  @override
  final String wireName = r'OrderList200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderList200Response object, {
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
      specifiedType: const FullType(BuiltList, [FullType(Order)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderList200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderList200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(Order)]),
          ) as BuiltList<Order>;
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
  OrderList200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderList200ResponseBuilder();
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

