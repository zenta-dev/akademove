//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:auth_client/src/model/session.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_user_sessions200_response.g.dart';

/// ListUserSessions200Response
///
/// Properties:
/// * [sessions] 
@BuiltValue()
abstract class ListUserSessions200Response implements Built<ListUserSessions200Response, ListUserSessions200ResponseBuilder> {
  @BuiltValueField(wireName: r'sessions')
  BuiltList<Session>? get sessions;

  ListUserSessions200Response._();

  factory ListUserSessions200Response([void updates(ListUserSessions200ResponseBuilder b)]) = _$ListUserSessions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListUserSessions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListUserSessions200Response> get serializer => _$ListUserSessions200ResponseSerializer();
}

class _$ListUserSessions200ResponseSerializer implements PrimitiveSerializer<ListUserSessions200Response> {
  @override
  final Iterable<Type> types = const [ListUserSessions200Response, _$ListUserSessions200Response];

  @override
  final String wireName = r'ListUserSessions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListUserSessions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.sessions != null) {
      yield r'sessions';
      yield serializers.serialize(
        object.sessions,
        specifiedType: const FullType(BuiltList, [FullType(Session)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ListUserSessions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListUserSessions200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Session)]),
          ) as BuiltList<Session>;
          result.sessions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ListUserSessions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListUserSessions200ResponseBuilder();
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

