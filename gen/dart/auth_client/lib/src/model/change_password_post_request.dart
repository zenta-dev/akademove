//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_password_post_request.g.dart';

/// ChangePasswordPostRequest
///
/// Properties:
/// * [newPassword] - The new password to set
/// * [currentPassword] - The current password is required
/// * [revokeOtherSessions] - Must be a boolean value
@BuiltValue()
abstract class ChangePasswordPostRequest implements Built<ChangePasswordPostRequest, ChangePasswordPostRequestBuilder> {
  /// The new password to set
  @BuiltValueField(wireName: r'newPassword')
  String get newPassword;

  /// The current password is required
  @BuiltValueField(wireName: r'currentPassword')
  String get currentPassword;

  /// Must be a boolean value
  @BuiltValueField(wireName: r'revokeOtherSessions')
  bool? get revokeOtherSessions;

  ChangePasswordPostRequest._();

  factory ChangePasswordPostRequest([void updates(ChangePasswordPostRequestBuilder b)]) = _$ChangePasswordPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangePasswordPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangePasswordPostRequest> get serializer => _$ChangePasswordPostRequestSerializer();
}

class _$ChangePasswordPostRequestSerializer implements PrimitiveSerializer<ChangePasswordPostRequest> {
  @override
  final Iterable<Type> types = const [ChangePasswordPostRequest, _$ChangePasswordPostRequest];

  @override
  final String wireName = r'ChangePasswordPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangePasswordPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newPassword';
    yield serializers.serialize(
      object.newPassword,
      specifiedType: const FullType(String),
    );
    yield r'currentPassword';
    yield serializers.serialize(
      object.currentPassword,
      specifiedType: const FullType(String),
    );
    if (object.revokeOtherSessions != null) {
      yield r'revokeOtherSessions';
      yield serializers.serialize(
        object.revokeOtherSessions,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChangePasswordPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChangePasswordPostRequestBuilder result,
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
        case r'currentPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currentPassword = valueDes;
          break;
        case r'revokeOtherSessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.revokeOtherSessions = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChangePasswordPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangePasswordPostRequestBuilder();
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

