//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'driver_remove200_response.g.dart';

/// DriverRemove200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class DriverRemove200Response implements Built<DriverRemove200Response, DriverRemove200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  JsonObject? get data;

  DriverRemove200Response._();

  factory DriverRemove200Response([void updates(DriverRemove200ResponseBuilder b)]) = _$DriverRemove200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DriverRemove200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DriverRemove200Response> get serializer => _$DriverRemove200ResponseSerializer();
}

class _$DriverRemove200ResponseSerializer implements PrimitiveSerializer<DriverRemove200Response> {
  @override
  final Iterable<Type> types = const [DriverRemove200Response, _$DriverRemove200Response];

  @override
  final String wireName = r'DriverRemove200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DriverRemove200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield object.data == null ? null : serializers.serialize(
      object.data,
      specifiedType: const FullType.nullable(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DriverRemove200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DriverRemove200ResponseBuilder result,
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
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.data = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DriverRemove200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DriverRemove200ResponseBuilder();
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

