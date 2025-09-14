//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'revoke_sessions_post200_response.g.dart';

/// RevokeSessionsPost200Response
///
/// Properties:
/// * [status] - Indicates if all sessions were revoked successfully
@BuiltValue()
abstract class RevokeSessionsPost200Response implements Built<RevokeSessionsPost200Response, RevokeSessionsPost200ResponseBuilder> {
  /// Indicates if all sessions were revoked successfully
  @BuiltValueField(wireName: r'status')
  bool get status;

  RevokeSessionsPost200Response._();

  factory RevokeSessionsPost200Response([void updates(RevokeSessionsPost200ResponseBuilder b)]) = _$RevokeSessionsPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RevokeSessionsPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RevokeSessionsPost200Response> get serializer => _$RevokeSessionsPost200ResponseSerializer();
}

class _$RevokeSessionsPost200ResponseSerializer implements PrimitiveSerializer<RevokeSessionsPost200Response> {
  @override
  final Iterable<Type> types = const [RevokeSessionsPost200Response, _$RevokeSessionsPost200Response];

  @override
  final String wireName = r'RevokeSessionsPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RevokeSessionsPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RevokeSessionsPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RevokeSessionsPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RevokeSessionsPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RevokeSessionsPost200ResponseBuilder();
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

