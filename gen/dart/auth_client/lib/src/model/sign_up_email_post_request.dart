//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sign_up_email_post_request.g.dart';

/// SignUpEmailPostRequest
///
/// Properties:
/// * [name] - The name of the user
/// * [email] - The email of the user
/// * [password] - The password of the user
/// * [image] - The profile image URL of the user
/// * [callbackURL] - The URL to use for email verification callback
/// * [rememberMe] - If this is false, the session will not be remembered. Default is `true`.
@BuiltValue()
abstract class SignUpEmailPostRequest implements Built<SignUpEmailPostRequest, SignUpEmailPostRequestBuilder> {
  /// The name of the user
  @BuiltValueField(wireName: r'name')
  String get name;

  /// The email of the user
  @BuiltValueField(wireName: r'email')
  String get email;

  /// The password of the user
  @BuiltValueField(wireName: r'password')
  String get password;

  /// The profile image URL of the user
  @BuiltValueField(wireName: r'image')
  String? get image;

  /// The URL to use for email verification callback
  @BuiltValueField(wireName: r'callbackURL')
  String? get callbackURL;

  /// If this is false, the session will not be remembered. Default is `true`.
  @BuiltValueField(wireName: r'rememberMe')
  bool? get rememberMe;

  SignUpEmailPostRequest._();

  factory SignUpEmailPostRequest([void updates(SignUpEmailPostRequestBuilder b)]) = _$SignUpEmailPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignUpEmailPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignUpEmailPostRequest> get serializer => _$SignUpEmailPostRequestSerializer();
}

class _$SignUpEmailPostRequestSerializer implements PrimitiveSerializer<SignUpEmailPostRequest> {
  @override
  final Iterable<Type> types = const [SignUpEmailPostRequest, _$SignUpEmailPostRequest];

  @override
  final String wireName = r'SignUpEmailPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignUpEmailPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
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
    if (object.image != null) {
      yield r'image';
      yield serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      );
    }
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
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SignUpEmailPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SignUpEmailPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
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
        case r'image':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.image = valueDes;
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
            specifiedType: const FullType(bool),
          ) as bool;
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
  SignUpEmailPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignUpEmailPostRequestBuilder();
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

