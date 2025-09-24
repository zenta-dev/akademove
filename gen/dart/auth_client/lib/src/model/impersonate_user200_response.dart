//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:auth_client/src/model/user.dart';
import 'package:auth_client/src/model/session.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'impersonate_user200_response.g.dart';

/// ImpersonateUser200Response
///
/// Properties:
/// * [session] 
/// * [user] 
@BuiltValue()
abstract class ImpersonateUser200Response implements Built<ImpersonateUser200Response, ImpersonateUser200ResponseBuilder> {
  @BuiltValueField(wireName: r'session')
  Session? get session;

  @BuiltValueField(wireName: r'user')
  User? get user;

  ImpersonateUser200Response._();

  factory ImpersonateUser200Response([void updates(ImpersonateUser200ResponseBuilder b)]) = _$ImpersonateUser200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ImpersonateUser200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ImpersonateUser200Response> get serializer => _$ImpersonateUser200ResponseSerializer();
}

class _$ImpersonateUser200ResponseSerializer implements PrimitiveSerializer<ImpersonateUser200Response> {
  @override
  final Iterable<Type> types = const [ImpersonateUser200Response, _$ImpersonateUser200Response];

  @override
  final String wireName = r'ImpersonateUser200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ImpersonateUser200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.session != null) {
      yield r'session';
      yield serializers.serialize(
        object.session,
        specifiedType: const FullType(Session),
      );
    }
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(User),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ImpersonateUser200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ImpersonateUser200ResponseBuilder result,
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
  ImpersonateUser200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ImpersonateUser200ResponseBuilder();
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

