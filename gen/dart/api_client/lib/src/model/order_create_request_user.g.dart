// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCreateRequestUserCWProxy {
  OrderCreateRequestUser id(String? id);

  OrderCreateRequestUser name(String? name);

  OrderCreateRequestUser email(String? email);

  OrderCreateRequestUser emailVerified(bool? emailVerified);

  OrderCreateRequestUser image(String? image);

  OrderCreateRequestUser role(OrderCreateRequestUserRoleEnum? role);

  OrderCreateRequestUser banned(bool? banned);

  OrderCreateRequestUser banReason(String? banReason);

  OrderCreateRequestUser banExpires(DateTime? banExpires);

  OrderCreateRequestUser gender(OrderCreateRequestUserGenderEnum? gender);

  OrderCreateRequestUser phone(String? phone);

  OrderCreateRequestUser createdAt(DateTime? createdAt);

  OrderCreateRequestUser updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequestUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequestUser(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequestUser call({
    String? id,
    String? name,
    String? email,
    bool? emailVerified,
    String? image,
    OrderCreateRequestUserRoleEnum? role,
    bool? banned,
    String? banReason,
    DateTime? banExpires,
    OrderCreateRequestUserGenderEnum? gender,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderCreateRequestUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderCreateRequestUser.copyWith.fieldName(...)`
class _$OrderCreateRequestUserCWProxyImpl
    implements _$OrderCreateRequestUserCWProxy {
  const _$OrderCreateRequestUserCWProxyImpl(this._value);

  final OrderCreateRequestUser _value;

  @override
  OrderCreateRequestUser id(String? id) => this(id: id);

  @override
  OrderCreateRequestUser name(String? name) => this(name: name);

  @override
  OrderCreateRequestUser email(String? email) => this(email: email);

  @override
  OrderCreateRequestUser emailVerified(bool? emailVerified) =>
      this(emailVerified: emailVerified);

  @override
  OrderCreateRequestUser image(String? image) => this(image: image);

  @override
  OrderCreateRequestUser role(OrderCreateRequestUserRoleEnum? role) =>
      this(role: role);

  @override
  OrderCreateRequestUser banned(bool? banned) => this(banned: banned);

  @override
  OrderCreateRequestUser banReason(String? banReason) =>
      this(banReason: banReason);

  @override
  OrderCreateRequestUser banExpires(DateTime? banExpires) =>
      this(banExpires: banExpires);

  @override
  OrderCreateRequestUser gender(OrderCreateRequestUserGenderEnum? gender) =>
      this(gender: gender);

  @override
  OrderCreateRequestUser phone(String? phone) => this(phone: phone);

  @override
  OrderCreateRequestUser createdAt(DateTime? createdAt) =>
      this(createdAt: createdAt);

  @override
  OrderCreateRequestUser updatedAt(DateTime? updatedAt) =>
      this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequestUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequestUser(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequestUser call({
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
    return OrderCreateRequestUser(
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
          : role as OrderCreateRequestUserRoleEnum?,
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
          : gender as OrderCreateRequestUserGenderEnum?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
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

extension $OrderCreateRequestUserCopyWith on OrderCreateRequestUser {
  /// Returns a callable class that can be used as follows: `instanceOfOrderCreateRequestUser.copyWith(...)` or like so:`instanceOfOrderCreateRequestUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCreateRequestUserCWProxy get copyWith =>
      _$OrderCreateRequestUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateRequestUser _$OrderCreateRequestUserFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderCreateRequestUser', json, ($checkedConvert) {
  final val = OrderCreateRequestUser(
    id: $checkedConvert('id', (v) => v as String?),
    name: $checkedConvert('name', (v) => v as String?),
    email: $checkedConvert('email', (v) => v as String?),
    emailVerified: $checkedConvert('emailVerified', (v) => v as bool?),
    image: $checkedConvert('image', (v) => v as String?),
    role: $checkedConvert(
      'role',
      (v) => $enumDecodeNullable(_$OrderCreateRequestUserRoleEnumEnumMap, v),
    ),
    banned: $checkedConvert('banned', (v) => v as bool?),
    banReason: $checkedConvert('banReason', (v) => v as String?),
    banExpires: $checkedConvert(
      'banExpires',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    gender: $checkedConvert(
      'gender',
      (v) => $enumDecodeNullable(_$OrderCreateRequestUserGenderEnumEnumMap, v),
    ),
    phone: $checkedConvert('phone', (v) => v as String?),
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

Map<String, dynamic> _$OrderCreateRequestUserToJson(
  OrderCreateRequestUser instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'name': ?instance.name,
  'email': ?instance.email,
  'emailVerified': ?instance.emailVerified,
  'image': ?instance.image,
  'role': ?_$OrderCreateRequestUserRoleEnumEnumMap[instance.role],
  'banned': ?instance.banned,
  'banReason': ?instance.banReason,
  'banExpires': ?instance.banExpires?.toIso8601String(),
  'gender': ?_$OrderCreateRequestUserGenderEnumEnumMap[instance.gender],
  'phone': ?instance.phone,
  'createdAt': ?instance.createdAt?.toIso8601String(),
  'updatedAt': ?instance.updatedAt?.toIso8601String(),
};

const _$OrderCreateRequestUserRoleEnumEnumMap = {
  OrderCreateRequestUserRoleEnum.admin: 'admin',
  OrderCreateRequestUserRoleEnum.operator_: 'operator',
  OrderCreateRequestUserRoleEnum.merchant: 'merchant',
  OrderCreateRequestUserRoleEnum.driver: 'driver',
  OrderCreateRequestUserRoleEnum.user: 'user',
};

const _$OrderCreateRequestUserGenderEnumEnumMap = {
  OrderCreateRequestUserGenderEnum.male: 'male',
  OrderCreateRequestUserGenderEnum.female: 'female',
};
