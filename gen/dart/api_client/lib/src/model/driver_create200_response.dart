//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'driver_create200_response.g.dart';

/// DriverCreate200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class DriverCreate200Response implements Built<DriverCreate200Response, DriverCreate200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Driver get data;

  DriverCreate200Response._();

  factory DriverCreate200Response([void updates(DriverCreate200ResponseBuilder b)]) = _$DriverCreate200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DriverCreate200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DriverCreate200Response> get serializer => _$DriverCreate200ResponseSerializer();
}

class _$DriverCreate200ResponseSerializer implements PrimitiveSerializer<DriverCreate200Response> {
  @override
  final Iterable<Type> types = const [DriverCreate200Response, _$DriverCreate200Response];

  @override
  final String wireName = r'DriverCreate200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DriverCreate200Response object, {
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
      specifiedType: const FullType(Driver),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DriverCreate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DriverCreate200ResponseBuilder result,
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
            specifiedType: const FullType(Driver),
          ) as Driver;
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
  DriverCreate200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DriverCreate200ResponseBuilder();
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

