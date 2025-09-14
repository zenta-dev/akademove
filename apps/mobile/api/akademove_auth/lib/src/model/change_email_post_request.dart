//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_email_post_request.g.dart';

/// ChangeEmailPostRequest
///
/// Properties:
/// * [newEmail] - The new email address to set must be a valid email address
/// * [callbackURL] - The URL to redirect to after email verification
@BuiltValue()
abstract class ChangeEmailPostRequest
    implements Built<ChangeEmailPostRequest, ChangeEmailPostRequestBuilder> {
  /// The new email address to set must be a valid email address
  @BuiltValueField(wireName: r'newEmail')
  String get newEmail;

  /// The URL to redirect to after email verification
  @BuiltValueField(wireName: r'callbackURL')
  String? get callbackURL;

  ChangeEmailPostRequest._();

  factory ChangeEmailPostRequest(
          [void updates(ChangeEmailPostRequestBuilder b)]) =
      _$ChangeEmailPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangeEmailPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangeEmailPostRequest> get serializer =>
      _$ChangeEmailPostRequestSerializer();
}

class _$ChangeEmailPostRequestSerializer
    implements PrimitiveSerializer<ChangeEmailPostRequest> {
  @override
  final Iterable<Type> types = const [
    ChangeEmailPostRequest,
    _$ChangeEmailPostRequest
  ];

  @override
  final String wireName = r'ChangeEmailPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangeEmailPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newEmail';
    yield serializers.serialize(
      object.newEmail,
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
    ChangeEmailPostRequest object, {
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
    required ChangeEmailPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'newEmail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newEmail = valueDes;
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
  ChangeEmailPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangeEmailPostRequestBuilder();
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
