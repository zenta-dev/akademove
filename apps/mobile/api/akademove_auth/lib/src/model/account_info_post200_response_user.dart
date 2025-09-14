//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_info_post200_response_user.g.dart';

/// AccountInfoPost200ResponseUser
///
/// Properties:
/// * [id]
/// * [emailVerified]
/// * [name]
/// * [email]
/// * [image]
@BuiltValue()
abstract class AccountInfoPost200ResponseUser
    implements
        Built<AccountInfoPost200ResponseUser,
            AccountInfoPost200ResponseUserBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'emailVerified')
  bool get emailVerified;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'image')
  String? get image;

  AccountInfoPost200ResponseUser._();

  factory AccountInfoPost200ResponseUser(
          [void updates(AccountInfoPost200ResponseUserBuilder b)]) =
      _$AccountInfoPost200ResponseUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountInfoPost200ResponseUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountInfoPost200ResponseUser> get serializer =>
      _$AccountInfoPost200ResponseUserSerializer();
}

class _$AccountInfoPost200ResponseUserSerializer
    implements PrimitiveSerializer<AccountInfoPost200ResponseUser> {
  @override
  final Iterable<Type> types = const [
    AccountInfoPost200ResponseUser,
    _$AccountInfoPost200ResponseUser
  ];

  @override
  final String wireName = r'AccountInfoPost200ResponseUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountInfoPost200ResponseUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'emailVerified';
    yield serializers.serialize(
      object.emailVerified,
      specifiedType: const FullType(bool),
    );
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
    if (object.image != null) {
      yield r'image';
      yield serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountInfoPost200ResponseUser object, {
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
    required AccountInfoPost200ResponseUserBuilder result,
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
        case r'emailVerified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.emailVerified = valueDes;
          break;
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
        case r'image':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.image = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountInfoPost200ResponseUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountInfoPost200ResponseUserBuilder();
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
