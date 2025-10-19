// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_order_request_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertOrderRequestUserCWProxy {
  InsertOrderRequestUser id(String? id);

  InsertOrderRequestUser name(String? name);

  InsertOrderRequestUser email(String? email);

  InsertOrderRequestUser emailVerified(bool? emailVerified);

  InsertOrderRequestUser image(String? image);

  InsertOrderRequestUser role(InsertOrderRequestUserRoleEnum? role);

  InsertOrderRequestUser banned(bool? banned);

  InsertOrderRequestUser banReason(String? banReason);

  InsertOrderRequestUser banExpires(DateTime? banExpires);

  InsertOrderRequestUser gender(InsertOrderRequestUserGenderEnum? gender);

  InsertOrderRequestUser phone(Phone? phone);

  InsertOrderRequestUser createdAt(DateTime? createdAt);

  InsertOrderRequestUser updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertOrderRequestUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertOrderRequestUser(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertOrderRequestUser call({
    String? id,
    String? name,
    String? email,
    bool? emailVerified,
    String? image,
    InsertOrderRequestUserRoleEnum? role,
    bool? banned,
    String? banReason,
    DateTime? banExpires,
    InsertOrderRequestUserGenderEnum? gender,
    Phone? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertOrderRequestUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertOrderRequestUser.copyWith.fieldName(...)`
class _$InsertOrderRequestUserCWProxyImpl
    implements _$InsertOrderRequestUserCWProxy {
  const _$InsertOrderRequestUserCWProxyImpl(this._value);

  final InsertOrderRequestUser _value;

  @override
  InsertOrderRequestUser id(String? id) => this(id: id);

  @override
  InsertOrderRequestUser name(String? name) => this(name: name);

  @override
  InsertOrderRequestUser email(String? email) => this(email: email);

  @override
  InsertOrderRequestUser emailVerified(bool? emailVerified) =>
      this(emailVerified: emailVerified);

  @override
  InsertOrderRequestUser image(String? image) => this(image: image);

  @override
  InsertOrderRequestUser role(InsertOrderRequestUserRoleEnum? role) =>
      this(role: role);

  @override
  InsertOrderRequestUser banned(bool? banned) => this(banned: banned);

  @override
  InsertOrderRequestUser banReason(String? banReason) =>
      this(banReason: banReason);

  @override
  InsertOrderRequestUser banExpires(DateTime? banExpires) =>
      this(banExpires: banExpires);

  @override
  InsertOrderRequestUser gender(InsertOrderRequestUserGenderEnum? gender) =>
      this(gender: gender);

  @override
  InsertOrderRequestUser phone(Phone? phone) => this(phone: phone);

  @override
  InsertOrderRequestUser createdAt(DateTime? createdAt) =>
      this(createdAt: createdAt);

  @override
  InsertOrderRequestUser updatedAt(DateTime? updatedAt) =>
      this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertOrderRequestUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertOrderRequestUser(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertOrderRequestUser call({
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
    return InsertOrderRequestUser(
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
          : role as InsertOrderRequestUserRoleEnum?,
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
          : gender as InsertOrderRequestUserGenderEnum?,
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
    );
  }
}

extension $InsertOrderRequestUserCopyWith on InsertOrderRequestUser {
  /// Returns a callable class that can be used as follows: `instanceOfInsertOrderRequestUser.copyWith(...)` or like so:`instanceOfInsertOrderRequestUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertOrderRequestUserCWProxy get copyWith =>
      _$InsertOrderRequestUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertOrderRequestUser _$InsertOrderRequestUserFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InsertOrderRequestUser', json, ($checkedConvert) {
  final val = InsertOrderRequestUser(
    id: $checkedConvert('id', (v) => v as String?),
    name: $checkedConvert('name', (v) => v as String?),
    email: $checkedConvert('email', (v) => v as String?),
    emailVerified: $checkedConvert('emailVerified', (v) => v as bool?),
    image: $checkedConvert('image', (v) => v as String?),
    role: $checkedConvert(
      'role',
      (v) => $enumDecodeNullable(_$InsertOrderRequestUserRoleEnumEnumMap, v),
    ),
    banned: $checkedConvert('banned', (v) => v as bool?),
    banReason: $checkedConvert('banReason', (v) => v as String?),
    banExpires: $checkedConvert(
      'banExpires',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    gender: $checkedConvert(
      'gender',
      (v) => $enumDecodeNullable(_$InsertOrderRequestUserGenderEnumEnumMap, v),
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
  );
  return val;
});

Map<String, dynamic> _$InsertOrderRequestUserToJson(
  InsertOrderRequestUser instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'name': ?instance.name,
  'email': ?instance.email,
  'emailVerified': ?instance.emailVerified,
  'image': ?instance.image,
  'role': ?_$InsertOrderRequestUserRoleEnumEnumMap[instance.role],
  'banned': ?instance.banned,
  'banReason': ?instance.banReason,
  'banExpires': ?instance.banExpires?.toIso8601String(),
  'gender': ?_$InsertOrderRequestUserGenderEnumEnumMap[instance.gender],
  'phone': ?instance.phone?.toJson(),
  'createdAt': ?instance.createdAt?.toIso8601String(),
  'updatedAt': ?instance.updatedAt?.toIso8601String(),
};

const _$InsertOrderRequestUserRoleEnumEnumMap = {
  InsertOrderRequestUserRoleEnum.admin: 'admin',
  InsertOrderRequestUserRoleEnum.operator_: 'operator',
  InsertOrderRequestUserRoleEnum.merchant: 'merchant',
  InsertOrderRequestUserRoleEnum.driver: 'driver',
  InsertOrderRequestUserRoleEnum.user: 'user',
};

const _$InsertOrderRequestUserGenderEnumEnumMap = {
  InsertOrderRequestUserGenderEnum.male: 'male',
  InsertOrderRequestUserGenderEnum.female: 'female',
};
