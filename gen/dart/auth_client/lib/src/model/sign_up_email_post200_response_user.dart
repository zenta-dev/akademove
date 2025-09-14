//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sign_up_email_post200_response_user.g.dart';

/// SignUpEmailPost200ResponseUser
///
/// Properties:
/// * [id] - The unique identifier of the user
/// * [email] - The email address of the user
/// * [name] - The name of the user
/// * [image] - The profile image URL of the user
/// * [emailVerified] - Whether the email has been verified
/// * [createdAt] - When the user was created
/// * [updatedAt] - When the user was last updated
@BuiltValue()
abstract class SignUpEmailPost200ResponseUser implements Built<SignUpEmailPost200ResponseUser, SignUpEmailPost200ResponseUserBuilder> {
  /// The unique identifier of the user
  @BuiltValueField(wireName: r'id')
  String get id;

  /// The email address of the user
  @BuiltValueField(wireName: r'email')
  String get email;

  /// The name of the user
  @BuiltValueField(wireName: r'name')
  String get name;

  /// The profile image URL of the user
  @BuiltValueField(wireName: r'image')
  String? get image;

  /// Whether the email has been verified
  @BuiltValueField(wireName: r'emailVerified')
  bool get emailVerified;

  /// When the user was created
  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  /// When the user was last updated
  @BuiltValueField(wireName: r'updatedAt')
  DateTime get updatedAt;

  SignUpEmailPost200ResponseUser._();

  factory SignUpEmailPost200ResponseUser([void updates(SignUpEmailPost200ResponseUserBuilder b)]) = _$SignUpEmailPost200ResponseUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignUpEmailPost200ResponseUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignUpEmailPost200ResponseUser> get serializer => _$SignUpEmailPost200ResponseUserSerializer();
}

class _$SignUpEmailPost200ResponseUserSerializer implements PrimitiveSerializer<SignUpEmailPost200ResponseUser> {
  @override
  final Iterable<Type> types = const [SignUpEmailPost200ResponseUser, _$SignUpEmailPost200ResponseUser];

  @override
  final String wireName = r'SignUpEmailPost200ResponseUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignUpEmailPost200ResponseUser object, {
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
    if (object.image != null) {
      yield r'image';
      yield serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      );
    }
    yield r'emailVerified';
    yield serializers.serialize(
      object.emailVerified,
      specifiedType: const FullType(bool),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updatedAt';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SignUpEmailPost200ResponseUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SignUpEmailPost200ResponseUserBuilder result,
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
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
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
  SignUpEmailPost200ResponseUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignUpEmailPost200ResponseUserBuilder();
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

