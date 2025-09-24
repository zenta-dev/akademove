//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unban_user_schema_request.g.dart';

/// UnbanUserSchemaRequest
///
/// Properties:
/// * [id] 
@BuiltValue()
abstract class UnbanUserSchemaRequest implements Built<UnbanUserSchemaRequest, UnbanUserSchemaRequestBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  UnbanUserSchemaRequest._();

  factory UnbanUserSchemaRequest([void updates(UnbanUserSchemaRequestBuilder b)]) = _$UnbanUserSchemaRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnbanUserSchemaRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnbanUserSchemaRequest> get serializer => _$UnbanUserSchemaRequestSerializer();
}

class _$UnbanUserSchemaRequestSerializer implements PrimitiveSerializer<UnbanUserSchemaRequest> {
  @override
  final Iterable<Type> types = const [UnbanUserSchemaRequest, _$UnbanUserSchemaRequest];

  @override
  final String wireName = r'UnbanUserSchemaRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnbanUserSchemaRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UnbanUserSchemaRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnbanUserSchemaRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UnbanUserSchemaRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnbanUserSchemaRequestBuilder();
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

