//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'revoke_session_post_request.g.dart';

/// RevokeSessionPostRequest
///
/// Properties:
/// * [token] - The token to revoke
@BuiltValue()
abstract class RevokeSessionPostRequest
    implements
        Built<RevokeSessionPostRequest, RevokeSessionPostRequestBuilder> {
  /// The token to revoke
  @BuiltValueField(wireName: r'token')
  String get token;

  RevokeSessionPostRequest._();

  factory RevokeSessionPostRequest(
          [void updates(RevokeSessionPostRequestBuilder b)]) =
      _$RevokeSessionPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RevokeSessionPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RevokeSessionPostRequest> get serializer =>
      _$RevokeSessionPostRequestSerializer();
}

class _$RevokeSessionPostRequestSerializer
    implements PrimitiveSerializer<RevokeSessionPostRequest> {
  @override
  final Iterable<Type> types = const [
    RevokeSessionPostRequest,
    _$RevokeSessionPostRequest
  ];

  @override
  final String wireName = r'RevokeSessionPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RevokeSessionPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RevokeSessionPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RevokeSessionPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RevokeSessionPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RevokeSessionPostRequestBuilder();
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
