//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/ban_user_schema_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/update_user_password_request.dart';
import 'package:api_client/src/model/unban_user_schema_request.dart';
import 'package:api_client/src/model/update_user_role_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'user_update_request.g.dart';

/// UserUpdateRequest
///
/// Properties:
/// * [role] 
/// * [password] 
/// * [confirmPassword] 
/// * [banReason] 
/// * [banExpiresIn] 
/// * [id] 
@BuiltValue()
abstract class UserUpdateRequest implements Built<UserUpdateRequest, UserUpdateRequestBuilder> {
  /// Any Of [BanUserSchemaRequest], [UnbanUserSchemaRequest], [UpdateUserPasswordRequest], [UpdateUserRoleRequest]
  AnyOf get anyOf;

  UserUpdateRequest._();

  factory UserUpdateRequest([void updates(UserUpdateRequestBuilder b)]) = _$UserUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserUpdateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserUpdateRequest> get serializer => _$UserUpdateRequestSerializer();
}

class _$UserUpdateRequestSerializer implements PrimitiveSerializer<UserUpdateRequest> {
  @override
  final Iterable<Type> types = const [UserUpdateRequest, _$UserUpdateRequest];

  @override
  final String wireName = r'UserUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    UserUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  UserUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserUpdateRequestBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(UpdateUserRoleRequest), FullType(UpdateUserPasswordRequest), FullType(BanUserSchemaRequest), FullType(UnbanUserSchemaRequest), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class UserUpdateRequestRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'admin')
  static const UserUpdateRequestRoleEnum admin = _$userUpdateRequestRoleEnum_admin;
  @BuiltValueEnumConst(wireName: r'operator')
  static const UserUpdateRequestRoleEnum operator_ = _$userUpdateRequestRoleEnum_operator_;
  @BuiltValueEnumConst(wireName: r'merchant')
  static const UserUpdateRequestRoleEnum merchant = _$userUpdateRequestRoleEnum_merchant;
  @BuiltValueEnumConst(wireName: r'driver')
  static const UserUpdateRequestRoleEnum driver = _$userUpdateRequestRoleEnum_driver;
  @BuiltValueEnumConst(wireName: r'user')
  static const UserUpdateRequestRoleEnum user = _$userUpdateRequestRoleEnum_user;

  static Serializer<UserUpdateRequestRoleEnum> get serializer => _$userUpdateRequestRoleEnumSerializer;

  const UserUpdateRequestRoleEnum._(String name): super(name);

  static BuiltSet<UserUpdateRequestRoleEnum> get values => _$userUpdateRequestRoleEnumValues;
  static UserUpdateRequestRoleEnum valueOf(String name) => _$userUpdateRequestRoleEnumValueOf(name);
}

