// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverUserCWProxy {
  DriverUser id(String? id);

  DriverUser name(String? name);

  DriverUser email(String? email);

  DriverUser emailVerified(bool? emailVerified);

  DriverUser image(String? image);

  DriverUser role(UserRole? role);

  DriverUser banned(bool? banned);

  DriverUser banReason(String? banReason);

  DriverUser banExpires(DateTime? banExpires);

  DriverUser gender(UserGender? gender);

  DriverUser phone(Phone? phone);

  DriverUser createdAt(DateTime? createdAt);

  DriverUser updatedAt(DateTime? updatedAt);

  DriverUser badges(List<Badge>? badges);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverUser(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverUser call({
    String? id,
    String? name,
    String? email,
    bool? emailVerified,
    String? image,
    UserRole? role,
    bool? banned,
    String? banReason,
    DateTime? banExpires,
    UserGender? gender,
    Phone? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Badge>? badges,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDriverUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDriverUser.copyWith.fieldName(...)`
class _$DriverUserCWProxyImpl implements _$DriverUserCWProxy {
  const _$DriverUserCWProxyImpl(this._value);

  final DriverUser _value;

  @override
  DriverUser id(String? id) => this(id: id);

  @override
  DriverUser name(String? name) => this(name: name);

  @override
  DriverUser email(String? email) => this(email: email);

  @override
  DriverUser emailVerified(bool? emailVerified) =>
      this(emailVerified: emailVerified);

  @override
  DriverUser image(String? image) => this(image: image);

  @override
  DriverUser role(UserRole? role) => this(role: role);

  @override
  DriverUser banned(bool? banned) => this(banned: banned);

  @override
  DriverUser banReason(String? banReason) => this(banReason: banReason);

  @override
  DriverUser banExpires(DateTime? banExpires) => this(banExpires: banExpires);

  @override
  DriverUser gender(UserGender? gender) => this(gender: gender);

  @override
  DriverUser phone(Phone? phone) => this(phone: phone);

  @override
  DriverUser createdAt(DateTime? createdAt) => this(createdAt: createdAt);

  @override
  DriverUser updatedAt(DateTime? updatedAt) => this(updatedAt: updatedAt);

  @override
  DriverUser badges(List<Badge>? badges) => this(badges: badges);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverUser(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverUser call({
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
    Object? badges = const $CopyWithPlaceholder(),
  }) {
    return DriverUser(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      emailVerified: emailVerified == const $CopyWithPlaceholder()
          ? _value.emailVerified
          // ignore: cast_nullable_to_non_nullable
          : emailVerified as bool?,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UserRole?,
      banned: banned == const $CopyWithPlaceholder()
          ? _value.banned
          // ignore: cast_nullable_to_non_nullable
          : banned as bool?,
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
          : phone as Phone?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
      badges: badges == const $CopyWithPlaceholder()
          ? _value.badges
          // ignore: cast_nullable_to_non_nullable
          : badges as List<Badge>?,
    );
  }
}

extension $DriverUserCopyWith on DriverUser {
  /// Returns a callable class that can be used as follows: `instanceOfDriverUser.copyWith(...)` or like so:`instanceOfDriverUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverUserCWProxy get copyWith => _$DriverUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverUser _$DriverUserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverUser', json, ($checkedConvert) {
      final val = DriverUser(
        id: $checkedConvert('id', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String?),
        emailVerified: $checkedConvert('emailVerified', (v) => v as bool?),
        image: $checkedConvert('image', (v) => v as String?),
        role: $checkedConvert(
          'role',
          (v) => $enumDecodeNullable(_$UserRoleEnumMap, v),
        ),
        banned: $checkedConvert('banned', (v) => v as bool?),
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
          (v) => v == null ? null : Phone.fromJson(v as Map<String, dynamic>),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        badges: $checkedConvert(
          'badges',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Badge.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DriverUserToJson(DriverUser instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'name': ?instance.name,
      'email': ?instance.email,
      'emailVerified': ?instance.emailVerified,
      'image': ?instance.image,
      'role': ?_$UserRoleEnumMap[instance.role],
      'banned': ?instance.banned,
      'banReason': ?instance.banReason,
      'banExpires': ?instance.banExpires?.toIso8601String(),
      'gender': ?_$UserGenderEnumMap[instance.gender],
      'phone': ?instance.phone?.toJson(),
      'createdAt': ?instance.createdAt?.toIso8601String(),
      'updatedAt': ?instance.updatedAt?.toIso8601String(),
      'badges': ?instance.badges?.map((e) => e.toJson()).toList(),
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
