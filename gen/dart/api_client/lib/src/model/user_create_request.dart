//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_create_request.g.dart';

/// UserCreateRequest
///
/// Properties:
/// * [name] 
/// * [email] 
/// * [role] 
/// * [password] 
/// * [confirmPassword] 
@BuiltValue()
abstract class UserCreateRequest implements Built<UserCreateRequest, UserCreateRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'role')
  UserCreateRequestRoleEnum? get role;
  // enum roleEnum {  admin,  operator,  merchant,  driver,  user,  };

  @BuiltValueField(wireName: r'password')
  String get password;

  @BuiltValueField(wireName: r'confirmPassword')
  String get confirmPassword;

  UserCreateRequest._();

  factory UserCreateRequest([void updates(UserCreateRequestBuilder b)]) = _$UserCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserCreateRequestBuilder b) => b
      ..role = const UserCreateRequestRoleEnum._('user');

  @BuiltValueSerializer(custom: true)
  static Serializer<UserCreateRequest> get serializer => _$UserCreateRequestSerializer();
}

class _$UserCreateRequestSerializer implements PrimitiveSerializer<UserCreateRequest> {
  @override
  final Iterable<Type> types = const [UserCreateRequest, _$UserCreateRequest];

  @override
  final String wireName = r'UserCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserCreateRequest object, {
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
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(UserCreateRequestRoleEnum),
      );
    }
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    yield r'confirmPassword';
    yield serializers.serialize(
      object.confirmPassword,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserCreateRequestBuilder result,
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
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserCreateRequestRoleEnum),
          ) as UserCreateRequestRoleEnum;
          result.role = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'confirmPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.confirmPassword = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserCreateRequestBuilder();
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

class UserCreateRequestRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'admin')
  static const UserCreateRequestRoleEnum admin = _$userCreateRequestRoleEnum_admin;
  @BuiltValueEnumConst(wireName: r'operator')
  static const UserCreateRequestRoleEnum operator_ = _$userCreateRequestRoleEnum_operator_;
  @BuiltValueEnumConst(wireName: r'merchant')
  static const UserCreateRequestRoleEnum merchant = _$userCreateRequestRoleEnum_merchant;
  @BuiltValueEnumConst(wireName: r'driver')
  static const UserCreateRequestRoleEnum driver = _$userCreateRequestRoleEnum_driver;
  @BuiltValueEnumConst(wireName: r'user')
  static const UserCreateRequestRoleEnum user = _$userCreateRequestRoleEnum_user;

  static Serializer<UserCreateRequestRoleEnum> get serializer => _$userCreateRequestRoleEnumSerializer;

  const UserCreateRequestRoleEnum._(String name): super(name);

  static BuiltSet<UserCreateRequestRoleEnum> get values => _$userCreateRequestRoleEnumValues;
  static UserCreateRequestRoleEnum valueOf(String name) => _$userCreateRequestRoleEnumValueOf(name);
}

