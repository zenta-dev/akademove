//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/configuration.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'configuration_get200_response.g.dart';

/// ConfigurationGet200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ConfigurationGet200Response implements Built<ConfigurationGet200Response, ConfigurationGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Configuration get data;

  ConfigurationGet200Response._();

  factory ConfigurationGet200Response([void updates(ConfigurationGet200ResponseBuilder b)]) = _$ConfigurationGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfigurationGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfigurationGet200Response> get serializer => _$ConfigurationGet200ResponseSerializer();
}

class _$ConfigurationGet200ResponseSerializer implements PrimitiveSerializer<ConfigurationGet200Response> {
  @override
  final Iterable<Type> types = const [ConfigurationGet200Response, _$ConfigurationGet200Response];

  @override
  final String wireName = r'ConfigurationGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfigurationGet200Response object, {
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
      specifiedType: const FullType(Configuration),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ConfigurationGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ConfigurationGet200ResponseBuilder result,
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
            specifiedType: const FullType(Configuration),
          ) as Configuration;
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
  ConfigurationGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfigurationGet200ResponseBuilder();
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

