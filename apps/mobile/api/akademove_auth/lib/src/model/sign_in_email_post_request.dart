//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sign_in_email_post_request.g.dart';

/// SignInEmailPostRequest
///
/// Properties:
/// * [email] - Email of the user
/// * [password] - Password of the user
/// * [callbackURL] - Callback URL to use as a redirect for email verification
/// * [rememberMe]
@BuiltValue()
abstract class SignInEmailPostRequest
    implements Built<SignInEmailPostRequest, SignInEmailPostRequestBuilder> {
  /// Email of the user
  @BuiltValueField(wireName: r'email')
  String get email;

  /// Password of the user
  @BuiltValueField(wireName: r'password')
  String get password;

  /// Callback URL to use as a redirect for email verification
  @BuiltValueField(wireName: r'callbackURL')
  String? get callbackURL;

  @BuiltValueField(wireName: r'rememberMe')
  String? get rememberMe;

  SignInEmailPostRequest._();

  factory SignInEmailPostRequest(
          [void updates(SignInEmailPostRequestBuilder b)]) =
      _$SignInEmailPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignInEmailPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignInEmailPostRequest> get serializer =>
      _$SignInEmailPostRequestSerializer();
}

class _$SignInEmailPostRequestSerializer
    implements PrimitiveSerializer<SignInEmailPostRequest> {
  @override
  final Iterable<Type> types = const [
    SignInEmailPostRequest,
    _$SignInEmailPostRequest
  ];

  @override
  final String wireName = r'SignInEmailPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignInEmailPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    if (object.callbackURL != null) {
      yield r'callbackURL';
      yield serializers.serialize(
        object.callbackURL,
        specifiedType: const FullType(String),
      );
    }
    if (object.rememberMe != null) {
      yield r'rememberMe';
      yield serializers.serialize(
        object.rememberMe,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SignInEmailPostRequest object, {
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
    required SignInEmailPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'callbackURL':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.callbackURL = valueDes;
          break;
        case r'rememberMe':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rememberMe = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SignInEmailPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignInEmailPostRequestBuilder();
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
