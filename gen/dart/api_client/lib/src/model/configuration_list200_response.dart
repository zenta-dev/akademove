//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/configuration.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'configuration_list200_response.g.dart';

/// ConfigurationList200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ConfigurationList200Response implements Built<ConfigurationList200Response, ConfigurationList200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Configuration> get data;

  ConfigurationList200Response._();

  factory ConfigurationList200Response([void updates(ConfigurationList200ResponseBuilder b)]) = _$ConfigurationList200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfigurationList200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfigurationList200Response> get serializer => _$ConfigurationList200ResponseSerializer();
}

class _$ConfigurationList200ResponseSerializer implements PrimitiveSerializer<ConfigurationList200Response> {
  @override
  final Iterable<Type> types = const [ConfigurationList200Response, _$ConfigurationList200Response];

  @override
  final String wireName = r'ConfigurationList200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfigurationList200Response object, {
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
      specifiedType: const FullType(BuiltList, [FullType(Configuration)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ConfigurationList200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ConfigurationList200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(Configuration)]),
          ) as BuiltList<Configuration>;
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
  ConfigurationList200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfigurationList200ResponseBuilder();
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

