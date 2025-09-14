//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'forget_password_post_request.g.dart';

/// ForgetPasswordPostRequest
///
/// Properties:
/// * [email] - The email address of the user to send a password reset email to
/// * [redirectTo] - The URL to redirect the user to reset their password. If the token isn't valid or expired, it'll be redirected with a query parameter `?error=INVALID_TOKEN`. If the token is valid, it'll be redirected with a query parameter `?token=VALID_TOKEN
@BuiltValue()
abstract class ForgetPasswordPostRequest implements Built<ForgetPasswordPostRequest, ForgetPasswordPostRequestBuilder> {
  /// The email address of the user to send a password reset email to
  @BuiltValueField(wireName: r'email')
  String get email;

  /// The URL to redirect the user to reset their password. If the token isn't valid or expired, it'll be redirected with a query parameter `?error=INVALID_TOKEN`. If the token is valid, it'll be redirected with a query parameter `?token=VALID_TOKEN
  @BuiltValueField(wireName: r'redirectTo')
  String? get redirectTo;

  ForgetPasswordPostRequest._();

  factory ForgetPasswordPostRequest([void updates(ForgetPasswordPostRequestBuilder b)]) = _$ForgetPasswordPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ForgetPasswordPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ForgetPasswordPostRequest> get serializer => _$ForgetPasswordPostRequestSerializer();
}

class _$ForgetPasswordPostRequestSerializer implements PrimitiveSerializer<ForgetPasswordPostRequest> {
  @override
  final Iterable<Type> types = const [ForgetPasswordPostRequest, _$ForgetPasswordPostRequest];

  @override
  final String wireName = r'ForgetPasswordPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ForgetPasswordPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    if (object.redirectTo != null) {
      yield r'redirectTo';
      yield serializers.serialize(
        object.redirectTo,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ForgetPasswordPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ForgetPasswordPostRequestBuilder result,
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
        case r'redirectTo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.redirectTo = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ForgetPasswordPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ForgetPasswordPostRequestBuilder();
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

