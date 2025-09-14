//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reset_password_post_request.g.dart';

/// ResetPasswordPostRequest
///
/// Properties:
/// * [newPassword] - The new password to set
/// * [token] - The token to reset the password
@BuiltValue()
abstract class ResetPasswordPostRequest
    implements
        Built<ResetPasswordPostRequest, ResetPasswordPostRequestBuilder> {
  /// The new password to set
  @BuiltValueField(wireName: r'newPassword')
  String get newPassword;

  /// The token to reset the password
  @BuiltValueField(wireName: r'token')
  String? get token;

  ResetPasswordPostRequest._();

  factory ResetPasswordPostRequest(
          [void updates(ResetPasswordPostRequestBuilder b)]) =
      _$ResetPasswordPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResetPasswordPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResetPasswordPostRequest> get serializer =>
      _$ResetPasswordPostRequestSerializer();
}

class _$ResetPasswordPostRequestSerializer
    implements PrimitiveSerializer<ResetPasswordPostRequest> {
  @override
  final Iterable<Type> types = const [
    ResetPasswordPostRequest,
    _$ResetPasswordPostRequest
  ];

  @override
  final String wireName = r'ResetPasswordPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResetPasswordPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newPassword';
    yield serializers.serialize(
      object.newPassword,
      specifiedType: const FullType(String),
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
    ResetPasswordPostRequest object, {
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
    required ResetPasswordPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'newPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newPassword = valueDes;
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
  ResetPasswordPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResetPasswordPostRequestBuilder();
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
