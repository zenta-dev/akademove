//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/driver.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'driver_list200_response.g.dart';

/// DriverList200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class DriverList200Response implements Built<DriverList200Response, DriverList200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Driver> get data;

  DriverList200Response._();

  factory DriverList200Response([void updates(DriverList200ResponseBuilder b)]) = _$DriverList200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DriverList200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DriverList200Response> get serializer => _$DriverList200ResponseSerializer();
}

class _$DriverList200ResponseSerializer implements PrimitiveSerializer<DriverList200Response> {
  @override
  final Iterable<Type> types = const [DriverList200Response, _$DriverList200Response];

  @override
  final String wireName = r'DriverList200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DriverList200Response object, {
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
      specifiedType: const FullType(BuiltList, [FullType(Driver)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DriverList200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DriverList200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(Driver)]),
          ) as BuiltList<Driver>;
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
  DriverList200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DriverList200ResponseBuilder();
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

