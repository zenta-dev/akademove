//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_user_password_request.g.dart';

/// SetUserPasswordRequest
///
/// Properties:
/// * [newPassword] - The new password
/// * [userId] - The user id
@BuiltValue()
abstract class SetUserPasswordRequest implements Built<SetUserPasswordRequest, SetUserPasswordRequestBuilder> {
  /// The new password
  @BuiltValueField(wireName: r'newPassword')
  String get newPassword;

  /// The user id
  @BuiltValueField(wireName: r'userId')
  String get userId;

  SetUserPasswordRequest._();

  factory SetUserPasswordRequest([void updates(SetUserPasswordRequestBuilder b)]) = _$SetUserPasswordRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetUserPasswordRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetUserPasswordRequest> get serializer => _$SetUserPasswordRequestSerializer();
}

class _$SetUserPasswordRequestSerializer implements PrimitiveSerializer<SetUserPasswordRequest> {
  @override
  final Iterable<Type> types = const [SetUserPasswordRequest, _$SetUserPasswordRequest];

  @override
  final String wireName = r'SetUserPasswordRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetUserPasswordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newPassword';
    yield serializers.serialize(
      object.newPassword,
      specifiedType: const FullType(String),
    );
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SetUserPasswordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SetUserPasswordRequestBuilder result,
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
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SetUserPasswordRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetUserPasswordRequestBuilder();
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

