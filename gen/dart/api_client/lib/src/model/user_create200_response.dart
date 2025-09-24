//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_create200_response.g.dart';

/// UserCreate200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class UserCreate200Response implements Built<UserCreate200Response, UserCreate200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  User get data;

  UserCreate200Response._();

  factory UserCreate200Response([void updates(UserCreate200ResponseBuilder b)]) = _$UserCreate200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserCreate200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserCreate200Response> get serializer => _$UserCreate200ResponseSerializer();
}

class _$UserCreate200ResponseSerializer implements PrimitiveSerializer<UserCreate200Response> {
  @override
  final Iterable<Type> types = const [UserCreate200Response, _$UserCreate200Response];

  @override
  final String wireName = r'UserCreate200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserCreate200Response object, {
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
      specifiedType: const FullType(User),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserCreate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserCreate200ResponseBuilder result,
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
            specifiedType: const FullType(User),
          ) as User;
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
  UserCreate200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserCreate200ResponseBuilder();
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

