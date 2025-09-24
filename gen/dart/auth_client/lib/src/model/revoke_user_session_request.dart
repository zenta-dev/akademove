//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'revoke_user_session_request.g.dart';

/// RevokeUserSessionRequest
///
/// Properties:
/// * [sessionToken] - The session token
@BuiltValue()
abstract class RevokeUserSessionRequest implements Built<RevokeUserSessionRequest, RevokeUserSessionRequestBuilder> {
  /// The session token
  @BuiltValueField(wireName: r'sessionToken')
  String get sessionToken;

  RevokeUserSessionRequest._();

  factory RevokeUserSessionRequest([void updates(RevokeUserSessionRequestBuilder b)]) = _$RevokeUserSessionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RevokeUserSessionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RevokeUserSessionRequest> get serializer => _$RevokeUserSessionRequestSerializer();
}

class _$RevokeUserSessionRequestSerializer implements PrimitiveSerializer<RevokeUserSessionRequest> {
  @override
  final Iterable<Type> types = const [RevokeUserSessionRequest, _$RevokeUserSessionRequest];

  @override
  final String wireName = r'RevokeUserSessionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RevokeUserSessionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'sessionToken';
    yield serializers.serialize(
      object.sessionToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RevokeUserSessionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RevokeUserSessionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sessionToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sessionToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RevokeUserSessionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RevokeUserSessionRequestBuilder();
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

