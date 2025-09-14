//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'revoke_other_sessions_post200_response.g.dart';

/// RevokeOtherSessionsPost200Response
///
/// Properties:
/// * [status] - Indicates if all other sessions were revoked successfully
@BuiltValue()
abstract class RevokeOtherSessionsPost200Response
    implements
        Built<RevokeOtherSessionsPost200Response,
            RevokeOtherSessionsPost200ResponseBuilder> {
  /// Indicates if all other sessions were revoked successfully
  @BuiltValueField(wireName: r'status')
  bool get status;

  RevokeOtherSessionsPost200Response._();

  factory RevokeOtherSessionsPost200Response(
          [void updates(RevokeOtherSessionsPost200ResponseBuilder b)]) =
      _$RevokeOtherSessionsPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RevokeOtherSessionsPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RevokeOtherSessionsPost200Response> get serializer =>
      _$RevokeOtherSessionsPost200ResponseSerializer();
}

class _$RevokeOtherSessionsPost200ResponseSerializer
    implements PrimitiveSerializer<RevokeOtherSessionsPost200Response> {
  @override
  final Iterable<Type> types = const [
    RevokeOtherSessionsPost200Response,
    _$RevokeOtherSessionsPost200Response
  ];

  @override
  final String wireName = r'RevokeOtherSessionsPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RevokeOtherSessionsPost200Response object, {
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
    RevokeOtherSessionsPost200Response object, {
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
    required RevokeOtherSessionsPost200ResponseBuilder result,
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
  RevokeOtherSessionsPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RevokeOtherSessionsPost200ResponseBuilder();
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
