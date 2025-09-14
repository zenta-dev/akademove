//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_verification_email_post_request.g.dart';

/// SendVerificationEmailPostRequest
///
/// Properties:
/// * [email] - The email to send the verification email to
/// * [callbackURL] - The URL to use for email verification callback
@BuiltValue()
abstract class SendVerificationEmailPostRequest
    implements
        Built<SendVerificationEmailPostRequest,
            SendVerificationEmailPostRequestBuilder> {
  /// The email to send the verification email to
  @BuiltValueField(wireName: r'email')
  String get email;

  /// The URL to use for email verification callback
  @BuiltValueField(wireName: r'callbackURL')
  String? get callbackURL;

  SendVerificationEmailPostRequest._();

  factory SendVerificationEmailPostRequest(
          [void updates(SendVerificationEmailPostRequestBuilder b)]) =
      _$SendVerificationEmailPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendVerificationEmailPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendVerificationEmailPostRequest> get serializer =>
      _$SendVerificationEmailPostRequestSerializer();
}

class _$SendVerificationEmailPostRequestSerializer
    implements PrimitiveSerializer<SendVerificationEmailPostRequest> {
  @override
  final Iterable<Type> types = const [
    SendVerificationEmailPostRequest,
    _$SendVerificationEmailPostRequest
  ];

  @override
  final String wireName = r'SendVerificationEmailPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendVerificationEmailPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    if (object.callbackURL != null) {
      yield r'callbackURL';
      yield serializers.serialize(
        object.callbackURL,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SendVerificationEmailPostRequest object, {
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
    required SendVerificationEmailPostRequestBuilder result,
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
        case r'callbackURL':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.callbackURL = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendVerificationEmailPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendVerificationEmailPostRequestBuilder();
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
