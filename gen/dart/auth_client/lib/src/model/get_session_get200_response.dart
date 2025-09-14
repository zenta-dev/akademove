//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:auth_client/src/model/user.dart';
import 'package:auth_client/src/model/session.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_session_get200_response.g.dart';

/// GetSessionGet200Response
///
/// Properties:
/// * [session] 
/// * [user] 
@BuiltValue()
abstract class GetSessionGet200Response implements Built<GetSessionGet200Response, GetSessionGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'session')
  Session get session;

  @BuiltValueField(wireName: r'user')
  User get user;

  GetSessionGet200Response._();

  factory GetSessionGet200Response([void updates(GetSessionGet200ResponseBuilder b)]) = _$GetSessionGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetSessionGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetSessionGet200Response> get serializer => _$GetSessionGet200ResponseSerializer();
}

class _$GetSessionGet200ResponseSerializer implements PrimitiveSerializer<GetSessionGet200Response> {
  @override
  final Iterable<Type> types = const [GetSessionGet200Response, _$GetSessionGet200Response];

  @override
  final String wireName = r'GetSessionGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetSessionGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'session';
    yield serializers.serialize(
      object.session,
      specifiedType: const FullType(Session),
    );
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(User),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetSessionGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetSessionGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'session':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Session),
          ) as Session;
          result.session.replace(valueDes);
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(User),
          ) as User;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetSessionGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetSessionGet200ResponseBuilder();
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

