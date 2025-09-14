//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:akademove_auth/src/model/sign_up_email_post200_response_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sign_up_email_post200_response.g.dart';

/// SignUpEmailPost200Response
///
/// Properties:
/// * [user]
/// * [token] - Authentication token for the session
@BuiltValue()
abstract class SignUpEmailPost200Response
    implements
        Built<SignUpEmailPost200Response, SignUpEmailPost200ResponseBuilder> {
  @BuiltValueField(wireName: r'user')
  SignUpEmailPost200ResponseUser get user;

  /// Authentication token for the session
  @BuiltValueField(wireName: r'token')
  String? get token;

  SignUpEmailPost200Response._();

  factory SignUpEmailPost200Response(
          [void updates(SignUpEmailPost200ResponseBuilder b)]) =
      _$SignUpEmailPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignUpEmailPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignUpEmailPost200Response> get serializer =>
      _$SignUpEmailPost200ResponseSerializer();
}

class _$SignUpEmailPost200ResponseSerializer
    implements PrimitiveSerializer<SignUpEmailPost200Response> {
  @override
  final Iterable<Type> types = const [
    SignUpEmailPost200Response,
    _$SignUpEmailPost200Response
  ];

  @override
  final String wireName = r'SignUpEmailPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignUpEmailPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(SignUpEmailPost200ResponseUser),
    );
    if (object.token != null) {
      yield r'token';
      yield serializers.serialize(
        object.token,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SignUpEmailPost200Response object, {
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
    required SignUpEmailPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SignUpEmailPost200ResponseUser),
          ) as SignUpEmailPost200ResponseUser;
          result.user.replace(valueDes);
          break;
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
  SignUpEmailPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignUpEmailPost200ResponseBuilder();
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
