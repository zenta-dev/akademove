//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verify_email_get200_response_user.g.dart';

/// VerifyEmailGet200ResponseUser
///
/// Properties:
/// * [id] - User ID
/// * [email] - User email
/// * [name] - User name
/// * [image] - User image URL
/// * [emailVerified] - Indicates if the user email is verified
/// * [createdAt] - User creation date
/// * [updatedAt] - User update date
@BuiltValue()
abstract class VerifyEmailGet200ResponseUser
    implements
        Built<VerifyEmailGet200ResponseUser,
            VerifyEmailGet200ResponseUserBuilder> {
  /// User ID
  @BuiltValueField(wireName: r'id')
  String get id;

  /// User email
  @BuiltValueField(wireName: r'email')
  String get email;

  /// User name
  @BuiltValueField(wireName: r'name')
  String get name;

  /// User image URL
  @BuiltValueField(wireName: r'image')
  String get image;

  /// Indicates if the user email is verified
  @BuiltValueField(wireName: r'emailVerified')
  bool get emailVerified;

  /// User creation date
  @BuiltValueField(wireName: r'createdAt')
  String get createdAt;

  /// User update date
  @BuiltValueField(wireName: r'updatedAt')
  String get updatedAt;

  VerifyEmailGet200ResponseUser._();

  factory VerifyEmailGet200ResponseUser(
          [void updates(VerifyEmailGet200ResponseUserBuilder b)]) =
      _$VerifyEmailGet200ResponseUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VerifyEmailGet200ResponseUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VerifyEmailGet200ResponseUser> get serializer =>
      _$VerifyEmailGet200ResponseUserSerializer();
}

class _$VerifyEmailGet200ResponseUserSerializer
    implements PrimitiveSerializer<VerifyEmailGet200ResponseUser> {
  @override
  final Iterable<Type> types = const [
    VerifyEmailGet200ResponseUser,
    _$VerifyEmailGet200ResponseUser
  ];

  @override
  final String wireName = r'VerifyEmailGet200ResponseUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VerifyEmailGet200ResponseUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'image';
    yield serializers.serialize(
      object.image,
      specifiedType: const FullType(String),
    );
    yield r'emailVerified';
    yield serializers.serialize(
      object.emailVerified,
      specifiedType: const FullType(bool),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(String),
    );
    yield r'updatedAt';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    VerifyEmailGet200ResponseUser object, {
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
    required VerifyEmailGet200ResponseUserBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'image':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.image = valueDes;
          break;
        case r'emailVerified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.emailVerified = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VerifyEmailGet200ResponseUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VerifyEmailGet200ResponseUserBuilder();
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
