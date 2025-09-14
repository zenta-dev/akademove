//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'revoke_session_post200_response.g.dart';

/// RevokeSessionPost200Response
///
/// Properties:
/// * [status] - Indicates if the session was revoked successfully
@BuiltValue()
abstract class RevokeSessionPost200Response implements Built<RevokeSessionPost200Response, RevokeSessionPost200ResponseBuilder> {
  /// Indicates if the session was revoked successfully
  @BuiltValueField(wireName: r'status')
  bool get status;

  RevokeSessionPost200Response._();

  factory RevokeSessionPost200Response([void updates(RevokeSessionPost200ResponseBuilder b)]) = _$RevokeSessionPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RevokeSessionPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RevokeSessionPost200Response> get serializer => _$RevokeSessionPost200ResponseSerializer();
}

class _$RevokeSessionPost200ResponseSerializer implements PrimitiveSerializer<RevokeSessionPost200Response> {
  @override
  final Iterable<Type> types = const [RevokeSessionPost200Response, _$RevokeSessionPost200Response];

  @override
  final String wireName = r'RevokeSessionPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RevokeSessionPost200Response object, {
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
    RevokeSessionPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RevokeSessionPost200ResponseBuilder result,
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
  RevokeSessionPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RevokeSessionPost200ResponseBuilder();
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

