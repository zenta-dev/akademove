// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserCWProxy {
  User id(String id);

  User name(String name);

  User email(String email);

  User emailVerified(bool emailVerified);

  User image(String? image);

  User role(UserRole role);

  User banned(bool banned);

  User banReason(String? banReason);

  User banExpires(DateTime? banExpires);

  User gender(UserGender? gender);

  User phone(Phone phone);

  User createdAt(DateTime createdAt);

  User updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `User(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ````
  User call({
    String id,
    String name,
    String email,
    bool emailVerified,
    String? image,
    UserRole role,
    bool banned,
    String? banReason,
    DateTime? banExpires,
    UserGender? gender,
    Phone phone,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUser.copyWith.fieldName(...)`
class _$UserCWProxyImpl implements _$UserCWProxy {
  const _$UserCWProxyImpl(this._value);

  final User _value;

  @override
  User id(String id) => this(id: id);

  @override
  User name(String name) => this(name: name);

  @override
  User email(String email) => this(email: email);

  @override
  User emailVerified(bool emailVerified) => this(emailVerified: emailVerified);

  @override
  User image(String? image) => this(image: image);

  @override
  User role(UserRole role) => this(role: role);

  @override
  User banned(bool banned) => this(banned: banned);

  @override
  User banReason(String? banReason) => this(banReason: banReason);

  @override
  User banExpires(DateTime? banExpires) => this(banExpires: banExpires);

  @override
  User gender(UserGender? gender) => this(gender: gender);

  @override
  User phone(Phone phone) => this(phone: phone);

  @override
  User createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  User updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `User(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ````
  User call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? emailVerified = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? banned = const $CopyWithPlaceholder(),
    Object? banReason = const $CopyWithPlaceholder(),
    Object? banExpires = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return User(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      emailVerified: emailVerified == const $CopyWithPlaceholder()
          ? _value.emailVerified
          // ignore: cast_nullable_to_non_nullable
          : emailVerified as bool,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UserRole,
      banned: banned == const $CopyWithPlaceholder()
          ? _value.banned
          // ignore: cast_nullable_to_non_nullable
          : banned as bool,
      banReason: banReason == const $CopyWithPlaceholder()
          ? _value.banReason
          // ignore: cast_nullable_to_non_nullable
          : banReason as String?,
      banExpires: banExpires == const $CopyWithPlaceholder()
          ? _value.banExpires
          // ignore: cast_nullable_to_non_nullable
          : banExpires as DateTime?,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as UserGender?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as Phone,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $UserCopyWith on User {
  /// Returns a callable class that can be used as follows: `instanceOfUser.copyWith(...)` or like so:`instanceOfUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserCWProxy get copyWith => _$UserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => $checkedCreate('User', json, (
  $checkedConvert,
) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'email',
      'emailVerified',
      'role',
      'banned',
      'phone',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = User(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String),
    emailVerified: $checkedConvert('emailVerified', (v) => v as bool),
    image: $checkedConvert('image', (v) => v as String?),
    role: $checkedConvert('role', (v) => $enumDecode(_$UserRoleEnumMap, v)),
    banned: $checkedConvert('banned', (v) => v as bool),
    banReason: $checkedConvert('banReason', (v) => v as String?),
    banExpires: $checkedConvert(
      'banExpires',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    gender: $checkedConvert(
      'gender',
      (v) => $enumDecodeNullable(_$UserGenderEnumMap, v),
    ),
    phone: $checkedConvert(
      'phone',
      (v) => Phone.fromJson(v as Map<String, dynamic>),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'emailVerified': instance.emailVerified,
  'image': ?instance.image,
  'role': _$UserRoleEnumMap[instance.role]!,
  'banned': instance.banned,
  'banReason': ?instance.banReason,
  'banExpires': ?instance.banExpires?.toIso8601String(),
  'gender': ?_$UserGenderEnumMap[instance.gender],
  'phone': instance.phone.toJson(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.operator_: 'operator',
  UserRole.merchant: 'merchant',
  UserRole.driver: 'driver',
  UserRole.user: 'user',
};

const _$UserGenderEnumMap = {
  UserGender.male: 'male',
  UserGender.female: 'female',
};
